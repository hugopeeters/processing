Target target;
Obstacle[] obs;
Ant[] ants;
float offset;
int popSize;
int lifespan;
int t;
int gen;
float maxfitness;
float prev_max;
int survivors;

void setup() {
  size(800, 800);
  colorMode(HSB);

  popSize = 50;
  lifespan = 200;
  offset = 50;
  target = new Target(700, 100, 25);
  obs = new Obstacle[5];
  ants = new Ant[popSize];
  t = 0;
  gen = 0;
  maxfitness = 0;
  survivors = 0;

  for (int i = 0; i < obs.length; i++) {
    obs[i] = new Obstacle();
  }
  for (int i = 0; i < popSize; i++) {
    ants[i] = new Ant(null);
  }
}

void draw() {
  background(51);
  target.show();
  for (int i = 0; i < obs.length; i++) {
    obs[i].show();
  }

  //ants
  if (t < lifespan) {
    for (int i = 0; i < popSize; i++) {
      ants[i].show();
      ants[i].move();
      if (ants[i].fitness > maxfitness) {
        maxfitness = ants[i].fitness;
      }
    }
    t++;
  } else {
    //selection
    for (int i = 0; i < popSize; i++) {
      if (random(maxfitness) < ants[i].fitness) {
        //survive
        survivors++;
        ants[i].survive();
        ants[i].pos = new PVector(offset, height - offset);
        ants[i].mutate();
      } else {
        //die
        ants[i] = new Ant(null);
      }
    }
    float delta = maxfitness - prev_max;
    println("Gen: " + gen);
    println("Max: " + maxfitness);
    println("Delta: " + delta);
    println("Survivors: " + survivors);
    println();

    //next generation
    survivors = 0;
    t = 0;
    prev_max = maxfitness;
    maxfitness = 0;
    gen++;
  }
}
