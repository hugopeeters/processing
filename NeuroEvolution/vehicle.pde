class Vehicle {

  PVector pos, vel, acc, nearestFood;
  float maxForce, maxVel;
  float r;
  NN brain;
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
    brain = new NN(input_count, hidden_count, output_count);
    health = 1;
    birthDate = 0;
    generation = 0;
    this.ancestor = ancestor;
    performance = 100;
    best = false;
    nearestFood = new PVector(0, 0);
  }

  Vehicle(PVector pos, NN brain, int gen, int ancestor) {
    this.pos = pos;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    maxForce = 1;
    maxVel = 5;
    r = 18;
    this.brain = brain.copy();
    this.brain.mutate();
    health = 1;
    birthDate = frameCount;
    generation = gen;
    this.ancestor = ancestor;
    performance = 100;
    best = false;
    nearestFood = new PVector(0, 0);
  }

  void update() {
    //gather sensory inputs
    nearestFood = seekList(food);
    this.brain.inputs.data[0][0] = nearestFood.x / 400; //vector to food x
    this.brain.inputs.data[1][0] = nearestFood.y / 400; //vector to food y


    //think about actions to take
    Matrix actions = this.brain.predict();
    PVector desiredVel = new PVector(actions.data[0][0] * 400, actions.data[1][0] * 400);
    PVector steeringForce = desiredVel.copy().sub(this.vel);
    steeringForce.limit(maxForce);

    //act
    applyForce(steeringForce);

    //apply physics
    //if (acc.mag() == 0 && vel.mag() == 0) {
    //  acc = PVector.random2D().setMag(maxForce);
    //}
    vel.add(acc);
    vel.limit(maxVel);
    pos.add(vel);
    acc.mult(0);

    //use up energy
    health -= 0.01;

    //update stats
    age = floor((frameCount - birthDate) / frameRate);
    performance = health + age * 100;
    best = false;
  }

  void applyForce(PVector force) {
    acc.add(force);
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

  PVector seekList(ArrayList<Food> list) {
    Food closest = null;
    PVector returnVector = new PVector(0, 0);
    for (int i = list.size() - 1; i >= 0; i--) {
      float dist = dist(pos.x, pos.y, list.get(i).pos.x, list.get(i).pos.y);
      if (dist < 5) {
        //eat the food
        if (list.get(i).good) {
          this.health += 0.2;
        } else {
          this.health -= 0.75;
        }
        list.remove(i);
      } else {
        closest = list.get(i);
      }
    }
    if (closest != null) {
      returnVector.x = closest.pos.x - this.pos.x;
      returnVector.y = closest.pos.y - this.pos.y;
    } 
    return returnVector;
  }

  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    stroke(255);
    line(0, 0, nearestFood.x, nearestFood.y);
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
    popMatrix();
  }
}
