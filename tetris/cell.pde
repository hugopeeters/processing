class Cell{
  
  int i, j;
  boolean occupied;
  
  Cell(int i, int j){
    this.i = i;
    this.j = j;
    occupied = false;
  }
  
  void render(){
    float x = i * sz;
    float y = j * sz;
    noFill();
    stroke(58);
    strokeWeight(1);
    rect(x, y, sz, sz);
  }
}
