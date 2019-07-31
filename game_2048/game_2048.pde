Tile[][] tiles;

void setup() {
  size(550, 750);
  tiles = new Tile[4][4];
  spawnTile();
  spawnTile();
  spawnTile();
}

void draw() {
  background(51);

  //play area
  noStroke();
  fill(100);
  rect(50, 250, 450, 450);

  //background sqaures
  fill(150);
  int y = 260;
  for (int i = 0; i < 4; i++) {
    int x = 60;
    for (int j = 0; j < 4; j++) {
      rect(x, y, 100, 100);
      x += 110;
    }
    y += 110;
  }

  //tiles
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (tiles[i][j] != null) {
        tiles[i][j].show();
      }
    }
  }
}

void keyPressed() {
  if (keyCode == UP) {
    moveUp();
  } else if (keyCode == RIGHT) {
    moveRight();
  } else if (keyCode == DOWN) {
    moveDown();
  } else if (keyCode == LEFT) {
    moveLeft();
  }
}

void moveUp() {
  for (int a = 0; a < 3; a++) {
    for (int j = 1; j <= 3; j++) {
      for (int i = 0; i <= 3; i++) {
        if (tiles[i][j-1] == null && tiles[i][j] != null && tiles[i][j].canMove) {
          tiles[i][j].j--;
          tiles[i][j-1] = tiles[i][j];
          tiles[i][j] = null;
        }
        if (tiles[i][j-1] != null && tiles[i][j] != null  && tiles[i][j].canMove) {
          if (tiles[i][j-1].val == tiles[i][j].val) {
            //merge
            tiles[i][j-1].val *= 2;
            tiles[i][j-1].canMove = false;
            tiles[i][j] = null;
          }
        }
      }
    }
  }
  spawnTile();
  enableTiles();
}

void moveRight() {
  for (int a = 0; a < 3; a++) {
    for (int i = 2; i >=0; i--) {
      for (int j = 0; j <= 3; j++) {
        if (tiles[i+1][j] == null && tiles[i][j] != null && tiles[i][j].canMove) {
          tiles[i][j].i++;
          tiles[i+1][j] = tiles[i][j];
          tiles[i][j] = null;
        }
        if (tiles[i+1][j] != null && tiles[i][j] != null && tiles[i][j].canMove) {
          if (tiles[i+1][j].val == tiles[i][j].val) {
            //merge
            tiles[i+1][j].val *= 2;
            tiles[i+1][j].canMove = false;
            tiles[i][j] = null;
          }
        }
      }
    }
  }
  spawnTile();
  enableTiles();
}

void moveDown() {
  for (int a = 0; a < 3; a++) {
    for (int j = 2; j >= 0; j--) {
      for (int i = 0; i <= 3; i++) {
        if (tiles[i][j+1] == null && tiles[i][j] != null && tiles[i][j].canMove) {
          tiles[i][j].j++;
          tiles[i][j+1] = tiles[i][j];
          tiles[i][j] = null;
        }
        if (tiles[i][j+1] != null && tiles[i][j] != null && tiles[i][j].canMove) {
          if (tiles[i][j+1].val == tiles[i][j].val) {
            //merge
            tiles[i][j+1].val *= 2;
            tiles[i][j+1].canMove = false;
            tiles[i][j] = null;
          }
        }
      }
    }
  }
  spawnTile();
  enableTiles();
}


void moveLeft() {
  for (int a = 0; a < 3; a++) {
    for (int i = 1; i <= 3; i++) {
      for (int j = 0; j <= 3; j++) {
        if (tiles[i-1][j] == null && tiles[i][j] != null && tiles[i][j].canMove) {
          tiles[i][j].i--;
          tiles[i-1][j] = tiles[i][j];
          tiles[i][j] = null;
        }
        if (tiles[i-1][j] != null && tiles[i][j] != null && tiles[i][j].canMove) {
          if (tiles[i-1][j].val == tiles[i][j].val) {
            //merge
            tiles[i-1][j].val *= 2;
            tiles[i-1][j].canMove = false;
            tiles[i][j] = null;
          }
        }
      }
    }
  }
  spawnTile();
  enableTiles();
}

void spawnTile() {
  //spawn new 2/4 val tile in random empty spot
  int numEmpty = 0;
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (tiles[i][j] == null) {
        numEmpty++;
      }
    }
  }
  if (numEmpty == 0) {
    //gameover
    println("GAME OVER");
  } else {
    //spawn random tile
    int i = round(random(0, 3));
    int j = round(random(0, 3));
    int val = 2 * round(random(1, 2));
    if (tiles[i][j] == null) {
      tiles[i][j] = new Tile(i, j, val);
    } else {
      spawnTile();
      enableTiles();
    }
  }
}

void enableTiles() {
  for (int i = 0; i <= 3; i++) {
    for (int j = 0; j <= 3; j++) {
      if (tiles[i][j] != null) {
        tiles[i][j].canMove = true;
      }
    }
  }
}
