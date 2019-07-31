PVector gravity;
ArrayList<Drop> rain;
PVector wind;
PVector w;
float wOff;

void setup() {
  size(1200, 800);
  gravity = new PVector(0, 1);
  w = new PVector(0, 0);
  wOff = 0;
  rain = new ArrayList<Drop>();
  for (int i = 0; i < 4500; i++) {
    Drop d = new Drop();
    d.randomize();
    rain.add(d);
  }
}

void draw() {
  background(5);
  for (Drop d : rain) {
    d.update();
    d.render();
  }
  if (keyPressed) {
    noLoop();
  }
}
