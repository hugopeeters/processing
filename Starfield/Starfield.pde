//config
float maxSpeed = 50;
float minSpeed = 1;
int numStars = 1500;

//declare vaiables
Star[] stars = new Star[numStars];
float speed;

void setup() {
  size(800, 800);
  for (int i = 0; i < stars.length; i++){
    stars[i] = new Star();
  }
}

void draw() {
  background(0);
  translate(width/2,height/2);
  speed = map(mouseY, 0, height, maxSpeed, minSpeed);
  for (int i = 0; i < stars.length; i++){
    stars[i].update();
    stars[i].show();
    
    //speedometer
    fill(128);
    noStroke();
    rect(25 - width/2, 25 - height/2, 200, 50);
    fill(map(speed, minSpeed, maxSpeed, 0, 255), map(speed, minSpeed, maxSpeed, 255, 0), 0);
    rect(30 - width/2, 30 - height/2, map(speed, minSpeed, maxSpeed, 0, 190), 40);
  }
}
