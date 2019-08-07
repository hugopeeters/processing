
//objects
Paddle paddle;
Ball ball;

void setup() {
  size(1200, 800);
  
  //create objects
  paddle = new Paddle(width / 2);
  ball = new Ball(width / 2, height / 2);
}

void draw() {
  background(51);
  
  //update objects
  paddle.update();
  ball.update();
  
  //render objects
  paddle.render();
  ball.render();
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
