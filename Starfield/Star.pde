class Star {
 
  float px;
  float py;
  float sx;
  float sy;
  float x;
  float y; 
  float z;
  
  Star(){
    x = random(-width, width);
    y = random(-height, height);
    z = random(0, width);
    px = x;
    py = y;
  }
  
  void update() {
     z = z - speed ;
     if (z < 1) {
       z = width;
       x = random(-width, width);
       y = random(-height, height);
       px = x;
       py = y;
     } else {
       px = sx;
       py = sy;
     }
     sx = map(x/z, 0, 1, 0, width);
     sy = map(y/z, 0, 1, 0, height);
  }
   
  void show() {
      stroke(255);
      strokeWeight(map(z, 0, width, 8, 1));
      line(px, py, sx, sy);
  }
}
