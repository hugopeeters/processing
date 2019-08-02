NN brain;

void setup() {
  brain = new NN(4, 7, 3);
  float[] in = {1, -5, 3, 11};
  float[] out = brain.feedForward(in);
  for (float x : out) {
    print(x + ", ");
  }
}

void draw() {
}
