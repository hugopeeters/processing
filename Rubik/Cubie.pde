class Cubie {
  PMatrix3D matrix;
  boolean highlight = false;
  int x, y, z;

  Cubie(PMatrix3D matrix, int x, int y, int z) {
    this.matrix = matrix;
    this.x = x;
    this.y = y;
    this.z = z;
  }

  void update(int x, int y, int z) {
    matrix.reset(); 
    matrix.translate(x, y, z);
    this.x = x;
    this.y = y;
    this.z = z;
  }

  void show() {
    fill(255);
    if (highlight) {
      fill(255, 0, 0);
    }
    stroke(0);
    strokeWeight(0.1);
    pushMatrix();
    applyMatrix(matrix);
    box(1);
    popMatrix();
  }
}
