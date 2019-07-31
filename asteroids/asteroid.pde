class Asteroid {

  PVector pos;
  float r;
  int total;
  float[] offset;
  PVector vel;
  float scl;

  Asteroid(PVector pos, float scl) {
    this.scl = scl;
    if (pos == null) {
      this.pos = new PVector(random(width), random(height));
    } else {
      this.pos = new PVector(pos.x, pos.y);
    }
    vel = PVector.random2D();
    r = scl * random(30, 70);
    total = round(random(3, 10));
    offset = new float[total];
    for (int i = 0; i < total; i++) {
      offset[i] = random(-r * 0.8, r* 0.8);
    }
  }

  void show() {
    pushMatrix();
    translate(pos.x, pos.y);
    noFill();
    stroke(255);
    strokeWeight(1);
    beginShape();
    for (int i = 0; i < total; i++) {
      float angle = map(i, 0, total, 0, TWO_PI);
      float x = (r + offset[i]) * cos(angle);
      float y = (r + offset[i]) * sin(angle);
      vertex(x, y);
    }
    endShape(CLOSE);
    popMatrix();
  }

  void update() {
    pos.add(vel);
    //edges
    if (pos.x > width) {
      pos.x = 0;
    }
    if (pos.x < 0) {
      pos.x = width;
    }
    if (pos.y > height) {
      pos.y = 0;
    }
    if (pos.y < 0) {
      pos.y = height;
    }
  }

  Asteroid[] breakup() {
    Asteroid[] newAsteroids = new Asteroid[2];
    newAsteroids[0] = new Asteroid(pos, scl*0.6);
    newAsteroids[1] = new Asteroid(pos, scl*0.6);
    return newAsteroids;
  }
}
