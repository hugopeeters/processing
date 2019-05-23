class Attractor {
  
  PVector pos, vel, acc;
  float mass, dimX, dimY;
  
  Attractor(){
    //the margin prevents attractors starting too far from the center of the screen
    pos = new PVector(random(margin, width - margin), random(margin, height - margin));
    vel = new PVector(0, 0);
    dimX = random(10);
    dimY = random(10);
    acc = new PVector(noise(dimX, 0)-0.5, noise(0, dimY)-0.5);
    mass = random(0.1, 10);
  }
  
  void update(){
    acc = new PVector(noise(dimX, 0)-0.5, noise(0, dimY)-0.5);
    vel.add(acc);
    vel.setMag(speed);
    acc.mult(0);
    pos.add(vel); //update the position
    pos.x += noise(dimX);
    //bounce off the walls
    if(pos.x < 0  && vel.x < 0){
      vel.x *= -1;
    }
    if(pos.y < 0 && vel.y < 0){
      vel.y *= -1;
    }
    if(pos.x > width && vel.x > 0){
      vel.x *= -1;
    }
    if(pos.y > height && vel.y > 0){
      vel.y *= -1;
    }
    dimX += 0.1;
    dimY += 0.1;
  }
  
  void render(){
    colorMode(RGB);
    strokeWeight(4);
    stroke(0, 255, 0);
    point(pos.x, pos.y);
  }
  
}
