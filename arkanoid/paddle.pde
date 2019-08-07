class Paddle {
  
  //properties
  float w = 100;
  float h = 10;
  float x;
  float distanceFromScreenBottom = 50;
  float speed = 5;
  float v = 0;
  color c = color(255);
  
  //constructor
  Paddle(float x) {
    this.x = x;
  }
  
  //update changes
  void update() {
    
    //restrictions
    if ((this.x + this.w / 2 >= width && this.v == +1) || (this.x - this.w / 2 <= 0 && this.v == -1)) {
      this.v = 0;
    }
    
    //physics
    this.x += this.v * this.speed;
    
  }
  
  //render
  void render() {
    
    //style
    noStroke();
    fill(this.c);
    rectMode(CENTER);
    
    //position of sub-elements
    float r = h;
    float y = height - distanceFromScreenBottom;
    float wRect = this.w - r;
    float xEllipse1 = this.x - wRect / 2;
    float xEllipse2 = this.x + wRect / 2;
    
    //render
    rect(x, y, wRect, this.h);
    ellipse(xEllipse1, y, r, r);
    ellipse(xEllipse2, y, r, r);
  }
  
}
