class Ball {
  
  float s;
  float xpos, ypos;
  PVector dir;
  float speed;
  
  Ball(){
    s = 10;
    xpos = width/2;
    ypos = height/2;
    speed = 3;
    dir = new PVector(-1, random(-1, 1));
  }
  
  void update() {
    xpos = xpos + dir.x * speed;
    ypos = ypos + dir.y * speed;
  }
  
  void hitX(float angle) {
    dir.x = -dir.x;
    speed += 0.25;
    dir.y += angle;
    java.awt.Toolkit.getDefaultToolkit().beep();
    
  }
  
  void hitY() {
    dir.y = -dir.y;  
    java.awt.Toolkit.getDefaultToolkit().beep();
  }
  
  void show() {
    fill(255);
    noStroke();
    rect(xpos, ypos, s, s);
  }
}
