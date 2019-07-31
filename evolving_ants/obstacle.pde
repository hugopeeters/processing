class Obstacle {
  
  float x, y, w, h;
  
  Obstacle(){
    x = random(0, width);
    y = random(0, height);
    w = random(20, 200);
    h = random(20, 200);
  }
  
  void show(){
    noStroke();
    fill(255);
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}
