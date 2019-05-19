ArrayList<Attractor> a;
ArrayList<Particle> p;
int numParticles, scale, numAttactors, alpha;
float maxSpeed, speed, vinit, spread;

void reset() {
  //the reset function randomizes all parameters and restarts the simulation
  frameCount = 0; //the framecount is being used to slowly decrease the alpha
  
  //set parameters to random values within boundaries
  numParticles = round(random(500, 2500)); //number of particles
  maxSpeed = random(1, 50); //maximum speed of the particles.
  speed = random(0, 3); //speed of the attactors moving in random directions and bouncing off the walls, best results with 0 - 1.
  scale = round(random(3, 8)); //value above 3. Sets the margins as 1/scale
  numAttactors = round(random(1, 10)); //Number of attractors. 1 - 10 works well.
  vinit = random(3, 7); //initial velocity of particles. Creates spread. 3 - 7 works well.
  spread = random(0, 0.1); //spread in initial position of the particles
  
  //write parameter values to the console for reference if you really love a cretain result
  println("numParticles: " + numParticles);
  println("maxSpeed: " + maxSpeed);
  println("speed: " + speed);
  println("scale: " + scale);
  println("numAttactors: " + numAttactors);
  println("vinit: " + vinit);
  println("spread: " + spread);
  
  //fill the screen with blackness
  background(0);
  
  //create attractors and particles
  a = new ArrayList<Attractor>();
  p = new ArrayList<Particle>();
  PVector pos = new PVector(width/scale, height/scale);
  for ( int i = 0; i < numParticles; i++) {
    float x = pos.x * random(1 + spread, 1 - spread); 
    float y = pos.y * random(1 + spread, 1 - spread); 
    p.add(new Particle(new PVector(x, y)));
  }
  for ( int i = 0; i < numAttactors; i++) {
    a.add(new Attractor());
  }
}

void setup() {
  reset();
  //size(1200, 1200);
  fullScreen();
}

void draw() {
  alpha = round(3 - frameCount/500);
  if (alpha == -1) {
    //using -1 instead of 0 gives us some time to enjoy the final result
    reset();
  }
  //loop throught the attractors
  for (int j = 0; j < a.size(); j++) {
    //a.get(j).render(); //uncomment to see the attractors and their paths
    a.get(j).update(); //update the attractors' positions
  }
  //loop through the particles
  for (int i = 0; i < p.size(); i++) {
    p.get(i).render(); //draw the particles
    for (int j = 0; j < a.size(); j++) {
      p.get(i).getAttracted(a.get(j)); //apply attraction forces
    }
    p.get(i).update(); //update the particles physics
  }
}
