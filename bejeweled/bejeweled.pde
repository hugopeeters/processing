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
    for (int j = n - 1; j >= 0; j--) {
      Cell cell = grid[i][j];
      if(cell.gem == 0){
        if(j > 0){
          grid[i][j-1].fall();
        } else {
          cell.gem = round(random(1, 6));
        }
      }
      cell.render();
    }
  }
}

void mousePressed(){
  int i = floor(mouseX / cellSize);
  int j = floor(mouseY / cellSize);
  grid[i][j].gem = 0;
}

void checkNeighbors(Cell c){
  
}
