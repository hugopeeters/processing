class Cell {
  
  int i, j;
  float x, y;
  
  Cell(int i , int j) {
    this.i = i;
    this.j = j;
    x = i * cellSize;
    y = j * cellSize;
  }
  
  void render(){
    noFill();
    stroke(255);
    rect(x, y, cellSize, cellSize);
  }
}
