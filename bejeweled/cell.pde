class Cell {

  int i, j;
  PVector center;
  int gem;

  Cell(int i, int j) {
    this.i = i;
    this.j = j;
    center = new PVector((i + 0.5) * cellSize, (j + 0.5)* cellSize);
    gem = round(random(1, 6));
  }

  void render() {
    noFill();
    stroke(255);
    rectMode(CENTER);
    rect(center.x, center.y, cellSize, cellSize);
    //point(center.x, center.y);
    if (gem > 0) {
      int gemColor = round(gem * 255 / 6);
      noStroke();
      colorMode(HSB, 255, 100, 100);
      fill(gemColor, 100, 80);
      ellipseMode(CENTER);
      ellipse(center.x, center.y, cellSize * 0.8, cellSize * 0.8);
    }
  }

  void fall() {
    grid[i][j+1].gem = gem;
    grid[i][j].gem = 0;
  }
}
