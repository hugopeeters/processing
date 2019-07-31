ArrayList<Boundary> walls, outsidewalls;
Particle particle;

void setup() {
  size(800, 800);
  walls = new ArrayList<Boundary>();
  outsidewalls = new ArrayList<Boundary>();
  for (int i = 0; i < 5; i++) {
    walls.add(new Boundary(random(100, 700), random(100, 700), random(100, 700), random(100, 700)));

  }
  outsidewalls.add(new Boundary(0, 0, width, 0));
  outsidewalls.add(new Boundary(width, 0, width, height));
  outsidewalls.add(new Boundary(width, height, 0, height));
  outsidewalls.add(new Boundary(0, height, 0, 0));  
  particle = new Particle();
}

void draw() {
  background(0);
  for (Boundary wall : walls) {
    wall.render();
    particle.createRays(walls);
  }
  particle.render();
  particle.update(mouseX, mouseY);
}
