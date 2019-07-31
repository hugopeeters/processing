class Spaceship {

  PVector pos, vel, acc, thrust;
  float sz, heading, fuel;
  int dir;
  boolean boosting, landed, crashed;

  Spaceship() {
    pos = new PVector(width/2, 50);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    thrust = new PVector(0, 0);
    heading = 0;
    dir = 0;
    boosting = false;
    landed = false;
    crashed = false;
    sz = 10;
    fuel = 100;
  }

  void update() {
    if (!crashed) {
      boost();
      if (!landed) {
        turn();
        acc.add(G);
        vel.add(acc);
        pos.add(vel);
        acc.mult(0);
      }
      if (landed && boosting) {
        boost();
        vel.add(acc);
        pos.add(vel);
        acc.mult(0);
        landed = false;
      }
    }
    checkCollision();
  }


  void render() {
    noFill();
    stroke(255);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(heading);
    beginShape();
    vertex(0, -sz/2);
    vertex(-sz/2, sz/2);
    vertex(sz/2, sz/2);
    endShape(CLOSE);
    if (boosting && fuel > 0 && !crashed) {
      beginShape();
      vertex(-sz/4, sz/2);
      vertex(0, sz);
      vertex(sz/4, sz/2);
      endShape(CLOSE);
    }
    popMatrix();
  }

  void turn() {
    if (dir == 1) {
      heading += 0.1;
    } else if (dir == -1) {
      heading -= 0.1;
    } else if (dir == 0) {
      //don't turn
    }
  }

  void boost() {
    if (boosting && fuel > 0 && !crashed) {
      thrust = PVector.fromAngle(heading-radians(90));
      thrust.setMag(G.mag() * 15);
      fuel -= 0.2;
      acc.add(thrust);
    } else {
      thrust.mult(0);
    }
  }

  void checkCollision() {
    for (int i = 1; i < ground.vertices.size(); i++) {
      PVector prev = ground.vertices.get(i-1);
      PVector cur = ground.vertices.get(i);
      if (ship.pos.x >= prev.x && ship.pos.x <= cur.x) {
        float colY = cur.y - ((cur.x - ship.pos.x)*(cur.y - prev.y) / (cur.x - prev.x));
        if (ship.pos.y + sz > colY) {
          if (vel.y >= 0.5) {
            crashed = true;
          } else {
            landed = true;
          }
        }
      }
    }
    if (pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0){
      crashed = true;
    }
  }
}
