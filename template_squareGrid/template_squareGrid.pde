Cell[][] grid;
int n = 10;
float cellSize;

void setup() {
  size(601, 601);
  cellSize = floor(width/n);
  grid = new Cell[n][n];
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      grid[i][j] = new Cell(i, j);
    }
  }
}

void draw() {
  background(51);
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      Cell cell = grid[i][j];
      cell.render();
    }
  }
}
