class Ball {
  
  float sz;           //size
  float posx, posy;   //position
  PVector v;        //velocity
  float G;       //gravitational acceleration
  boolean grabbed = false;
  boolean released = false;
  float power = 0.2; //throwing power
  float df = 0.75; //dampening factor
  float fr = 0.85; //friction
  float pdL, dL;
  float pdR, dR;
  PImage img;
  
  Ball(float x_, float y_){
    sz = 40;
    G = 0.008 * sz;
    posx = x_;
    posy = y_;
    v = new PVector(0, 0);
    pdL = 999;
    pdR = 999;
    img = loadImage("basketball.png");
  }
  
  void release(float x_, float y_){
    v.x = power * (sposx - x_);
    v.y = power * (sposy - y_);
    released = true;
  }
  
  void update() {
    if (grabbed){
      posx = mouseX;
      posy = mouseY;
      float power = dist(sposx, sposy, posx, posy);
      stroke(floor(map(power, 0, 150, 0, 255)), map(power, 0, 150, 255, 0), 0);
      strokeWeight(2);
      line(sposx, sposy, posx, posy);
    }
    if (released){
      grabbed = false;
      posx += v.x;
      posy += v.y;
     
      //gravity
      v.y += G;
      
      //floor
      if ((posy + sz / 2 >= height && v.y > 0)){
        if (v.y <= 1.8 && v.x <= 1.8) {
          v.y = 0;
          v.x = 0;
        } else {
          bounceSound.play();
          v.y = -v.y * df;
          v.x = v.x * fr;
        }
      }
      
      //wall
      if((posx + sz / 2 >= width && v.x > 0) || (posx - sz / 2 <= 0 && v.x < 0)){
        v.x = -v.x * df;
        v.y = v.y * fr;
        bounceSound.play();
        if (!scored){
          backboard = true;
        }
      }
      
      //ring
      dL = dist(posx ,posy, hoop.Lx, hoop.Ly);
      dR = dist(posx ,posy, hoop.Rx, hoop.Ry);
      
      if (dL <= sz / 2 && pdL > sz / 2){
        float speed = v.mag();
        PVector v2 = new PVector(posx - hoop.Lx, posy - hoop.Ly);
        v2 = v2.normalize().mult(speed * df);
        float angle = PVector.angleBetween(v, v2);
        v = v2.rotate(-angle + PI);
        rimSound.play();
        println("L");
        rim = true;
      }
      if (dR <= sz / 2 && pdR > sz / 2){
        float speed = v.mag();
        PVector v2 = new PVector(posx - hoop.Rx, posy - hoop.Ry);
        v2 = v2.normalize().mult(speed * df);
        float angle = PVector.angleBetween(v, v2);
        v = v2.rotate(-angle + PI);
        rimSound.play();
        println("R");
        rim = true;
      }
      pdL  = dL;
      pdR = dR;
    }
  }
  
  void show() {
    imageMode(CENTER);
    image(img, posx, posy);
  }
}
