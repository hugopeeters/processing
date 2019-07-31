class Square {
  float x, y, d;
  char t;
  int textSize = 32;

  Square(float x_, float y_, float d_, char t_) {
    x = x_;
    y = y_;
    d = d_;
    t = t_;
  }

  void show() {
    rectMode(CENTER);
    noFill();
    strokeWeight(4);
    stroke(0);
    rect(x, y, d, d);
    
    textAlign(CENTER, CENTER);
    textSize(textSize);
    fill(0);
    text(t, x, y);
  }
}
