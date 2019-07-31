import processing.sound.*;
SoundFile scoreSound;
SoundFile rimSound;
SoundFile bounceSound;
Ball ball;
Hoop hoop;
float sposx;
float sposy;
boolean scored;
int points;
boolean rim;
boolean backboard;
String cheer;
String message;

void setup(){
  size(800, 800);
  scored = false;
  rim = false;
  backboard = false;
  sposx = random(100, 200);
  sposy = random(300, 700);
  ball = new Ball(sposx, sposy);
  hoop = new Hoop();
  points = 0;
  cheer = "";
  message = "Press 'R' to reset";
  scoreSound = new SoundFile(this, "score.wav");
  rimSound = new SoundFile(this, "rim.wav");
  bounceSound = new SoundFile(this, "bounce.wav");
}

void draw(){
  background(51);
  noStroke();
  fill(255);
  textSize(32);
  textAlign(CENTER);
  text(points, 100, 100);
  text(cheer, width / 2, 100);
  textSize(16);
  text("score", 100, 50);
  text(message, width / 2, height - 50);
  ball.update();
  ball.show();
  hoop.show();
  if(score()){
    scoreSound.play();
    scored = true;
    println("score!");
    points++;
  }
  if(scored){
    if (!rim && !backboard){
      cheer = "BOOM!";
    } else if (rim && !backboard){
      cheer = "SCORE!";
    } else if (backboard && !rim){
      cheer = "CLEAN!";
    } else {
      cheer = "WOW!";
    }
  } else {
    cheer = "";
  }
}

void mousePressed(){
  if (dist(mouseX, mouseY, sposx, sposy) < ball.sz && !ball.released){
    ball.grabbed = true;
  }
}

void mouseReleased(){
  if (ball.grabbed){
    ball.release(mouseX, mouseY); 
  }
}

boolean score(){
  if (!scored && ball.posx >= hoop.posx - hoop.w / 2 && ball.posx <= hoop.posx + hoop.w / 2 && ball.posy - hoop.posy < 10 && hoop.posy - ball.posy < 10 && ball.v.y > 0){
    return true;
  } else {
    return false;
  }
}

void keyPressed() {
  if (key == 'R' || key == 'r'){
    println("resetting");
    scored = false;
    rim = false;
    backboard = false;
    sposx = random(100, 200);
    sposy = random(200, 600);
    ball = new Ball(sposx, sposy);
    hoop = new Hoop();
    
  }
}
