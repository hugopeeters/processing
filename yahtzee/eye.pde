class Eye{
  
  float xOff, yOff, eyesz;
  
  Eye(float xOff, float yOff, float eyesz){
    this.xOff = xOff;
    this.yOff = yOff;
    this.eyesz = eyesz;
  }
  
  void render(float x, float y){
    noStroke();
    fill(0);
    ellipse(x + xOff, y + yOff, eyesz, eyesz);
  }
}
