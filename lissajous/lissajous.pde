Driver[] leftDrivers, topDrivers;
Curve[][] curves;
float baseSpeed = 0.02;
float cellSize = 100;
int rows, cols;

PVector pos;
float speed, diameter;
String type;

void setup() {
  size(1200, 1200);
  rows = floor(height / cellSize);
  cols = floor(width / cellSize);
  leftDrivers = new Driver[rows - 1];
  topDrivers = new Driver[cols - 1];
  curves = new Curve[rows - 1][cols - 1];

  for (int i = 0; i < leftDrivers.length; i++) {
    leftDrivers[i] = new Driver(new PVector(cellSize / 2, (i+1.5)*cellSize), type = "left", i + 1, 0.8 * cellSize);
  }
  for (int i = 0; i < topDrivers.length; i++) {
    topDrivers[i] = new Driver(new PVector((i+1.5)*cellSize, cellSize / 2), type = "top", -i - 1, 0.8 * cellSize);
  }
  for (int i = 0; i < rows - 1; i++) {
    for (int j = i; j < cols - 1; j++) {
      curves[i][j] = new Curve(new PVector((i+1.5)*cellSize, (j+1.5)*cellSize));
    }
  }
}

void draw() {
  background(0);
  for (int i = 0; i < leftDrivers.length; i++) {
    leftDrivers[i].update();
    leftDrivers[i].render();
  }
  for (int i = 0; i < topDrivers.length; i++) {
    topDrivers[i].update();
    topDrivers[i].render();
  }
  for (int i = 0; i < rows - 1; i++) {
    for (int j = i; j < cols - 1; j++) {
      curves[i][j].update(topDrivers[i].dotPos.x - topDrivers[i].pos.x, leftDrivers[j].dotPos.y - leftDrivers[j].pos.y);
      curves[i][j].render();
    }
  }
}
