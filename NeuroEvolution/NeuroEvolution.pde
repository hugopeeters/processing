//NeuralNetwork
int input_count = 2;
int hidden_count = 16;
int output_count = 2;

//vehicles
ArrayList<Vehicle> vehicles;
ArrayList<Food> food;
int numStarters = 100;

//screen layout
PVector[] field;

//charts
BarChart genChart;
StackedAreaChart ancChart;
color[] ancColors;
int[] generations;
ArrayList<int[]> ancestorSeries;
int maxGens;
BarChart ageChart;
int[] ages;
int maxAge;

void setup() {
  size(1700, 850);
  frameRate(30);

  //chart maximums
  maxGens = 40;
  maxAge = 40;
  
  //screen layout
  field = new PVector[2];
  field[0] = new PVector(25, 25);
  field[1] = new PVector(825, 825);
  generations = new int[maxGens];
  
  //coloring of vehicles
  ancColors = createColorArray(numStarters);
  
  //charts
  ancestorSeries = new ArrayList<int[]>();
  for (int i = 0; i < maxGens; i++) {
    generations[i] = 0;
  }
  genChart = new BarChart(new PVector(875, 25), 800, 125, generations, "GENERATION");
  ancChart = new StackedAreaChart(new PVector(875, 375), 800, 450, ancestorSeries, "ANCESTORS");
  ages = new int[maxAge];
  for (int i = 0; i < maxAge; i++) {
    ages[i] = 0;
  }
  ageChart = new BarChart(new PVector(875, 200), 800, 125, ages, "AGE");

  //create vehicles
  vehicles = new ArrayList<Vehicle>();
  for (int i = 0; i < numStarters; i++) {
    vehicles.add(new Vehicle(new PVector(random(field[0].x, field[1].x), random(field[0].y, field[1].y)), i));
  }

  //create food
  food = new ArrayList<Food>();
  //addPoison();
  addFood();
}

void draw() {
  background(26); 
  
  //render food
  for (int i = food.size() - 1; i >= 0; i--) {
    food.get(i).render();
  }

  //vehicles
  for (int i = vehicles.size() -1; i >= 0; i--) {
    Vehicle v = vehicles.get(i);
    
    //render vehicles
    v.render();

    //update vehicles
    v.avoidEdges();
    v.update();
    
    //clone
    if (random(1) < 0.015 * v.health) {
      vehicles.add(new Vehicle(new PVector(random(field[0].x, field[1].x), random(field[0].y, field[1].y)), v.brain.copy(), v.generation + 1, v.ancestor));
    }
    
    //death
    if (v.health <= 0) {
      //food.add(new Food(v.pos.copy(), true, food.size()));
      vehicles.remove(i);
    }
  }

  //keep adding food
  if (food.size() < 100 + vehicles.size()) {
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
  calculateStats();
  genChart.render();
  ancChart.render();
  ageChart.render();
}
