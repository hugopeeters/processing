class Matrix {

  int rows;
  int cols;
  float[][] data;

  Matrix(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    this.data = new float[rows][cols];
  }

  void randomize() {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        //this.data[i][j] = floor(random(10)); //random integers between 0 and 10
        this.data[i][j] = random(2) - 1; //random values between -1 and +1
      }
    }
  }

  void printMatrix() {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        print(this.data[i][j]);
        print(" ");
      }
      println();
    }
    println();
  }

  //element-wise operations

  void multiply(float n) {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        this.data[i][j] *= n;
      }
    }
  }

  void add(float n) {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        this.data[i][j] += n;
      }
    }
  }

  void subtract(float n) {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        this.data[i][j] -= n;
      }
    }
  }
}


//matrix-wise operations (static functions)

Matrix dotProduct(Matrix A, Matrix B) {
  Matrix AB = new Matrix(A.rows, B.cols);
  for (int i = 0; i < AB.rows; i++) {
    for (int j = 0; j < AB.cols; j++) {
      AB.data[i][j] = 0;
      for (int x = 0; x < A.cols; x++) {
        AB.data[i][j] += A.data[i][x] * B.data[x][j];
      }
    }
  }
  return AB;
}

Matrix transpose(Matrix M) {
  Matrix T = new Matrix(M.cols, M.rows);
  for (int i = 0; i < M.rows; i++) {
    for (int j = 0; j < M.cols; j++) {
      T.data[j][i] = M.data[i][j];
    }
  }
  return T;
}

Matrix addMatrices(Matrix A, Matrix B) {
  Matrix S = new Matrix(A.cols, A.rows);
  for (int i = 0; i < A.rows; i++) {
    for (int j = 0; j < A.cols; j++) {
      S.data[j][i] = A.data[i][j] + B.data[i][j];
    }
  }
  return S;
}

Matrix subtractMatrices(Matrix A, Matrix B) {
  Matrix S = new Matrix(A.cols, A.rows);
  for (int i = 0; i < A.rows; i++) {
    for (int j = 0; j < A.cols; j++) {
      S.data[j][i] = A.data[i][j] - B.data[i][j];
    }
  }
  return S;
}
