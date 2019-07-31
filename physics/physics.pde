PVector gravity = new PVector(0, 0.1);
Object[] objects;

void setup() {
  size(800, 800);
  objects = new Object[3];
  for (int i = 0; i < objects.length; i++) {
    objects[i] = new Object();
  }
}

void draw() {
  background(51);
  for (Object o : objects) {
    for (Object x : objects) {
      if ( x != o) {
        o.checkCollision(x);
      }
    }
    o.update();
    o.render();
  }
}
