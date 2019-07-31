class Ant {

  PVector pos;
  float size = 5;
  PVector[] steps;
  boolean dead = false;
  float speed = 10;
  float fitness = 0;
  float reward = 10;
  float penalty = 1;
  int age = 0;
  float stability = 200;

  Ant(PVector[] steps_) {
    pos = new PVector(offset, height - offset);
    if (steps_ != null) {
      steps = steps_;
    } else {
      steps = new PVector[lifespan];
      for (int i = 0; i < lifespan; i++) {
        steps[i] = PVector.random2D().mult(speed);
      }
    }
  }

  void move() {
    if (!dead) {
      //step
      pos.add(steps[t]);

      //fitness
      float d = dist(pos.x, pos.y, target.x, target.y);
      fitness = 1 / d;

      //goal
      if (d <= target.r) {
        dead = true;
        fitness *= reward;
      }

      //wall collisions
      if (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) {
        dead = true;
        fitness /= penalty;
      }

      //obstacle collisions
      for (int i = 0; i < obs.length; i++) {
        if (pos.x > obs[i].x - obs[i].w / 2 && pos.x < obs[i].x + obs[i].w / 2 && pos.y > obs[i].y - obs[i].h / 2 && pos.y < obs[i].y + obs[i].h / 2) {
          dead = true;
          fitness /= penalty;
        }
      }
    }
  }

  void show() {
    noStroke();
    fill(constrain(age * 5, 0, 255), 255, 255, 150);
    rectMode(CENTER);
    rect(pos.x, pos.y, size, size);
  }

  void survive() {
    age++;
  }

  void mutate() {
    for (int i = 0; i < lifespan; i++) {
      if (random(1) < (1 / stability)) {
        steps[i] = PVector.random2D().mult(speed);
      }
    }
  }
}
