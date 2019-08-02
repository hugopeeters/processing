NN brain;
float lr = 0.01;

void setup() {
  brain = new NN(4, 7, 3);
  float[] in = {1, -5, 3, 11};
  float[] out = brain.predict(in);
  for (float x : out) {
    print(x + ", ");
  }
}

void draw() {
}
