class Blob {

  PVector pos;
  float r;
  PVector vel;
  float acc;

  Blob (float x, float y) {
    pos = new PVector(x, y);
    r = random(10, 50);
    vel = new PVector(0, 0);
    acc = 0;
  }

  void update() {
    if (pos.y < height / 2) {
      acc = 2 / (r * (pos.y));
    } else {
      acc = -2 / (r * (800 - pos.y));
    }
    vel.y += acc;
    vel.y = constrain(vel.y, -30/r, 30/r);
    pos.add(vel);
    if (pos.y < 0 || pos.y > height) {
      vel.y *= -0.3;
    }
  }

  void show() {
    noFill();
    stroke(0);
    strokeWeight(4);
    ellipse(pos.x, pos.y, r*2, r*2);
  }
}
