class Grid {

  //properties
  Block[][] blocks;
  int rows = 10;
  int cols = 10;
  float margin = 20;
  float w = (width - ((cols + 1) * margin)) / cols;
  float h = (height / 2 - ((rows + 1) * margin)) / rows;

  //constructor
  Grid() {
    blocks = new Block[10][20];
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        float x = margin + (w / 2) + (w + margin) * j;
        float y = margin + (h / 2) + (h + margin) * i;
        blocks[i][j] = new Block(x, y, w, h);
      }
    }
  }

  //render
  void render() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        blocks[i][j].render();
      }
    }
  }
}
