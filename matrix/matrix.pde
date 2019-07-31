ArrayList<Stream> streams;
int textSize = 40;

void setup() {
  //size(1200, 800);
  fullScreen();
  streams = new ArrayList<Stream>();
  float x = 0;
  float dx = textSize / 2;
  for (int i = 0; i < width / dx; i++) {
    streams.add(new Stream(x));
    x += dx + random(-4, 4);
  }
}

void draw() {
  background(0, 50);
  rectMode(CENTER);
  PFont mono = createFont("matrix.ttf", textSize);
  textFont(mono);
  for (Stream s : streams) {
    //textSize(s.size + 0.1);
    //s.render();
    textSize(s.size);
    s.render();
  }
  //if (frameCount > 100){noLoop();}
}
