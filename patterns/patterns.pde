ArrayList<Polygon> polys;
float angle = 60;
float delta = 10;

void setup() {
  size(800, 800);
  polys = new ArrayList<Polygon>();
  int inc = 100;
  for (int x = 0; x < width; x += inc) {
    for (int y = 0; y < height; y += inc) {
      Polygon poly = new Polygon();
      
      //square pattern
      poly.addVertex(x, y);
      poly.addVertex(x+inc, y);
      poly.addVertex(x+inc, y+inc);
      poly.addVertex(x, y+inc);
      
      poly.close();
      polys.add(poly);
    }
  }
}

void draw() {
  background(51);
  for (Polygon poly : polys) {
    poly.hankin();
    poly.show();
  }
}

void keyPressed() {
  if (key == 'a') {
    angle -= 5;
  }
  if (key == 's') {
    angle += 5;
  }
  if (key == 'z') {
    delta -= 1;
  }
  if (key == 'x') {
    delta += 1;
  }
}
