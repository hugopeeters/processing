class Block {
 
  //properties
  float w, h;
  float x, y;
  color c;
  boolean intact;
  
  //constructor
  Block(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = color(random(255), random(255), random(255));
    this.intact = true;
  }
  
  //render
  void render() {
    
    //style
    rectMode(CENTER);
    noStroke();
    fill(c);
    
    //draw
    rect(x, y, w, h);
    
  }
  
}
