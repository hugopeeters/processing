class Vehicle {

  PVector pos, vel, acc;
  float maxForce, maxVel;
  float r;
  DNA dna;
  float health;
  int birthDate;
  int age;
  int generation;
  int ancestor;
  float performance;
  boolean best;

  Vehicle(PVector pos, int ancestor) {
    this.pos = pos;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    maxForce = 1;
    maxVel = 5;
    r = 18;
    dna = new DNA();
    health = 1;
    birthDate = 0;
    generation = 0;
    this.ancestor = ancestor;
    performance = 100;
    best = false;
  }

  Vehicle(PVector pos, DNA dna, int gen, int ancestor) {
    this.pos = pos;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    maxForce = 1;
    maxVel = 5;
    r = 18;
    this.dna = dna;
    this.dna.mutate();
    health = 1;
    birthDate = frameCount;
    generation = gen;
    this.ancestor = ancestor;
    performance = 100;
    best = false;
  }

  void update() {
    if (acc.mag() == 0 && vel.mag() == 0) {
      acc = PVector.random2D().setMag(maxForce);
    }
    vel.add(acc);
    vel.limit(maxVel);
    pos.add(vel);
    acc.mult(0);
    health -= 0.01;
    age = floor((frameCount - birthDate) / frameRate);
    performance = health + age * 100;
    best = false;
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void seekList(ArrayList<Food> list) {
    float smallestDistance = 99999;
    Food closest = null;
    for (int i = list.size() - 1; i >= 0; i--) {
      float dist = dist(pos.x, pos.y, list.get(i).pos.x, list.get(i).pos.y);
      if (dist < 5) {
        //eat the food
        if (list.get(i).good) {
          health += 0.2;
        } else {
          health -= 0.75;
        }
        list.remove(i);
      } else if (((list.get(i).good && dist <= dna.goodRange) || (!list.get(i).good && dist <= dna.badRange)) && dist < smallestDistance) {
        smallestDistance = dist;
        closest = list.get(i);
      }
    }
    if (closest != null) {
      seek(closest);
    }
  }

  void seek(Food target) {
    PVector desiredVel = target.pos.copy().sub(pos);
    PVector steeringForce = desiredVel.sub(vel);
    if (target.good) {
      steeringForce.mult(dna.goodVel);
    } else {
      steeringForce.mult(dna.badVel);
    }
    steeringForce.limit(maxForce);
    applyForce(steeringForce);
  }

  void seekOthers() {
    float smallestDistance = 99999;
    Vehicle target = null;
    if (vehicles.size() > 2) {
      for (int i = 0; i < vehicles.size(); i++) {
        float dist = vehicles.get(i).pos.dist(pos);
        if (dist != 0 && dist < smallestDistance && dist < dna.otherRange) {
          smallestDistance = dist;
          target = vehicles.get(i);
        }
      }
      if (target != null) {
        seek(target);
      }
    }
  }

  void seek(Vehicle target) {
    PVector desiredVel = target.pos.copy().sub(pos);
    PVector steeringForce = desiredVel.sub(vel);
    steeringForce.mult(dna.otherVel);
    steeringForce.mult(target.health / dna.otherHealth);
    steeringForce.limit(maxForce);
    applyForce(steeringForce);
  }

  void avoidEdges() {
    if (pos.x < field[0].x + 5) {
      applyForce(new PVector(2, 0));
    }
    if (pos.x > field[1].x - 5) {
      applyForce(new PVector(-2, 0));
    }
    if (pos.y < field[0].y + 5) {
      applyForce(new PVector(0, 2));
    }
    if (pos.y > field[1].y - 5) { 
      applyForce(new PVector(0, -2));
    }
  }

  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(vel.heading() + PI/2);
    beginShape();
    //color c = lerpColor(color(255, 0, 0), color(0, 255, 0), health);
    //stroke(c);
    noStroke();
    fill(ancColors[ancestor]);
    vertex(0, 0 - r);
    vertex(0 - r/3, 0);
    vertex(0 + r/3, 0);
    endShape(CLOSE);
    //debugging visuals
    if (mousePressed && best) {
      noFill();
      ellipseMode(RADIUS);
      stroke(0, 255, 0, 200);
      line(0, 0, 0, -dna.goodVel * 20);
      ellipse(0, 0, dna.goodRange, dna.goodRange);
      stroke(255, 0, 0, 200);
      line(1, 0, 1, -dna.badVel * 20);
      ellipse(0, 0, dna.badRange, dna.badRange);
      stroke(141, 141, 255, 200);
      line(-1, 0, -1, -dna.otherVel * 20);
      ellipse(0, 0, dna.otherRange, dna.otherRange);
    }
    popMatrix();
  }
}
