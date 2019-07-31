class Paddle {
  
  float w = 10;
  float h = 50;
  float xpos, ypos;
  float speed;
  
  
  Paddle(float x){
    xpos = x;
    ypos = height/2; 
    speed = 3;
  }
  
  void update(float y){
    ypos = constrain(y, 0, height - h);
  }
  
  void move(){
    float ballcenter = ball.ypos + ball.s / 2;
    float paddlecenter = ypos + h / 2;
    float offset = ballcenter - paddlecenter;
    float step = constrain(offset, -speed, speed);
    ypos += step;
    ypos = constrain(ypos, 0, height - h);
  }
  
  void show(){
    fill(255);
    noStroke();
    rect(xpos, ypos, w, h);
  }
  
}
