class Ball {

  //properties
  float d = 8;
  PVector pos, vel;
  float speed = 4;
  color c = color(255);

  //constructor
  Ball(float x, float y) {
    pos = new PVector(x, y);
    vel = PVector.random2D().setMag(speed);
  }

  //update
  void update() {

    //hit the sides
    if ((pos.x - this.d <= 0 && this.vel.x < 0) || (pos.x + this.d >= width && this.vel.x > 0)) {
      this.vel.x *= -1;
    }

    //hit the top
    if (pos.y - this.d <= 0 && this.vel.y < 0) {
      this.vel.y *= -1;
    }

    //hit the paddle
    if (pos.y + this.d > paddle.y && pos.x > paddle.x - paddle.w / 2 && pos.x < paddle.x + paddle.w / 2 && this.vel.y > 0) {
      vel.y *= -1;
    }

    //hit a block
    for (int i = 0; i < grid.rows; i++) {
      for (int j = 0; j < grid.cols; j++) {
        checkCollision(grid.blocks[i][j]);
      }
    }

    //move
    pos.add(vel);
  }

  //render
  void render() {

    //style
    noStroke();
    fill(c);

    //render
    ellipse(this.pos.x, this.pos.y, this.d, this.d);
  }

  //other functions
  void checkCollision(Block block) {
    if (block.intact) {
      
    }
  }
}
