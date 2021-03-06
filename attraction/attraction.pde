//Attractors
// by HugoPeeters
// Based on the CodingTrain challenge 56
// A few thousand particles get attracted by a handful of moving attractors
// The particles' paths are colored by their speed
// The initial conditions and speed restrictions are randomized to create different results.
// The resulting images can be saved.
// Press any key to move to the next simulation.

ArrayList<Attractor> a;
ArrayList<Particle> p;
int numParticles, numAttactors, alpha, colorOffset;
float maxSpeed, speed, vinit, spread, strW, dimX, dimY;
int margin = 50;

void reset() {
  //the reset function randomizes all parameters and restarts the simulation
  frameCount = 0; //the framecount is being used to slowly decrease the alpha

  //set parameters to random values within boundaries
  numParticles = round(random(500, 2500)); //number of particles
  maxSpeed = random(1, 50); //maximum speed of the particles.
  speed = random(0, 3); //speed of the attactors moving in random directions and bouncing off the walls, best results with 0 - 1.
  numAttactors = round(random(1, 10)); //Number of attractors. 1 - 10 works well.
  vinit = random(3, 7); //initial velocity of particles. Creates spread. 3 - 7 works well.
  spread = random(0, 0.2); //spread in initial position of the particles
  strW = sqrt(random(1, 4)); //stroke weight. set to 1 for crisp lines
  colorOffset = round(random(255));
  //IDEA: add number of starting points

  //fill the screen with blackness
  background(0);

  //create attractors and particles
  p = new ArrayList<Particle>();
  //pick random position
  float x = random(margin, width - margin);
  float y = random(margin, height - margin);
  for ( int i = 0; i < numParticles; i++) {
    //add spread
    float xi = x *  random(1 + spread, 1 - spread);
    float yi = y *  random(1 + spread, 1 - spread);
    p.add(new Particle(new PVector(xi, yi)));
  }

  a = new ArrayList<Attractor>();  
  for ( int i = 0; i < numAttactors; i++) {
    a.add(new Attractor());
  }
}

void setup() {
  reset();
  //size(1024, 600);
  fullScreen();
  noCursor();
}

void draw() {
  //background(0, 100);
  alpha = round(3 - frameCount/random(300, 4800));
  if (alpha == 0) {
    //using -1 instead of 0 gives us some time to enjoy the final result
    String filename = "examples/" + numParticles + "-" + round(maxSpeed) + "-" + round(speed) + "-" + numAttactors + "-" + round(vinit) + "-" + round(10*spread) + "-" + round(strW) + "-" + colorOffset + ".jpg";
    //save(filename);
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

void keyPressed() {
  //press any key ro skip to the next simulation
  reset();
}
