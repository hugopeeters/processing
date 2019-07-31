class Vehicle {

  PVector pos, vel, acc, tgt;
  float r = 8;
  float maxSpeed = 2;
  float maxForce = 0.1;

  Vehicle(float x, float y) {
    pos = new PVector(x, y);
    vel = PVector.random2D();
    acc = new PVector(0, 0);
    tgt = new PVector(random(width), random(height));
  }

  void update() {
    acc = seek();
    vel.add(acc);
    acc.mult(0);
    acc = avoid();
    vel.add(acc);
    acc.mult(0);
    pos.add(vel);
    if (pos.x <= 0 || pos.x >= width) {
      vel.x *= -0.95;
    }
    if (pos.y <= 0 || pos.y >= height) {
      vel.y *= -0.95;
    }
  }

  PVector seek() {
    PVector desired = new PVector(tgt.x - pos.x, tgt.y - pos.y);
    float d = desired.mag();
    desired.limit(maxSpeed);
    PVector force = new PVector(desired.x - vel.x, desired.y - vel.y);
    float forceMag = force.mag();
    if (d < 100) {
      forceMag = map(forceMag, 0, 100, maxForce, 0);
    }
    force.setMag(forceMag);
    return force;
  }

  PVector avoid() {
    PVector desired = new PVector(mouseX - pos.x, mouseY - pos.y);
    desired.mult(-1);
    float d = desired.mag();
    desired.limit(maxSpeed);
    PVector force = new PVector(desired.x - vel.x, desired.y - vel.y);
    float forceMag = force.mag();
    if (d < 100) {
      forceMag = map(forceMag, 0, 100, maxForce, 0);
    }
    force.setMag(forceMag);
    return force;
  }

  void show() {
    noStroke();
    fill(255, 150);
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, r, r);
  }
}
