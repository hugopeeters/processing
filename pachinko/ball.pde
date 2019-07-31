class Ball {

  PVector pos;
  PVector vel;
  color c = color(255, 255, 255, 150);
  float d = 25; //diameter
  float dampening = 0.9;


  Ball(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
  }

  void update() {
    //apply gravity
    vel.y += gravity;

    //check collisions
    for (Pin pin : pins) {
      if (pin.hit()) {
        float speed = vel.mag();
        PVector v2 = new PVector(pos.x - pin.pos.x, pos.y - pin.pos.y);
        v2 = v2.normalize().mult(speed * dampening);
        float angle = PVector.angleBetween(vel, v2);
        vel = v2.rotate(-angle + PI);
      }
    }

    //move
    pos.add(vel);
  }

  void show() {
    noStroke();
    fill(c);
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, d, d);
  }
}
