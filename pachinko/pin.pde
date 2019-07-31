class Pin {
 
  PVector pos;
  float d = 3; //diameter
  color c = color(255,255,255);
  
  Pin (float x, float y){
    pos = new PVector(x, y);
  }
  
  void show(){
    noStroke();
    fill(c);
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, d, d);
  }
  
  boolean hit() {
    float dis = dist(pos.x, pos.y, ball.pos.x, ball.pos.y);
    return (dis < d / 2 + ball.d / 2);
  }
  
  
}
