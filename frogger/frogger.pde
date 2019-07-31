ArrayList<Car> cars;
int[] lanes = {125, 200, 275, 475, 550, 625};
Frog frog;
boolean gameover = false;

void setup() {
  size(1200, 800);
  colorMode(HSB, 255);
  cars = new ArrayList<Car>();
  for (int i = 0; i < lanes.length; i++) {
    float laneSpeed = random(7, 10) - i;
    cars.add(new Car(random(0, 275), lanes[i], laneSpeed));
    cars.add(new Car(random(400, 675), lanes[i], laneSpeed));
    cars.add(new Car(random(800, 1075), lanes[i], laneSpeed));
  }
  frog = new Frog();
}

void draw() {
  background(51);
  //sidewalk
  fill(150);
  stroke(0, 0, 100);
  strokeWeight(4);
  rectMode(CORNER);
  rect(-4, -4, width+8, 96);
  rect(-4, height - 96, width+8, 100);
  //center curb
  rectMode(CENTER);
  rect(width/2, height/2, width+8, 100);

  for (Car c : cars) {
    c.show();
    if (!gameover) {
      c.update();
    }
  }
  frog.show();
}

void keyPressed() {
  if (!gameover) {
    if (keyCode == UP) {
      frog.jump(0);
    } else if (keyCode == RIGHT) {
      frog.jump(1);
    } else if (keyCode == DOWN) {
      frog.jump(2);
    } else if (keyCode == LEFT) {
      frog.jump(3);
    }
  }
}
