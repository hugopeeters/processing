class Rocket {

  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector gravity;
  DNA dna;
  color c;

  boolean dead = false;
  float fitness;

  Rocket(DNA dna_, color c_) {
    position = new PVector(50, height);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    gravity = new PVector(0, 0.055);
    c = c_;
    if (dna_ != null) {
      dna = dna_;
    } else {
      dna = new DNA();
    }
    fitness = 0;
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    if (t >= lifespan) {
      dead = true;
    }
    if (!dead) {
      applyForce(dna.genes[t]);
      velocity.add(acceleration);
      velocity.add(gravity);
      position.add(velocity);
      acceleration.mult(0);

      //fitness
      float D = dist(position.x, position.y, target.x, target.y);
      float f = 1 / (t+1) * D;
      if (f > fitness) {
        fitness = f;
      }

      //collision detection
      if (position.x < 0 || position.x > width || position.y < 0 || position.y > height) {
        dead = true;
        fitness /= 10;
      }
      for (int i = 0; i < obstacles.length; i++) {
        if (position.x > obstacles[i].px - obstacles[i].w / 2 && position.x < obstacles[i].px + obstacles[i].w / 2 && position.y > obstacles[i].py - obstacles[i].h / 2 && position.y < obstacles[i].py + obstacles[i].h / 2) {
          dead = true;
          fitness /= 10;
        }
      }
      if (dist(position.x, position.y, target.x, target.y) < target.r) {
        dead = true;
        fitness *= 10;
      }
    } else {
      //println(fitness);
    }
  }

  void show() {
    noStroke();
    fill(c);
    rectMode(CENTER);
    rect(position.x, position.y, 5, 10);
  }
}
