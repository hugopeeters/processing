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
        this.data[i][j] = floor(random(10)); //random integers between 0 and 10
//        this.data[i][j] = random(2) - 1; //random values between -1 and +1
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

  void multiply(int n) {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        this.data[i][j] *= n;
      }
    }
  }

  void add(int n) {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        this.data[i][j] += n;
      }
    }
  }

  void subtract(int n) {
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        this.data[i][j] -= n;
      }
    }
  }
}

int testFunction(int a){
  return a;
}

//matrix-wise operations
Matrix dotProduct(Matrix A, Matrix B) {
  Matrix AB = new Matrix(A.rows, B.cols);
  for (int i = 0; i < AB.rows; i++) {
    for (int j = 0; j < AB.cols; j++) {
      AB.data[i][j] = 0;
      for (int x = 0; x < A.rows; x++){
        AB.data[i][j] += A.data[x][i] * B.data[j][x];
      }
    }
  }
  return AB;
}
