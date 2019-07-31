class Pipe {

  float gapSize = random(75, height / 2);
  float gapY = random(25 + gapSize / 2, height - 25 - gapSize / 2);
  float w = 50;
  float x = width;
  float speed = 2;

  Pipe() {
  }

  void show() {
    fill(255);
    rect(x, 0, w, gapY - gapSize / 2);
    rect(x, gapY + gapSize / 2, w, height - gapY - gapSize / 2);
  }

  void update() {
    x -= speed;
  }

  boolean hits(Bird bird) {
    if (bird.x >= x && bird.x <= x + w && (bird.y < gapY - gapSize / 2 || bird.y > gapY + gapSize / 2)) {
      return true;
    } else {
      return false;
    }
  }
}
