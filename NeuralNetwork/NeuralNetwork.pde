NN brain;
float lr = 0.01;
float[] oo = {0, 0};
float[] ol = {0, 1};
float[] lo = {1, 0};
float[] ll = {1, 1};
float[] o = {1};
float[] l = {1};

void setup() {
  brain = new NN(2, 2, 1);

  //training
  for (int i = 0; i < 10000; i++) {
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

  float[] in = {1, 0};
  float[] out = brain.predict(in);
  printArray(out);
}

void draw() {
}

void printArray(float[] a) {
  for (int i = 0; i < a.length - 1; i++) {
    print(a[i] + ", ");
  }
  println(a[a.length]);
  println();
}
