class Cell {

  int x, y;
  int bomb = 0;
  int n = 0;
  boolean hidden = true;
  boolean flag = false;

  Cell(int x, int y) {
    this.x = x;
    this.y = y;

    if (random(1) < 0.075) {
      bomb = 1;
    }
  }

  void show() {
    stroke(0);
    strokeWeight(1);
    rectMode(CORNER);
    if (hidden) {
      //hidden cell
      if (flag) {
        fill(0, 255, 0);
      } else {
        fill(51);
      }
      rect(x * cellsize, y * cellsize, cellsize, cellsize);
    } else {
      if (bomb == 1 && !flag) {
        //bomb
        fill(255, 0, 0);
        rect(x * cellsize, y * cellsize, cellsize, cellsize);
      } else {
        //no bomb
        noFill();
        rect(x * cellsize, y * cellsize, cellsize, cellsize);
      }
      if (bomb == 0 && n != 0) {
        //bombcount
        fill(0);
        text(n, (x + 0.3) * cellsize, (y+0.75) * cellsize);
      }
    }
  }
}
