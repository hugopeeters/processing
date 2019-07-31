//Diffusion Limited Aggregation

ArrayList<Walker> tree;
ArrayList<Walker> walkers;
int maxWalkers = 500;
int iterations = 500;
float radius = 6;
boolean showAll = false;
float shrinkage = 0.9975;
float h = 0; //rainbow colors
//float h = 100; //lightning colors
//float stickiness = 0.9; //also uncomment the stickiness code in the walker class

void setup() {
  size(600, 600);
  colorMode(HSB);
  tree = new ArrayList<Walker>();
  walkers = new ArrayList<Walker>();
  tree.add(new Walker(new PVector(width/2, 0))); //change starting position here
  tree.get(0).stuck = true;
}

void draw() {

  background(0);

  for (int i = 0; i < tree.size(); i++) {
    tree.get(i).show();
  }
  if (radius > 1) {
    if (showAll) {
      for (int i = 0; i < walkers.size(); i++) {
        walkers.get(i).show();
      }
    }
    for (int n = 0; n < iterations; n++) {
      for (int i = walkers.size() -1; i >= 0; i--) {
        walkers.get(i).walk();
        if (walkers.get(i).isStuck(tree)) {
          radius *= shrinkage;
          walkers.get(i).r = radius;
          h += 0.5; //rainbow
          //h += 0.25; //lightning
          walkers.get(i).hue = floor(h);
          tree.add(walkers.get(i));
          walkers.remove(i);
        }
      }
    }

    while (walkers.size() < maxWalkers) {
      walkers.add(new Walker(bottomHalf())); //change starting positions here, using functions below
    }
  }
}

PVector randomEdge() {
  int i = floor(random(4));

  if (i == 0) {
    return new PVector(0, random(height));
  } else if (i == 1) {
    return new PVector(width, random(height));
  } else if (i == 2) {
    return new PVector(random(width), 0);
  } else {
    return new PVector(random(width), height);
  }
}

PVector bottomHalf() {
  return new PVector(random(width), random(height / 2, height));
}
