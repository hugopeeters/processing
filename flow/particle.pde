class Particle {

  PVector ppos, pos, vel, acc;
  float radius;

  Particle(PVector pos) {
    this.pos = pos;
    ppos = pos.copy();
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    radius = 2;
  }

  void render() {
    //noStroke();
    //fill(frameCount / 10 % 255, 255, 255, 100);
    //ellipse(pos.x, pos.y, radius, radius);
    strokeWeight(1);
    stroke(frameCount / 10 % 255, 255, 255, lineOpacity);
    //stroke(random(25), 255, 255, lineOpacity);
    line(ppos.x, ppos.y, pos.x, pos.y);
  }

  void update() {
    PVector force = flowfield[round(pos.x/fieldResolution)][round(pos.y/fieldResolution)];
    force.setMag(fieldForce);
    acc.add(force);
    vel.add(acc);
    vel.limit(maxVel);
    ppos = pos.copy();
    pos.add(vel);
    if (pos.x <= 0) { 
      pos.x += width;
      ppos.x += width;
    }
    if (pos.x >= width) { 
      pos.x -= width;
      ppos.x -= width;
    }
    if (pos.y <= 0) { 
      pos.y += height;
      ppos.y += height;
    }
    if (pos.y >= height) { 
      pos.y -= height;
      ppos.y -= height;
    }
    acc.setMag(0);
  }
}
