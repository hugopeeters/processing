int fieldResolution = 10;
float fieldScale = 0.001;
float changeRate = 0.0025;
int x, y;
float xoff, yoff;
float zoff = 0;

void setup() {
  size(1200, 800);
}

void draw() {
  background(0);
  stroke(255);

  for (x = 0; x < width; x += fieldResolution) {
    for (y = 0; y < height; y += fieldResolution) {
      xoff = x * fieldScale;
      yoff = y * fieldScale;
      float r = noise(xoff, yoff, zoff);
      pushMatrix();
      translate(x, y);
      PVector v = PVector.fromAngle(r * TWO_PI);
      rotate(v.heading());
      line(0, 0, fieldResolution, 0);
      popMatrix();
    }
  }
  zoff += changeRate;
}
