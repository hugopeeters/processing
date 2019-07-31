Cell[][] grid;
Cell[][] next;
int n;
boolean running;
float sz;

void setup() {
  size(1200, 1200);
  sz = 10;
  n = floor(width/sz);
  grid = new Cell[n][n];
  next = new Cell[n][n];
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      grid[i][j] = new Cell(i, j);
    }
  }
  running = false;
}

void draw() {
  background(51);
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      grid[i][j].render();
    }
  }
  if (running && frameCount % 5 == 0) {
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        next[i][j] = grid[i][j].next();
      }
    }
    grid = next;
  }
}


void mouseClicked() {
  int i = floor(mouseX/sz);
  int j = floor(mouseY/sz);
  grid[i][j].toggle();
}

void keyPressed() {
  if (key == ' ') {
    running = !running;
  }
}
