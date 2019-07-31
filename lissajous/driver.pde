class Driver {

  PVector pos, dotPos;
  String type;
  float speed;
  float diameter, r;
  float angle;

  Driver(PVector pos, String type, float speed, float diameter) {
    this.pos = pos;
    this.type = type;
    this.speed = speed;
    this.diameter = diameter;
    r = diameter / 2;
    angle = -PI/2;
    dotPos = new PVector(0, 0);
  }

  void render() {
    //circle
    stroke(255);
    strokeWeight(1);
    noFill();
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, diameter, diameter);
    //dot
    noStroke();
    fill(255);
    ellipse(dotPos.x, dotPos.y, 8, 8);
    //line
    stroke(255, 100);
    strokeWeight(1);
    noFill();
    if (type == "left") {
      line(0, dotPos.y, width, dotPos.y);
    } else {
      line(dotPos.x, 0, dotPos.x, height);
    }
  }

  void update() {
    angle -= baseSpeed * speed;
    dotPos.x = pos.x + r * cos(angle);
    dotPos.y = pos.y + r * sin(angle);
  }
}
