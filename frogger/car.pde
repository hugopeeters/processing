class Car {
  
  float x = width;
  float y;
  float vel;
  int c = round(random(255));
  
  Car(float x, float y, float vel){
    this.x = x;
    this.y = y;
    this.vel = vel;
  }
  
  void update(){
    x -= vel;
    if(x < -100){
      x = width;
    }
    
    //check collision
    if(frog.pos.x + frog.r > x && frog.pos.x - frog.r < x + 100 && frog.pos.y + frog.r > y && frog.pos.y - frog.r < y + 50){
      gameover = true;
    }
  }
  
  void show(){
    noStroke();
    fill(c, 255, 255);
    rectMode(CORNER);
    rect(x, y, 100, 50);
    fill(c, 150, 150);
    rect(x+25, y, 50, 50);
  }

}
