class Tetromino {

  int[][] tGrid = new int[4][2];
  char shape;
  int x, y;

  int[][] shapeT = {
    {0, 1}, 
    {1, 1}, 
    {0, 1}, 
    {0, 0}
  };
  int[][] shapeI = {
    {1, 0}, 
    {1, 0}, 
    {1, 0}, 
    {1, 0}
  };
  int[][] shapeS = {
    {1, 0}, 
    {1, 1}, 
    {0, 1}, 
    {0, 0}
  };
  int[][] shapeZ = {
    {0, 1}, 
    {1, 1}, 
    {1, 0}, 
    {0, 0}
  };
  int[][] shapeL = {
    {0, 1}, 
    {0, 1}, 
    {1, 1}, 
    {0, 0}
  };
  int[][] shapeJ = {
    {1, 1}, 
    {0, 1}, 
    {0, 1}, 
    {0, 0}
  };
  int[][] shapeO = {
    {0, 0}, 
    {1, 1}, 
    {1, 1}, 
    {0, 0}
  };

  Tetromino(char shape, int x, int y) {
    this.shape = shape;
    this.x = x;
    this.y = y;
    switch(shape) {
    case 'T' :
      tGrid = shapeT;
      break;
    case 'I' :
      tGrid = shapeI;
      break;
    case 'S' :
      tGrid = shapeS;
      break;
    case 'Z' :
      tGrid = shapeZ;
      break;
    case 'L' :
      tGrid = shapeL;
      break;
    case 'J' :
      tGrid = shapeJ;
      break;
    case 'O' :
      tGrid = shapeO;
      break;
    }
  }

  void render() {
    for (int i = 0; i < 4; i ++) {
      for (int j = 0; j < 2; j++) {
        if (tGrid[i][j] == 1) {
          fill(255, 0, 0);
          rect((x + i)*sz, (y + j)*sz, sz, sz);
        }
      }
    }
  }

  void update() {
    if (frameCount % 30 == 0 && t.y < jj-2) {
      y++;
    }
  }
  
  void rotate(int dir){
    
  }
}
