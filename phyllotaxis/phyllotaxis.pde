int n = 0;
float c = 4;
float deg = 137.3;

void setup() {
  size(400, 400);
  background(51);
  colorMode(HSB);
}

void draw() {
  float a = n * radians(deg);
  float r = c * sqrt(n);
  float x = r * cos(a) + width / 2;
  float y = r * sin(a) + height / 2;

  fill((r) % 360, 255, 255);
  noStroke();
  ellipse(x, y, 4, 4);
  n++;
}
