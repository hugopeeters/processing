NN brain;

void setup() {
  brain = new NN(2, 3, 1);
  float[] in = {1, -5};
  float[] out = brain.feedForward(in);
  print(out);
}

void draw() {
}
