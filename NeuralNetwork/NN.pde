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
  Node[] inputNodes, hiddenNodes, outputNodes;
  float cellSize;

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
    float cellWidth = width / 14;
    int numCellsHigh = max(input_count, hidden_count, output_count);
    float cellHeight = height / numCellsHigh;
    cellSize = min(cellWidth, cellHeight);
    inputNodes = new Node[input_count];
    for (int i = 0; i < input_count; i++) {
      inputNodes[i] = new Node(1.5 * cellSize, (0.5 + i) * cellSize, 0.5 * cellSize);
    }
    hiddenNodes = new Node[hidden_count];
    for (int i = 0; i < hidden_count; i++) {
      hiddenNodes[i] = new Node(3.5 * cellSize, (0.5 + i) * cellSize, 0.5 * cellSize);
    }
    outputNodes = new Node[output_count];
    for (int i = 0; i < output_count; i++) {
      outputNodes[i] = new Node(5.5 * cellSize, (0.5 + i) * cellSize, 0.5 * cellSize);
    }
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

  //TRAINING

  void train(float[] training_data, float[] target) {
    for (int i = 0; i < training_data.length; i++) {
      inputs.data[i][0] = training_data[i];
    }
    //println("inputs");
    //inputs.printMatrix();
    //println("weights_ih");
    //weights_ih.printMatrix();

    //calculate hidden layer values
    hidden = dotProduct(weights_ih, inputs);
    for (int i = 0; i < hidden_count; i++) {
      hidden.data[i][0] += bias_h.data[i][0];
      hidden.data[i][0] = sigmoid(hidden.data[i][0]);
    }
    //println("hidden");
    //hidden.printMatrix();


    //println("weights_ho");
    //weights_ho.printMatrix();
    //calculate output layer values
    outputs = dotProduct(weights_ho, hidden);
    for (int i = 0; i < output_count; i++) {
      outputs.data[i][0] += bias_o.data[i][0];
      outputs.data[i][0] = sigmoid(outputs.data[i][0]);
    }
    //println("outputs");
    //outputs.printMatrix();

    Matrix T = new Matrix(target.length, 1);
    for (int i = 0; i < target.length; i++) {
      T.data[i][0] = target[i];
    }
    //println("targets");
    //T.printMatrix();

    //calculate output errors
    Matrix errors_output = subtractMatrices(T, outputs);
    //println("errors_output");
    //errors_output.printMatrix();

    //calculate output gradient
    Matrix gradients = new Matrix(outputs.rows, outputs.cols);
    //println("gradients");
    //gradients.printMatrix();
    for (int i = 0; i < gradients.rows; i++) {
      for (int j = 0; j < gradients.cols; j++) {
        gradients.data[i][j] = dsigmoid(outputs.data[i][j]);
      }
    }
    //gradients.printMatrix();
    gradients = multiplyMatrices(gradients, errors_output);
    //gradients.printMatrix();
    gradients.multiply(lr);
    //gradients.printMatrix();

    //calculate deltas
    Matrix hidden_t = transpose(hidden);
    //println("hidden_t");
    //hidden_t.printMatrix();
    Matrix weights_ho_deltas = dotProduct(gradients, hidden_t);
    //println("weights_ho_deltas");
    //weights_ho_deltas.printMatrix();

    //Apply deltas to the weights
    weights_ho = addMatrices(weights_ho, weights_ho_deltas);
    //println("weights_ho");
    //weights_ho.printMatrix();
    //Adjust bias
    bias_o = addMatrices(bias_o, gradients);
    //println("bias_o");
    //bias_o.printMatrix();

    //Calculate the hidden layer errors
    Matrix who_t = transpose(weights_ho);
    //println("Who_t");
    //who_t.printMatrix();
    Matrix hidden_errors = dotProduct(who_t, errors_output);
    //println("hidden_errors");
    //hidden_errors.printMatrix();

    //calculate hidden gradient
    Matrix hidden_gradients = new Matrix(hidden.rows, hidden.cols);
    //println("hidden_gradients");
    //hidden_gradients.printMatrix();
    for (int i = 0; i < hidden_gradients.rows; i++) {
      for (int j = 0; j < hidden_gradients.cols; j++) {
        hidden_gradients.data[i][j] = dsigmoid(hidden.data[i][j]);
      }
    }
    //hidden_gradients.printMatrix();
    hidden_gradients = multiplyMatrices(hidden_gradients, hidden_errors);
    //hidden_gradients.printMatrix();
    hidden_gradients.multiply(lr);
    //hidden_gradients.printMatrix();

    //calculate deltas
    Matrix inputs_t = transpose(inputs);
    //println("inputs_t");
    //inputs_t.printMatrix();
    Matrix weights_ih_deltas = dotProduct(hidden_gradients, inputs_t);
    //println("weights_ih_deltas");
    //weights_ih_deltas.printMatrix();

    //Apply deltas to the weights
    weights_ih = addMatrices(weights_ih, weights_ih_deltas);
    //Adjust bias
    bias_h = addMatrices(bias_h, hidden_gradients);
  }

  //VISUALIZATION
  void render() {
    //Lines
    //IH
    for (int i = 0; i < hidden_count; i++) {
      for (int j = 0; j < input_count; j++) {
        strokeWeight(round(cellSize/20));
        stroke(map(weights_ih.data[i][j], -5, 5, 100, 200));
        line(hiddenNodes[i].pos.x, hiddenNodes[i].pos.y, inputNodes[j].pos.x, inputNodes[j].pos.y);
      }
    }
    //HO
    for (int i = 0; i < output_count; i++) {
      for (int j = 0; j < hidden_count; j++) {
        strokeWeight(round(cellSize/20));
        stroke(map(weights_ho.data[i][j], -5, 5, 100, 200));
        line(outputNodes[i].pos.x, outputNodes[i].pos.y, hiddenNodes[j].pos.x, hiddenNodes[j].pos.y);
      }
    }
    //Nodes
    for (Node n : inputNodes) {
      n.render();
    }
    for (Node n : hiddenNodes) {
      n.render();
    }
    for (Node n : outputNodes) {
      n.render();
    }
  }
}
