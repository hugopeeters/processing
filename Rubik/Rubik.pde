import peasy.*;

PeasyCam cam;
final int U = 0;
final int D = 1;
final int R = 2;
final int L = 3;
final int F = 4;
final int B = 5;

//U, D, R, L, F, B
color[] colors = {
  #FFFFFF, #FFFF00, 
  #FF0000, #FFA500, 
  #00FF00, #0000FF
};
int dim = 3;
Cubie[] cube = new Cubie[dim*dim*dim];

void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 400);
  int index = 0;
  for (int x = -1; x <= 1; x++) {
    for (int y = -1; y <= 1; y++) {
      for (int z = -1; z <= 1; z++) {
        PMatrix3D matrix = new PMatrix3D();
        matrix.translate(x, y, z);
        cube[index] = new Cubie(matrix, x, y, z);
        index++;
      }
    }
  }
  cube[0].highlight = true;
  cube[2].highlight = true;
}

void keyPressed() {
  if (key == '1') {
    turnZ(-1);
  }
  if (key == '2') {
    turnZ(1);
  }
}

void turnX(int index) {
  for (int i = 0; i < cube.length; i++) {
    if (cube[i].x == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(HALF_PI);
      matrix.translate(cube[i].y, cube[i].z);
      cube[i].update(cube[i].x, round(matrix.m02), round(matrix.m12));
    }
  }
}
void turnY(int index) {
  for (int i = 0; i < cube.length; i++) {
    if (cube[i].y == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(HALF_PI);
      matrix.translate(cube[i].x, cube[i].z);
      cube[i].update(round(matrix.m02), cube[i].y, round(matrix.m12));
    }
  }
}
void turnZ(int index) {
  for (int i = 0; i < cube.length; i++) {
    if (cube[i].z == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(HALF_PI);
      matrix.translate(cube[i].x, cube[i].y);
      cube[i].update(round(matrix.m02), round(matrix.m12), cube[i].z);
    }
  }
}

void draw() {
  background(51);
  scale(50);
  for (int i = 0; i < cube.length; i++) {
    cube[i].show();
  }
} 
