float sigmoid(float x) {
  return 1 / (1 + exp(-x));
}

float dsigmoid(float x) {
  return x * (1 - x);
}

class NN {

  int input_count;
  int hidden1_count;
  int hidden2_count;
  int output_count;
  Matrix inputs, weights_ih, bias_ih, hidden1, weights_hh, bias_hh, hidden2, weights_ho, bias_ho, outputs;
  Node[] inputNodes, hidden1Nodes, hidden2Nodes, outputNodes;
  float cellSize;

  NN(int input_count, int hidden1_count, int hidden2_count, int output_count) {
    this.input_count = input_count;
    this.hidden1_count = hidden1_count;
    this.hidden2_count = hidden2_count;
    this.output_count = output_count;
    inputs = new Matrix(input_count, 1);
    weights_ih = new Matrix(hidden1_count, input_count);
    weights_ih.randomize();
    bias_ih = new Matrix(hidden1_count, 1);
    bias_ih.randomize();
    weights_hh = new Matrix(hidden2_count, hidden1_count);
    weights_hh.randomize();
    bias_hh = new Matrix(hidden2_count, 1);
    bias_hh.randomize();
    weights_ho = new Matrix(output_count, hidden2_count);
    weights_ho.randomize();
    bias_ho = new Matrix(output_count, 1);
    bias_ho.randomize();
    float cellWidth = width / 18;
    int[] comp = {input_count, hidden1_count, hidden2_count, output_count};
    int numCellsHigh = max(comp);
    float cellHeight = height / numCellsHigh;
    cellSize = min(cellWidth, cellHeight);
    inputNodes = new Node[input_count];
    for (int i = 0; i < input_count; i++) {
      inputNodes[i] = new Node(1.5 * cellSize, (0.5 + i) * cellSize, 0.5 * cellSize);
    }
    hidden1Nodes = new Node[hidden1_count];
    for (int i = 0; i < hidden1_count; i++) {
      hidden1Nodes[i] = new Node(3.5 * cellSize, (0.5 + i) * cellSize, 0.5 * cellSize);
    }
    hidden2Nodes = new Node[hidden2_count];
    for (int i = 0; i < hidden2_count; i++) {
      hidden2Nodes[i] = new Node(5.5 * cellSize, (0.5 + i) * cellSize, 0.5 * cellSize);
    }
    outputNodes = new Node[output_count];
    for (int i = 0; i < output_count; i++) {
      outputNodes[i] = new Node(7.5 * cellSize, (0.5 + i) * cellSize, 0.5 * cellSize);
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
    hidden1 = dotProduct(weights_ih, inputs);
    //hidden1.printMatrix();
    for (int i = 0; i < hidden1_count; i++) {
      hidden1.data[i][0] += bias_ih.data[i][0];
      hidden1.data[i][0] = sigmoid(hidden1.data[i][0]);
    }
    hidden2 = dotProduct(weights_hh, hidden1);
    //hidden2.printMatrix();
    for (int i = 0; i < hidden2_count; i++) {
      hidden2.data[i][0] += bias_hh.data[i][0];
      hidden2.data[i][0] = sigmoid(hidden2.data[i][0]);
    }

    //weights_ho.printMatrix();
    //calculate output layer values
    outputs = dotProduct(weights_ho, hidden2);
    for (int i = 0; i < output_count; i++) {
      outputs.data[i][0] += bias_ho.data[i][0];
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

    //calculate hidden layer values
    hidden1 = dotProduct(weights_ih, inputs);
    for (int i = 0; i < hidden1_count; i++) {
      hidden1.data[i][0] += bias_ih.data[i][0];
      hidden1.data[i][0] = sigmoid(hidden1.data[i][0]);
    }
    hidden2 = dotProduct(weights_hh, hidden1);
    for (int i = 0; i < hidden2_count; i++) {
      hidden2.data[i][0] += bias_hh.data[i][0];
      hidden2.data[i][0] = sigmoid(hidden2.data[i][0]);
    }

    //calculate output layer values
    outputs = dotProduct(weights_ho, hidden2);
    for (int i = 0; i < output_count; i++) {
      outputs.data[i][0] += bias_ho.data[i][0];
      outputs.data[i][0] = sigmoid(outputs.data[i][0]);
    }

    //turn targets array into a matrix
    Matrix T = new Matrix(target.length, 1);
    for (int i = 0; i < target.length; i++) {
      T.data[i][0] = target[i];
    }



    //calculate output errors
    Matrix errors_output = subtractMatrices(T, outputs);

    //calculate output gradient
    Matrix gradients = new Matrix(outputs.rows, outputs.cols);
    for (int i = 0; i < gradients.rows; i++) {
      for (int j = 0; j < gradients.cols; j++) {
        gradients.data[i][j] = dsigmoid(outputs.data[i][j]);
      }
    }
    gradients = multiplyMatrices(gradients, errors_output);
    gradients.multiply(lr);

    //calculate deltas
    Matrix hidden_t = transpose(hidden2);
    Matrix weights_ho_deltas = dotProduct(gradients, hidden_t);

    //Apply deltas to the weights
    weights_ho = addMatrices(weights_ho, weights_ho_deltas);

    //Adjust bias
    bias_ho = addMatrices(bias_ho, gradients);



    //Calculate the hidden2 layer errors
    Matrix who_t = transpose(weights_ho);
    Matrix hidden2_errors = dotProduct(who_t, errors_output);

    //calculate hidden gradient
    Matrix hidden2_gradients = new Matrix(hidden2.rows, hidden2.cols);
    for (int i = 0; i < hidden2_gradients.rows; i++) {
      for (int j = 0; j < hidden2_gradients.cols; j++) {
        hidden2_gradients.data[i][j] = dsigmoid(hidden2.data[i][j]);
      }
    }
    hidden2_gradients = multiplyMatrices(hidden2_gradients, hidden2_errors);
    hidden2_gradients.multiply(lr);

    //calculate deltas
    Matrix hidden1_t = transpose(hidden1);
    Matrix weights_hh_deltas = dotProduct(hidden2_gradients, hidden1_t);

    //Apply deltas to the weights
    weights_hh = addMatrices(weights_hh, weights_hh_deltas);

    //Adjust bias
    bias_hh = addMatrices(bias_hh, hidden2_gradients);



    //Calculate the hidden1 layer errors
    Matrix whh_t = transpose(weights_hh);
    Matrix hidden1_errors = dotProduct(whh_t, hidden2_errors);

    //calculate hidden gradient
    Matrix hidden1_gradients = new Matrix(hidden1.rows, hidden1.cols);
    for (int i = 0; i < hidden1_gradients.rows; i++) {
      for (int j = 0; j < hidden1_gradients.cols; j++) {
        hidden1_gradients.data[i][j] = dsigmoid(hidden1.data[i][j]);
      }
    }
    hidden1_gradients = multiplyMatrices(hidden1_gradients, hidden1_errors);
    hidden1_gradients.multiply(lr);

    //calculate deltas
    Matrix inputs_t = transpose(inputs);
    Matrix weights_ih_deltas = dotProduct(hidden1_gradients, inputs_t);

    //Apply deltas to the weights
    weights_ih = addMatrices(weights_ih, weights_ih_deltas);

    //Adjust bias
    bias_ih = addMatrices(bias_ih, hidden1_gradients);
  }

  //VISUALIZATION
  void render() {
    //Lines
    //IH
    for (int i = 0; i < hidden1_count; i++) {
      for (int j = 0; j < input_count; j++) {
        strokeWeight(round(cellSize/20));
        stroke(map(weights_ih.data[i][j], -5, 5, 100, 200), 128, 0);
        line(hidden1Nodes[i].pos.x, hidden1Nodes[i].pos.y, inputNodes[j].pos.x, inputNodes[j].pos.y);
      }
    }
    //HH
    for (int i = 0; i < hidden2_count; i++) {
      for (int j = 0; j < hidden1_count; j++) {
        strokeWeight(round(cellSize/20));
        stroke(map(weights_hh.data[i][j], -5, 5, 100, 200), 128, 0);
        line(hidden2Nodes[i].pos.x, hidden2Nodes[i].pos.y, hidden1Nodes[j].pos.x, hidden1Nodes[j].pos.y);
      }
    }
    //HO
    for (int i = 0; i < output_count; i++) {
      for (int j = 0; j < hidden2_count; j++) {
        strokeWeight(round(cellSize/20));
        stroke(map(weights_ho.data[i][j], -5, 5, 100, 200), 128, 0);
        line(outputNodes[i].pos.x, outputNodes[i].pos.y, hidden2Nodes[j].pos.x, hidden2Nodes[j].pos.y);
      }
    }
    //Nodes
    for (Node n : inputNodes) {
      n.render();
    }
    for (Node n : hidden1Nodes) {
      n.render();
    }
    for (Node n : hidden2Nodes) {
      n.render();
    }
    for (Node n : outputNodes) {
      n.render();
    }
    //Numbers
  }
}
