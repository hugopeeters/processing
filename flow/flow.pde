int fieldResolution = 10;
float fieldScale = 0.01;
float changeRate = 0.0005;
int numP = 1000;
int x, y;
float xoff, yoff;
float zoff = 0;
int cols, rows;
PVector[][] flowfield;

Particle[] particles;

void setup() {
  size(1200, 800);
  cols = floor(width/fieldResolution);
  rows = floor(height/fieldResolution);
  colorMode(HSB, 255, 255, 255);
  rectMode(CENTER);
  ellipseMode(CENTER);
  particles = new Particle[numP];
  for (int i = 0; i < numP; i++) {
    particles[i] = new Particle(new PVector(random(width), random(height)));
  }
  flowfield = new PVector[cols+1][rows+1];
  background(0);
}

void draw() {
  //background(0);

  for (x = 0; x < cols + 1; x += 1) {
    for (y = 0; y < rows + 1; y += 1) {
      xoff = x * fieldScale;
      yoff = y * fieldScale;
      flowfield[x][y] = PVector.fromAngle(noise(xoff, yoff, zoff) * TWO_PI);
      ;

      //DRAW VECTORS
      //pushMatrix();
      //translate(x * fieldResolution, y * fieldResolution);
      //rotate(flowfield[x][y].heading());
      //stroke(255);
      //line(0, 0, fieldResolution*0.75, 0);
      //popMatrix();
    }
  }
  zoff += changeRate;

  for (Particle p : particles) {
    p.render();
    p.update();
  }
}
