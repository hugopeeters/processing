int n = 40;
float cellsize = 20;
Cell[] cells;

void setup() {
  size(800, 800);
  cells = new Cell[n * n];
  for (int i = 0; i < n * n; i++) {
    int x = (i % n);
    int y =  floor(i / n);
    cells[i] = new Cell(x, y);
  }
  //prepare neighboring bomb counts
  for (int i = 0; i < n * n; i++) {
    if (cells[i].bomb == 0) {
      cells[i].n = countNeighbors(i);
    }
  }
}

int countNeighbors(int i) {
  int r = 0;
  for (Cell c : getNeighbors(i)) {
    r += c.bomb;
  }
  return r;
}

ArrayList<Cell> getNeighbors(int i) {
  ArrayList<Cell> r = new ArrayList<Cell>();
  int x = cells[i].x;
  int y = cells[i].y;
  if (x > 0 && y > 0) {
    r.add(cells[getIndex(x-1, y-1)]);
  }
  if (y > 0) {
    r.add(cells[getIndex(x, y-1)]);
  }
  if (y > 0 && x < n-1) {
    r.add(cells[getIndex(x+1, y-1)]);
  }
  if (x > 0) {
    r.add(cells[getIndex(x-1, y)]);
  }
  if (x < n-1) {
    r.add(cells[getIndex(x+1, y)]);
  }
  if (x > 0 && y < n-1) {
    r.add(cells[getIndex(x-1, y+1)]);
  }
  if (y < n-1) {
    r.add(cells[getIndex(x, y+1)]);
  }
  if (y < n-1 && x < n-1) {
    r.add(cells[getIndex(x+1, y+1)]);
  }
  return r;
}

int getIndex(int x, int y) {
  return x + y * n;
}

void draw() {
  background(255);
  for (Cell c : cells) {
    c.show();
  }
}

void mousePressed() {
  int x = floor(mouseX / n);
  int y = floor(mouseY / n);
  int i = getIndex(x, y);
  if (mouseButton == LEFT) {
    if (cells[i].bomb == 1) {
      //game over
      for (Cell c : cells) {
        c.hidden = false;
      }
      println("GAME OVER");
    } else {
      cells[i].hidden = false;
      if (cells[i].n == 0) {
        revealNeighbors(i);
      }
    }
  } else if (mouseButton == RIGHT) {
    if (cells[i].hidden == true) {
      cells[i].flag = !cells[i].flag;
      if (checkWin()) {
        println("YOU WIN!");
      }
    }
  }
}

void revealNeighbors(int i) {
  for (Cell c : getNeighbors(i)) {
    if (c.hidden) {
      c.hidden = false;
      if (c.n == 0) {
        revealNeighbors(getIndex(c.x, c.y));
      }
    }
  }
}

boolean checkWin() {
  boolean win = true;
  for (Cell c : cells) {
    if (c.flag && c.bomb == 0) {
      win = false;
    } else if (c.bomb == 1 && !c.flag) {
      win = false;
    }
  }
  return win;
}
