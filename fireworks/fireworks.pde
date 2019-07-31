ArrayList<Firework> fireworks;
PVector gravity;

void setup() {
  size(800, 600, P2D);
  colorMode(HSB);
  stroke(255);
  strokeWeight(4);
  gravity = new PVector(0, 0.2);
  fireworks = new ArrayList<Firework>();
  background(0);
}

void draw() {
  background(0, 255);
  if(random(1) < 0.08){
    fireworks.add(new Firework());
  }
  for (int i = fireworks.size() - 1; i >= 0; i--){
    Firework f = fireworks.get(i);
    f.update();
    f.show();
    if (f.done()){
      fireworks.remove(i);
    }
  }
}
