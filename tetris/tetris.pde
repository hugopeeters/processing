float sz;
int ii, jj;
Cell[][] grid;
Tetromino t;

void setup() {
  sz = 25;
  size(401, 801);
  ii = floor(width / sz);
  jj = floor(height / sz);
  grid = new Cell[ii][jj];
  for (int x = 0; x < ii; x++) {
    for (int y = 0; y < jj; y++) {
      grid[x][y] = new Cell(x, y);
    }
  }
  t = new Tetromino('T', 6, 0);
}

void draw() {
  background(51);
  for (int x = 0; x < ii; x++) {
    for (int y = 0; y < jj; y++) {
      grid[x][y].render();
    }
  }
  t.render();
  t.update();
}

void keyPressed(){
  if (keyCode == LEFT){
    t.x--;
  } else if (keyCode == RIGHT){
    t.x++;
  } else if (keyCode == DOWN){
    t.y++;
  } else if (key == 'z'){
    t.rotate(-1);
  } else if (key == 'x'){
    t.rotate(1);
  }
}
