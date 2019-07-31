class Object {

  PVector pos, vel, acc;
  float diameter, mass;

  Object() {
    pos = new PVector(random(width), random(height));
    vel = new PVector(random(-10, 10), 0);
    acc = new PVector(0, 0);
    diameter = random(20, 60);
    mass = 4 / 3 * PI * (diameter / 2) * (diameter / 2) * (diameter / 2) / 1000;
  }

  void render() {
    noStroke();
    fill(255);
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, diameter, diameter);
  }

  void update() {
    if (pos.y + diameter / 2 < height) {
      applyForce(gravity);
    }
    vel.add(acc);
    pos.add(vel);

    if (pos.y + diameter * 0.5 >= height && vel.y > 0) {
      vel.y *= -0.75;
      vel.x *= 0.85;
    }
    if (pos.y + diameter * 0.5 >= height && vel.y <= 0.1 && vel.y >= -0.1) {
      vel.y = 0;
      vel.x *= 0.85;
    }
    if ((pos.x - diameter / 2 <= 0 && vel.x < 0) || (pos.x + diameter / 2 > width && vel.x > 0)) {
      vel.x *= -0.75;
    }
  }

  void applyForce(PVector force) {
    acc.add(force);
    vel.add(acc);
    acc.mult(0);
  }

  void checkCollision(Object x) {
    float dist = pos.dist(x.pos);
    if (dist <= (x.diameter / 2) + (diameter / 2)) {
      vel = vel.mult((mass - x.mass)/(mass + x.mass)).add(x.vel.mult(2*x.mass/(mass + x.mass)));
    }
  }
}
