import java.util.Collections;

//NeuralNetwork
int input_count = 2;
int hidden_count = 16;
int output_count = 2;

//vehicles
ArrayList<Generation> population;
ArrayList<Food> food;
int numStarters = 100;

//screen layout
PVector[] field;

//charts
BarChart genChart;
StackedAreaChart ancChart;
color[] ancColors;
ArrayList<int[]> ancestorSeries;
int maxGens;
BarChart ageChart;
int[] ages;
int maxAge;

void setup() {
  size(1700, 850);
  frameRate(30);

  //screen layout
  field = new PVector[2];
  field[0] = new PVector(25, 25);
  field[1] = new PVector(825, 825);
  
  //population
  population = new ArrayList<Generation>();

  //generation 0
  population.add(new Generation());
  population.get(0).spawnGenZero();

  //Prepare data series
  ancestorSeries = new ArrayList<int[]>();
  ages = new int[maxAge];
  for (int i = 0; i < maxAge; i++) {
    ages[i] = 0;
  }

  //coloring of vehicles
  ancColors = createColorArray(numStarters);

  //charts
  //genChart = new BarChart(new PVector(875, 25), 800, 125, generations, "GENERATION");
  ancChart = new StackedAreaChart(new PVector(875, 375), 800, 450, ancestorSeries, "ANCESTORS");
  ageChart = new BarChart(new PVector(875, 200), 800, 125, ages, "AGE");

  //create food
  food = new ArrayList<Food>();
  //addPoison();
  addFood();
}

void draw() {
  background(26); 

  Generation currentGen = population.get(population.size() - 1);

  //render food
  for (int i = food.size() - 1; i >= 0; i--) {
    food.get(i).render();
  }

  //vehicles
  int numAlive = 0;
  for (int i = currentGen.vehicles.size() - 1; i >= 0; i--) {
    Vehicle v = currentGen.vehicles.get(i);
    if (v.alive) {
      numAlive++;
      
      //render vehicles
      v.render();

      //update vehicles
      v.avoidEdges();
      v.update();

      //clone
      //if (random(1) < 0.015 * v.health) {
      //  vehicles.add(new Vehicle(new PVector(random(field[0].x, field[1].x), random(field[0].y, field[1].y)), v.brain.copy(), v.generation + 1, v.ancestor));
      //}

      //death
      if (v.health <= 0) {
        //food.add(new Food(v.pos.copy(), true, food.size()));
        currentGen.vehicles.get(i).die();
      }
    }
  }
  if (numAlive == 0){
    nextGen();
  }

  //keep adding food
  if (food.size() < 100 + currentGen.vehicles.size()) {
    //addPoison();
    addFood();
  }

  //playing field
  stroke(255);
  strokeWeight(1);
  noFill();
  rectMode(CORNERS);
  rect(field[0].x, field[0].y, field[1].x, field[1].y);

  //stats and charts
  //calculateStats();
  //genChart.render();
  //ancChart.render();
  //ageChart.render();
}
