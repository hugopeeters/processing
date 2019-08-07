Paddle paddle;

void setup() {
  size(1200, 800);
  
  //create objects
  paddle = new Paddle(width / 2);
}

void draw() {
  background(51);
  
  //update objects
  paddle.update();
  
  //render objects
  paddle.render();
}

void keyPressed() {
  if (key == 'a') {
    paddle.v = -1;
  } else if (key == 'd') {
    paddle.v = +1;
  }
}

void keyReleased() {
  paddle.v = 0;
}
