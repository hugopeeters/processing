class Particle {
  
  PVector pos;
  PVector vel;
  PVector acc;
  boolean firework;
  int lifespan;
  int hue;
  
  Particle(float x_, float y_, boolean f_, int h_) {  
    hue = h_;
    firework = f_;
    lifespan = 255;
    pos = new PVector(x_, y_);
    if(firework){
      vel = new PVector(0, random(-14, -8));
    } else {
      vel = PVector.random2D();
      //vel.mult(8);
      vel.mult(random(1, 8));
    }
    acc = new PVector(0, 0); 
  }
  
  void applyForce(PVector force){
    acc.add(force);
  }
  
  void update() {
    if(!firework){
      vel.mult(0.9);
      lifespan -= 6;
    }
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }
  
  void show(){
    if (!firework){
      strokeWeight(2);
      stroke(hue, 255, 255, lifespan);
    } else {
      strokeWeight(4);
      stroke(hue, 255, 255);
    }
    point(pos.x, pos.y);
  }
  
  boolean done(){
    if (lifespan < 0){
      return true;
    } else {
      return false;
    }
  }
}
