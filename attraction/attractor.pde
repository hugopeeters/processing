class Attractor {
  
  PVector pos, vel;
  float mass;
  
  Attractor(){
    //the scale prevents attractors starting too far from the center of the screen
    pos = new PVector(random(10, width - 10), random(10, height - 10));
    vel = PVector.random2D();
    vel.setMag(speed);
    mass = random(0.1, 10);
  }
  
  void update(){
    pos.add(vel); //update the position
    //bounce off the walls
    if(pos.x < 0 || pos.x > width){
      vel.x *= -1;
    }
    if(pos.y < 0 || pos.y > height){
      vel.y *= -1;
    }
  }
  
  void render(){
    colorMode(RGB);
    strokeWeight(4);
    stroke(0, 255, 0);
    point(pos.x, pos.y);
  }
  
}
