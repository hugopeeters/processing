class NN {

  int input_count;
  int hidden_count;
  int output_count;
  Matrix inputs, weights_ih, bias_h, hidden, weights_ho, bias_o, outputs;

  NN(int input_count, int hidden_count, int output_count) {
    this.input_count = input_count;
    this.hidden_count = hidden_count;
    this.output_count = output_count;
    inputs = new Matrix(input_count, 1);
    weights_ih = new Matrix(hidden_count, input_count);
    weights_ih.randomize();
    bias_h = new Matrix(hidden_count, 1);
    bias_h.randomize();
    weights_ho = new Matrix(output_count, hidden_count);
    weights_ho.randomize();
    bias_o = new Matrix(output_count, 1);
    bias_o.randomize();
  }

  float[] feedForward(float[] input_array) {
    //fill input matrix
    for (int i = 0; i < input_array.length; i++) {
      inputs.data[i][0] = input_array[i];
    }
    inputs.printMatrix();
    weights_ih.printMatrix();

    //calculate hidden layer values
    hidden = dotProduct(weights_ih, inputs);
    hidden.printMatrix();
    for (int i = 0; i < hidden_count; i++) {
      hidden.data[i][0] += bias_h.data[i][0];
      hidden.data[i][0] = sigmoid(hidden.data[i][0]);
    }

    weights_ho.printMatrix();
    //calculate output layer values
    outputs = dotProduct(weights_ho, hidden);
    for (int i = 0; i < output_count; i++) {
      outputs.data[i][0] += bias_o.data[i][0];
      outputs.data[i][0] = sigmoid(outputs.data[i][0]);
    }
    outputs.printMatrix();

    //output as array
    float[] output = new float[output_count];
    for (int i = 0; i < output_count; i++) {
      output[i] = outputs.data[i][0];
    }
    return output;
  }

  float sigmoid(float x) {
    return 1 / (1 + exp(-x));
  }

  void train(float[] training_data, float[] target) {
    //TODO
  }
}
