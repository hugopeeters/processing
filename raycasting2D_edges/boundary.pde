class Boundary {

  PVector a, b;
  
  Boundary(float x1, float y1, float x2, float y2) {
    this.a = new PVector(x1, y1);
    this.b = new PVector(x2, y2);
  }
  
  void render(){
    stroke(150, 150, 50);
    line(a.x, a.y, b.x, b.y);
  }
}