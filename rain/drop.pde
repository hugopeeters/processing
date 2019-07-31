class Drop {

  PVector ppos, pos, vel, acc;
  float terminalvelocity = 10;
  float z;

  Drop() {
    ppos = new PVector(0, 0);
    pos = new PVector(0, 0);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  void randomize() {
    pos = new PVector(random(0, width), random(-2 * height, -100));
    ppos = pos.copy();
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    z = 3 * pow(random(0.5, 1), 3);
  }

  void update() {
    ppos = pos.copy();
    acc.add(gravity);
    float xOff = pos.x / width;
    float yOff = z;
    wind = w.copy();
    wind.x += 0.9 * (noise(xOff, yOff, wOff) - 0.2);
    wOff+= 0.05;

    acc.add(wind);

    vel.add(acc);
    vel.limit(terminalvelocity * z);
    pos.add(vel);
    if (pos.y > height && ppos.y > height) {
      randomize();
    }
    if (pos.x < 0 && ppos.x < 0) {
      pos.x = width;
      ppos.x = width;
    }
    if (pos.x > width && ppos.x > width) {
      pos.x = 0;
      ppos.x = 0;
    }
  }

  void render() {
    noFill();
    stroke(0, 100, 255, 150);
    strokeWeight(1 * z);
    line(ppos.x, ppos.y, pos.x, pos.y);
  }
}
