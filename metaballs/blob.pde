class Blob {

  PVector pos;
  float r;
  PVector vel;
  float acc;

  Blob (float x, float y) {
    pos = new PVector(x, y);
    r = random(10, 50);
    vel = PVector.random2D();
  }

  void update() {

    pos.add(vel);
    if (pos.x < 0 || pos.x > width) {
      vel.x *= -1;
    }
    if (pos.y < 0 || pos.y > height) {
      vel.y *= -1;
    }
  }

  void show() {
    noFill();
    stroke(0);
    strokeWeight(4);
    ellipse(pos.x, pos.y, r*2, r*2);
  }
}
