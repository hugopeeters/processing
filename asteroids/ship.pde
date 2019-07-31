class Ship {

  PVector pos = new PVector(width/2, height/2);
  PVector vel = new PVector(0, 0);
  float r = 10;
  float heading = 0;
  float rotation = 0;
  boolean boosting = false;

  Ship() {
  }

  void show() {
    pushMatrix();
    fill(0);
    stroke(255);
    strokeWeight(1);
    translate(pos.x, pos.y);
    rotate(heading + HALF_PI);
    triangle(-r, r, r, r, 0, -r);
    popMatrix();
  }

  void setRotation(float angle) {
    rotation = angle;
  }

  void turn() {
    heading += rotation;
  }

  void update() {
    if (boosting) {
      PVector force = PVector.fromAngle(heading);
      force.mult(0.33);
      vel.add(force);
    }
    pos.add(vel);
    vel.mult(0.99);
    vel.limit(5);
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

  boolean hits(Asteroid a) {
    float d = dist(pos.x, pos.y, a.pos.x, a.pos.y); 
    return d < a.r;
  }
}
