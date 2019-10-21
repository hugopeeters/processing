int fieldResolution = 10;
float fieldScale = 0.001;
float changeRate = 0.0025;
int x, y;
float xoff, yoff;
float zoff = 0;

void setup() {
  size(1200, 800);
  colorMode(HSB, 255, 255, 255);
  rectMode(CENTER);
}

void draw() {
  background(0);

  for (x = 0; x < width; x += fieldResolution) {
    for (y = 0; y < height; y += fieldResolution) {
      xoff = x * fieldScale;
      yoff = y * fieldScale;
      float r = noise(xoff, yoff, zoff);
      PVector v = PVector.fromAngle(r * TWO_PI);

      //DRAW MODE COLORED VECTORS
      pushMatrix();
      translate(x, y);
      rotate(v.heading());
      stroke(255*r, 255, 255);
      line(0, 0, fieldResolution*0.75, 0);
      popMatrix();

      //DRAW MODE COLORS
      //fill(255*r, 255, 255);
      //rect(x, y, fieldResolution, fieldResolution);
    }
  }
  zoff += changeRate;
}
