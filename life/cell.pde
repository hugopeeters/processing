class Cell {

  boolean alive;
  int i, j;
  int count;

  Cell(int i, int j) {
    alive = false;
    this.i = i;
    this.j = j;
  }

  void toggle() {
    alive = !alive;
  }

  Cell next() {
    Cell nextCell = this;
    if (alive && count < 2 || alive && count > 3) {
      nextCell.alive = false;
    } else if (!alive && count == 3) {
      nextCell.alive = true;
    }
    return nextCell;
  }

  int countNeighbors() {
    int count = 0;
    for (int x = -1; x <= 1; x++) {
      for (int y = -1; y <= 1; y++) {
        if (i+x >= 0 && i+x < (width/sz) && j+y >= 0 && j+y < (height/sz)) {
          if (grid[i+x][j+y].alive) {
            count++;
          }
        }
      }
    }
    if (alive) {
      count--;
    }
    return count;
  }

  void render() {
    count = countNeighbors();
    noStroke();
    if (alive) {
      fill(255);
    } else {
      fill(0);
    }
    rect(i*sz, j*sz, sz-1, sz-1);
    //fill(255, 0, 0);
    //text(count, i*sz + sz/3, j*sz + sz/2);
  }
}
