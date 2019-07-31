class Bird {
  
  float x = 100;
  float y;
  float v = 0;
  float gravity = 0.3;
  float flappower = 10;
  
  Bird (float y_){
    y = y_;
  }
  
  void update(){
    v += gravity;
    v *= 0.95;
    y += v;
    
    //crash
    if (y > height){
      y = height;
      v = 0;
    }
    if (y < 0){
      y = 0;
      v = 0;
    }
  }
  
  void flap(){
    v -= flappower;
  }
  
  void show(){
    fill(255);
    ellipse(x, y, 32, 32);
  }
}
