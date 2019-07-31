class Target {

  float x;
  float y;
  float r;

  Target(float x_, float y_, float r_) {
    x = x_;
    y = y_;
    r = r_;
  }

  void show() {
    noStroke();
    fill(255, 255, 255, 150);
    ellipseMode(CENTER);
    ellipse(x, y, r*2, r*2);
  }
}
