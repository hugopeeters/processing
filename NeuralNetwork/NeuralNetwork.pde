NN brain;
float lr = 0.1;
float[] oo = {0, 0};
float[] ol = {0, 1};
float[] lo = {1, 0};
float[] ll = {1, 1};
float[] o = {0};
float[] l = {1};
PVector origin;

void setup() {
  size(800, 400);
  origin = new PVector(width/2, 0);
  brain = new NN(2, 4, 1);
  //for (int i = 0; i < 50000; i++) {
  //  float r = floor(random(4));
  //  if (r == 0) {
  //    brain.train(ol, l);
  //  } else if (r == 1) {
  //    brain.train(lo, l);
  //  } else if ( r == 2) {
  //    brain.train(oo, o);
  //  } else {
  //    brain.train(ll, o);
  //  }
  //}
}

void draw() {
  background(51);
  noStroke();
  rectMode(CORNERS);
  brain.render();
  float r = floor(random(4));
  for (int i = 0; i < 50; i++) {
    if (r == 0) {
      brain.train(ol, l);
    } else if (r == 1) {
      brain.train(lo, l);
    } else if ( r == 2) {
      brain.train(oo, o);
    } else {
      brain.train(ll, o);
    }
  }
  pushMatrix();
  translate(origin.x, origin.y);
  for (float x = 0; x < 400; x += 1) {
    for (float y = 0; y < 400; y +=1) {
      float[] in = {(x/400), (y/400)};
      float[] out = brain.predict(in);
      //println(in[0] + ", " + in[1] + " = " + out[0]);
      fill(map(out[0], 0, 1, 0, 255));
      rect(x, y, x+1, y+1);
    }
  }
  popMatrix();
}
