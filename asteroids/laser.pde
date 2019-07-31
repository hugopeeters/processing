class Laser{
 
  PVector pos;
  PVector vel;
  float heading;
  float ttl = 60;
  
  Laser(PVector pos, float heading){
    this.pos = new PVector(pos.x, pos.y);
    vel = PVector.fromAngle(heading);
    vel.mult(5);
  }
  
  void show(){
    pushMatrix();
    stroke(255);
    strokeWeight(4);
    //translate(pos.x, pos.y);
    point(pos.x, pos.y);
    popMatrix();
  }
  
  void update(){
    pos.add(vel);
  }
  
  boolean hits(Asteroid a){
    float d = dist(pos.x, pos.y, a.pos.x, a.pos.y); 
    return d < a.r;
  }
  
  boolean offscreen(){
    return (pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height);
  }
}
