class Symbol {

  float x;
  float y;
  char value;
  float speed;
  int switchInterval;
  boolean first;

  Symbol(float x_, float y_, float s_, boolean f) {
    first = f;
    x = x_;
    y = y_;
    speed = s_;
    switchInterval = round(random(5, 20));
  }

  void setRandomSymbol() {
    if (frameCount % switchInterval == 0) {
      float r = random(1);
      if (r < 0.8){
        value = char(0x0061 + round(random(0, 25)));
      } else {
        value = char(0x0030 + round(random(0, 9)));
      }
    }
  }

  void rain() {

    //if (y >= height) {
    //  y = 0;
    //} else {
    //  y += speed;
    //}

    //shorthand for above
    y = (y >= height) ? 0 : y + speed;
  }
}
