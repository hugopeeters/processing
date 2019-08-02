float sigmoid(float x) {
  return 1 / (1 + exp(-x));
}

float dsigmoid(float x) {
  return x * (1 - x);
}

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

  float[] predict(float[] input_array) {
    //fill input matrix
    for (int i = 0; i < input_array.length; i++) {
      inputs.data[i][0] = input_array[i];
    }
    //inputs.printMatrix();
    //weights_ih.printMatrix();

    //calculate hidden layer values
    hidden = dotProduct(weights_ih, inputs);
    //hidden.printMatrix();
    for (int i = 0; i < hidden_count; i++) {
      hidden.data[i][0] += bias_h.data[i][0];
      hidden.data[i][0] = sigmoid(hidden.data[i][0]);
    }

    //weights_ho.printMatrix();
    //calculate output layer values
    outputs = dotProduct(weights_ho, hidden);
    for (int i = 0; i < output_count; i++) {
      outputs.data[i][0] += bias_o.data[i][0];
      outputs.data[i][0] = sigmoid(outputs.data[i][0]);
    }
    //outputs.printMatrix();

    //output as array
    float[] output = new float[output_count];
    for (int i = 0; i < output_count; i++) {
      output[i] = outputs.data[i][0];
    }
    return output;
  }

  void train(float[] training_data, float[] target) {
    for (int i = 0; i < training_data.length; i++) {
      inputs.data[i][0] = training_data[i];
    }
    //inputs.printMatrix();
    //weights_ih.printMatrix();

    //calculate hidden layer values
    hidden = dotProduct(weights_ih, inputs);
    //hidden.printMatrix();
    for (int i = 0; i < hidden_count; i++) {
      hidden.data[i][0] += bias_h.data[i][0];
      hidden.data[i][0] = sigmoid(hidden.data[i][0]);
    }

    //weights_ho.printMatrix();
    //calculate output layer values
    outputs = dotProduct(weights_ho, hidden);
    for (int i = 0; i < output_count; i++) {
      outputs.data[i][0] += bias_o.data[i][0];
      outputs.data[i][0] = sigmoid(outputs.data[i][0]);
    }
    //outputs.printMatrix();

    Matrix T = new Matrix(target.length, 1);
    for (int i = 0; i < target.length; i++) {
      T.data[i][0] = target[i];
    }

    //calculate output errors
    Matrix errors_output = subtractMatrices(T, outputs);

    //calculate output gradient
    Matrix gradients = new Matrix(errors_output.rows, errors_output.cols);
    for (int i = 0; i < gradients.rows; i++) {
      for (int j = 0; j < gradients.cols; j++) {
        gradients.data[i][j] = dsigmoid(gradients.data[i][j]);
      }
    }
    gradients = multiplyMatrices(gradients, errors_output);
    gradients.multiply(lr);

    //calculate deltas
    Matrix hidden_t = transpose(hidden);
    Matrix weights_ho_deltas = dotProduct(gradients, hidden_t);

    //Apply deltas to the weights
    weights_ho = addMatrices(weights_ho, weights_ho_deltas);
    //Adjust bias
    bias_o = addMatrices(bias_o, gradients);

    //Calculate the hidden layer errors
    Matrix who_t = transpose(weights_ho);
    Matrix hidden_errors = dotProduct(who_t, errors_output);

    //calculate hidden gradient
    Matrix hidden_gradients = new Matrix(hidden.rows, hidden.cols);
    for (int i = 0; i < hidden_gradients.rows; i++) {
      for (int j = 0; j < hidden_gradients.cols; j++) {
        hidden_gradients.data[i][j] = dsigmoid(hidden_gradients.data[i][j]);
      }
    }
    hidden_gradients = multiplyMatrices(hidden_gradients, hidden_errors);
    hidden_gradients.multiply(lr);

    //calculate deltas
    Matrix inputs_t = transpose(inputs);
    Matrix weights_ih_deltas = dotProduct(hidden_gradients, inputs_t);

    //Apply deltas to the weights
    weights_ih = addMatrices(weights_ih, weights_ih_deltas);
    //Adjust bias
    bias_h = addMatrices(bias_h, hidden_gradients);
  }
}
