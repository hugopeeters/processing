class Tile {

  float i; //column index between 0 and 3
  float j; //row index between 0 and 3
  int val; //tile value
  float sz = 32;
  boolean canMove = true;

  Tile(float i, float j, int val) {
    this.i = i;
    this.j = j;
    this.val = val;
  }

  void show() {
    float x = 60 + 110 * i;
    float y = 260 + 110 * j;
    int c = round(map(log(val), 0.69, 7.65, 100, 255));
    colorMode(HSB, 255);
    fill(0, 100, c);
    rect(x, y, 100, 100);
    fill(0,0,0);
    textSize(sz);
    textAlign(CENTER, CENTER);
    text(val, x + 50, y + 50 - 5);
    colorMode(RGB);
  }
}
