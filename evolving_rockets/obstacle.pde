class Obstacle {
  
  float px, py, w, h;
  
  Obstacle(){
    px = random(0, width);
    py = random(0, height);
    w = random(20, 200);
    h = random(20, 200);
  }
  
  void show(){
    noStroke();
    fill(255);
    rectMode(CENTER);
    rect(px, py, w, h);
  }
}
