class Section {

  PVector top, bottom;
  float l, angle, vel, acc, mg;

  Section(PVector top, float l, float angle) {
    this.l = l;
    this.angle = angle;
    this.top = new PVector(top.x, top.y);
    this.bottom = new PVector(top.x + l * cos(angle), top.y + l * sin(angle));
    vel = 0;
    acc = 0;
    mg = 0.001;
  }

  void render() {
    stroke(255);
    strokeWeight(2);
    line(top.x, top.y, bottom.x, bottom.y);
    noStroke();
    fill(255);
    ellipse(bottom.x, bottom.y, l/10, l/10);
  }

  void update() {
    acc = mg*sin(angle + PI/2);
    vel += acc;
    angle += vel;
    this.bottom = new PVector(top.x + l * cos(angle), top.y + l * sin(angle));
  }
}
