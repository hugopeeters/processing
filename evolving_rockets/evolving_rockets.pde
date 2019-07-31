Rocket[] population;
int popSize;
int t;
int lifespan;
Target target;
Obstacle[] obstacles;
int numMut = 0;
int generation = 1;

void setup() {
  size(800, 800);
  colorMode(HSB);
  target = new Target(700, 100, 25);
  obstacles = new Obstacle[10];
  for (int i = 0; i < obstacles.length; i++) {
    obstacles[i] = new Obstacle();
  }
  popSize = 100;
  population = new Rocket[popSize];
  lifespan = 300;
  for (int i = 0; i < population.length; i++) {
    population[i] = new Rocket(null, color(0, 255, 255, 150));
  }
  t = 0;
}

void draw() {
  background(51);
  target.show();
  for (int i = 0; i < obstacles.length; i++) {
    obstacles[i].show();
  }
  for (int i = 0; i < population.length -1; i++) {
    population[i].update();
    population[i].show();
  }
  t++;
  if (t == lifespan) {
    //create mating pool
    ArrayList<Rocket> matingPool = new ArrayList<Rocket>();
    float maxfitness = 0;
    for (int i = 0; i < population.length -1; i++) {
      if (population[i].fitness > maxfitness) {
        maxfitness = population[i].fitness;
      }
    }
    for (int i = 0; i < population.length -1; i++) {
      //normalize fitness
      population[i].fitness /= maxfitness;
    }    
    for (int i = 0; i < population.length -1; i++) {
      //add rocket multiple times based on fitness
      for (int j = 0; j < floor(5*population[i].fitness); j++) {
        matingPool.add(population[i]);
      }
    }
    print("Mating pool size: ");
    println(matingPool.size());
    print("Maximum fitness: ");
    println(maxfitness);

    //combine dna of random parents from the mating pool
    Rocket[] newPop = new Rocket[popSize];
    for (int i = 0; i < popSize; i++) {
      int indexA = floor(random(0, matingPool.size()));
      Rocket parentA = matingPool.get(indexA);
      int indexB = floor(random(0, matingPool.size()));
      Rocket parentB = matingPool.get(indexB);
      DNA newdna = parentA.dna.combine(parentB.dna);
      float fitSum = parentA.fitness + parentB.fitness;
      newPop[i] = new Rocket(newdna, color(constrain(30*fitSum, 0, 255), 255, 255, 150));
    }
    print("number of mutations: ");
    println(numMut);
    print("Generation: ");
    println(generation);
    println();
    generation++;
    numMut = 0;
    population = newPop;
    t = 0;
  }
}
