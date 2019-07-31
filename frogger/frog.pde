class Frog {

  PVector pos;
  float vel = 25;
  float r = 20;

  Frog() {
    pos = new PVector(width/2, height - 50);
  }

  void show() {
    ellipseMode(CENTER);
    ellipseMode(RADIUS);
    stroke(80, 150, 150);
    strokeWeight(4);
    fill(80, 200, 220);
    ellipse(pos.x, pos.y, r, r);
    //eyes
    strokeWeight(2);
    stroke(0);
    fill(0, 0, 255);
    ellipse(pos.x - r/2, pos.y -r/2, r/4, r/4);
    ellipse(pos.x + r/2, pos.y -r/2, r/4, r/4);
    fill(0);
    ellipse(pos.x - r/2, pos.y -r/2, r/12, r/12);
    ellipse(pos.x + r/2, pos.y -r/2, r/12, r/12);
  }

  void jump(int dir) {
    if (dir == 0) {
      pos.y -= vel;
    } else if (dir == 1) {
      pos.x += vel;
    } else if (dir == 2) {
      pos.y += vel;
    } else if (dir == 3) {
      pos.x -= vel;
    }
  }
}
