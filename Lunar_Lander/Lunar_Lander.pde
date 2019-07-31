Ground ground;
Spaceship ship;
GUI ui;
PVector G;

void setup(){
  size(1200, 800);
  ground = new Ground();
  ship = new Spaceship();
  G = new PVector(0, 0.001);
  ui = new GUI();
}

void draw(){
  background(0);
  ground.render();
  ship.update();
  ship.render();
  ui.render();
}

void keyPressed(){
  //rotate
  if(keyCode == RIGHT){
    ship.dir = 1;
  } else if (keyCode == LEFT){
    ship.dir = -1;
  }
  //thrust
  if(keyCode == UP){
    ship.boosting = true;
  }
}

void keyReleased(){
  ship.dir = 0;
  ship.boosting = false;
}
