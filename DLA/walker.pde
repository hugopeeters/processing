class Walker {

  PVector pos;
  Boolean stuck = false;
  float r = radius;
  int hue = 0; //rainbow start
  //int hue = 100; //lightning start

  Walker(PVector pos_) {
    pos = pos_;
  }

  void walk() {
    PVector vel = PVector.random2D();
    pos.add(vel);
    pos.x = constrain (pos.x, 0, width);
    pos.y = constrain(pos.y, 0, height);
  }

  boolean isStuck(ArrayList<Walker> others) {
    for (int i = 0; i < others.size(); i++) {
      float d = PVector.dist(others.get(i).pos, pos);
      if (d < r + others.get(i).r) { // && random(1) < stickiness) {
        stuck = true;
        return stuck;
      }
    }
    return false;
  }

  void show() {
    colorMode(HSB);
    noStroke();
    if (stuck) {
      //fill(180, 255, hue % 255); //lightning fill
      fill(hue % 360, 255, 255); //rainbow fill
      ellipse(pos.x, pos.y, r*2, r*2);
    } else {
      fill(0, 255, 255);
      ellipse(pos.x, pos.y, 2, 2);
    }
  }
}
