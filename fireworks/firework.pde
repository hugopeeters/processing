class Firework {
  
  Particle firework;
  boolean exploded;
  ArrayList<Particle> particles;
  int hue;
  
  Firework() {
    hue = floor(random(255));
    firework = new Particle(random(width), height, true, hue);
    exploded = false;
    particles = new ArrayList<Particle>();
  }
  
  void update(){
    if (!exploded){
      firework.applyForce(gravity);
      firework.update();
      if(firework.vel.y >= 0){
        exploded = true;
        explode();
      }
    }
    for (int i = particles.size() - 1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.applyForce(gravity);
      p.update();
      if(p.done()){
        particles.remove(i);
      }
    }
  }
  
  void show() {
    if (!exploded){
      firework.show();
    }
    for(Particle p : particles){
      p.show();
    }
  }
  
  void explode(){
    for(int i = 0; i < 100; i++){
      Particle p = new Particle(firework.pos.x, firework.pos.y, false, hue);
      particles.add(p);
    }
  } 
  
  boolean done(){
    if (exploded && particles.size() == 0){
      return true;
    } else {
      return false;
    }
  }

}
