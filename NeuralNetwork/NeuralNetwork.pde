NN brain;
float lr = 0.05;
float[] oo = {0, 0};
float[] ol = {0, 1};
float[] lo = {1, 0};
float[] ll = {1, 1};
float[] o = {0};
float[] l = {1};

void setup() {
  size(600, 400);
  brain = new NN(2, 3, 1);
  for (int i = 0; i < 50000; i++) {
    float r = floor(random(4));
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
}

void draw() {
  background(0);
  brain.render();
  //float r = floor(random(4));
  //if (r == 0) {
  //  brain.train(ol, l);
  //} else if (r == 1) {
  //  brain.train(lo, l);
  //} else if ( r == 2) {
  //  brain.train(oo, o);
  //} else {
  //  brain.train(ll, o);
  //}

  float[] out = brain.predict(ol);
  float[] out2 = brain.predict(lo);
  float[] out3 = brain.predict(oo);
  float[] out4 = brain.predict(ll);
  noLoop();
}
