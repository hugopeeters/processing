int N = 50;
int numPatches;
int canvasSize = 1000;
float alpha = 1.75; //defection award factor 0 - 3.0
int dt = 10; //milliseconds delay between steps
Patch[] grid;

void settings() {
  size(canvasSize, canvasSize);
}

void setup() {
  numPatches = N*N;
  grid = new Patch[numPatches];
  for (int i = 0; i < numPatches; i++) {
    grid[i] = new Patch(i);
  }
}

void draw() {
  background(0);
  for (Patch p : grid) {
    p.update();
    p.render();
  }
  for (Patch p : grid) {
    p.next();
  }
  delay(dt);
}
