float mr = 1.1; //mutation rate
float mc = 0.1; //mutation chance

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

  Matrix predict() {

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
    return outputs;
  }

  //procreation
  NN copy() {
    NN targetBrain = new NN(this.input_count, this.hidden_count, this.output_count);
    targetBrain.weights_ih = this.weights_ih;
    targetBrain.weights_ho = this.weights_ho;
    targetBrain.bias_h = this.bias_h;
    targetBrain.bias_o = this.bias_o;
    return targetBrain;
  }

  //mutation
  void mutate() {
    for (int i = 0; i < weights_ih.rows; i++) {
      for (int j = 0; j < weights_ih.cols; j++) {
        if (random(1) < mc) {
          weights_ih.data[i][j] *= mr;
        }
      }
    }
    for (int i = 0; i < weights_ho.rows; i++) {
      for (int j = 0; j < weights_ho.cols; j++) {
        if (random(1) < mc) {
          weights_ho.data[i][j] *= mr;
        }
      }
    }
    for (int i = 0; i < bias_o.rows; i++) {
      for (int j = 0; j < bias_o.cols; j++) {
        if (random(1) < mc) {
          bias_o.data[i][j] *= mr;
        }
      }
    }
    for (int i = 0; i < bias_h.rows; i++) {
      for (int j = 0; j < bias_h.cols; j++) {
        if (random(1) < mc) {
          bias_h.data[i][j] *= mr;
        }
      }
    }
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
    //Numbers
  }
}
