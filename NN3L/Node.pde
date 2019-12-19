class Node {
  
  PVector pos;
  float r;
  
  Node (float x, float y, float r) {
    pos = new PVector(x, y);
    this.r = r;
  }
  
  void render(){
    noStroke();
    fill(255);
    ellipse(pos.x, pos.y, r, r);
  }
  
}
