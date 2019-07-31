Blob[] blobs;

void setup() {
  size(600, 400);
  blobs = new Blob[10];
  for (int i = 0; i < blobs.length; i++) {
    blobs[i] = new Blob(random(0, width), random(0, height));
  }
}

void draw() {
  colorMode(HSB);
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float sum = 0;
      for (Blob b : blobs) {
        float d = 150 * b.r / dist(x, y, b.pos.x, b.pos.y);
        sum += d;
      }
      pixels[y * width + x] = color(constrain(sum, 0, 255), 255, 255);
    }
  }
  updatePixels();
  for (Blob b : blobs) {
    b.update();
    //b.show();
  }
}
