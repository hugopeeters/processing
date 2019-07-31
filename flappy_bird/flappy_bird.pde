Bird b;
ArrayList<Pipe> pipes;

void setup() {
  size(600, 600);
  b = new Bird(height / 2);
  pipes = new ArrayList<Pipe>();
  pipes.add(new Pipe());
}

void draw() {
  background(51);
  noStroke();

  for (int i = pipes.size() - 1; i >= 0; i--) {
    pipes.get(i).show();
    pipes.get(i).update();
    if (pipes.get(i).hits(b)){
      println("HIT");
    }
    if (pipes.get(i).x < -pipes.get(i).w) {
      pipes.remove(i);
    }
  }
  
  b.update();
  b.show();

  if (frameCount % 150 == 0) {
    pipes.add(new Pipe());
  }
}

void keyPressed() {
  b.flap();
}
