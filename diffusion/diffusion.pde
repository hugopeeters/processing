Cell[][] grid;
Cell[][] next;
float dA = 1.0;
float dB = 0.5;
float feed = 0.055;
float k = 0.063; //0.061; //0.062;
float dt = 1;

void setup(){
  frameRate(120);
  size(200, 200);
  
  grid = new Cell[width][height];
  next = new Cell[width][height];
  for (int i = 0; i < width; i++){
    for (int j = 0; j < height; j++){
      grid[i][j] = new Cell(1, 0);
      next[i][j] = new Cell(1, 0);
    }
  }
  for (int x = width / 2 - 10; x < width / 2 + 10; x++){
    for (int y = height / 2 - 10; y < height / 2 + 10; y++){
      grid[x][y].a = 0;
      grid[x][y].b = 1;
    }
  }
}

void draw() {
  //calculate next values
  for (int i = 1; i < width-1; i++){
    for (int j = 1; j < height-1; j++){
      float a = grid[i][j].a;
      float b = grid[i][j].b;
      next[i][j].a = (a + (dA * laplaceA(i, j) - a * b * b + feed * (1 - a))) * dt;
      next[i][j].b = (b + (dB * laplaceB(i, j) + a * b * b - (k + feed) * b)) * dt;
    }
  }
  //display next values based on grid
  background(51);
  noStroke();
  for (int i = 0; i < width; i++){
    for (int j = 0; j < height; j++){
      fill(floor(next[i][j].a * 255), 0, floor(next[i][j].b * 255));
      rect(i, j, 1, 1);
    }
  }
  //swap grid with next
  swap();
}

float laplaceA(int i, int j) {
  float sum = 0;
  sum += grid[i][j].a * -1;
  sum += grid[i+1][j].a * 0.2;
  sum += grid[i][j+1].a * 0.2;
  sum += grid[i-1][j].a * 0.2;
  sum += grid[i][j-1].a * 0.2;
  sum += grid[i+1][j+1].a * 0.05;
  sum += grid[i+1][j-1].a * 0.05;
  sum += grid[i-1][j+1].a * 0.05;
  sum += grid[i-1][j-1].a * 0.05;
  return sum;
}

float laplaceB(int i, int j) {
  float sum = 0;
  sum += grid[i][j].b * -1;
  sum += grid[i+1][j].b * 0.2;
  sum += grid[i][j+1].b * 0.2;
  sum += grid[i-1][j].b * 0.2;
  sum += grid[i][j-1].b * 0.2;
  sum += grid[i+1][j+1].b * 0.05;
  sum += grid[i+1][j-1].b * 0.05;
  sum += grid[i-1][j+1].b * 0.05;
  sum += grid[i-1][j-1].b * 0.05;
  return sum;
}

void swap(){
  Cell[][] temp = grid;
  grid = next;
  next = temp;
}
