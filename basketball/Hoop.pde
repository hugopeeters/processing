class Hoop {
  
  float posx, posy;
  float h, w;
  float Lx, Ly;
  float Rx, Ry;
  
  Hoop(){
    h = 10;
    w = random(75, 100);
    posx = width - w / 2 - 15;
    posy = random(300, 500);
    Lx = posx - w / 2;
    Ly = posy;
    Rx = posx + w / 2;
    Ry = posy;
  }
  
  void show(){
    noStroke();
    fill(255);
    rectMode(CENTER);
    rect(posx, posy, w, h);
  }
}
