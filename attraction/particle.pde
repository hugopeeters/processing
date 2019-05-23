class Particle {

  PVector prev, pos, vel, acc;

  Particle(PVector pos) {
    this.pos = pos;
    prev = pos.copy();
    vel = new PVector(random(-vinit, vinit), random(-vinit, vinit));
    acc = new PVector(0, 0);
  }

  void render() {
    strokeWeight(strW);
    int v = round(vel.mag()); //the magnitude of the velocity
    int c = round(map(v * random(0.9, 1.1), 0, maxSpeed, 0, 100)); //color is mapped to the speed of the particle with some random difference to smooth out the gradients
    c = (c + colorOffset + frameCount/10) % 255; //drifting colors with frameCount and rolling over with modulo
    colorMode(HSB, 255, 100, 100);
    stroke(c, 100, 100, alpha);
    line(pos.x, pos.y, prev.x, prev.y);
    //point(pos.x, pos.y);
    prev = pos.copy();
  }

  void update() {
    vel.add(acc); //apply acceleration
    //limit speed
    if (vel.mag() > maxSpeed) {
      vel.setMag(maxSpeed);
    }
    acc.mult(0); //reset the acceleration
    pos.add(vel); //update the position
    //bounce off the walls
    if (pos.x < 0 || pos.x > width) {
      vel.x *= -1;
    }
    if (pos.y < 0 || pos.y > height) {
      vel.y *= -1;
    }
  }

  void getAttracted(Attractor a) {
    //attraction algorithm
    PVector force = a.pos.copy().sub(pos); //get the direction of the force
    float strength = a.mass / force.magSq(); //calculate the strength of the force
    strength = constrain(strength, 0.1, 50); //constrain the force's strength to prevent issues
    force.setMag(strength); //set the strength of the force
    acc.add(force); //apply the force
  }
}
