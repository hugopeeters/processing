class Die {

  float sz, corner, eyesz;
  int val;
  PVector pos;
  Eye[] eyes;
  boolean held;

  Die(float x, float y, int val) {
    sz = 55;
    corner = sz/6;
    eyesz = sz/6;
    this.val = val;
    pos = new PVector(x, y);
    held = false;
    updateVal();
  }

  void render() {
    fill(255, 255, 240);
    stroke(0);
    if (held) {
      stroke(255, 0, 0);
    }
    strokeWeight(2);
    rect(pos.x, pos.y, sz, sz, corner);
    if (phase != 0) {
      for (int i = 0; i < eyes.length; i++) {
        eyes[i].render(pos.x, pos.y);
      }
    }
  }

  void roll() {
    val = round(random(1, 6));
    updateVal();
  }


  void updateVal() {
    eyes = new Eye[val];
    switch(val) {
    case 1 : 
      eyes[0] = new Eye(sz/2, sz/2, eyesz);
      break;
    case 2 : 
      eyes[0] = new Eye(sz/4, sz/4, eyesz);
      eyes[1] = new Eye(3*sz/4, 3*sz/4, eyesz);
      break;
    case 3 :
      eyes[0] = new Eye(sz/4, sz/4, eyesz);
      eyes[1] = new Eye(sz/2, sz/2, eyesz);
      eyes[2] = new Eye(3*sz/4, 3*sz/4, eyesz);
      break;
    case 4 :
      eyes[0] = new Eye(sz/4, sz/4, eyesz);
      eyes[1] = new Eye(3*sz/4, sz/4, eyesz);
      eyes[2] = new Eye(sz/4, 3*sz/4, eyesz);
      eyes[3] = new Eye(3*sz/4, 3*sz/4, eyesz);
      break;
    case 5 :
      eyes[0] = new Eye(sz/4, sz/4, eyesz);
      eyes[1] = new Eye(3*sz/4, sz/4, eyesz);
      eyes[2] = new Eye(sz/4, 3*sz/4, eyesz);
      eyes[3] = new Eye(3*sz/4, 3*sz/4, eyesz);
      eyes[4] = new Eye(sz/2, sz/2, eyesz);
      break;
    case 6 :
      eyes[0] = new Eye(sz/4, sz/4, eyesz);
      eyes[1] = new Eye(sz/4, sz/2, eyesz);
      eyes[2] = new Eye(sz/4, 3*sz/4, eyesz);
      eyes[3] = new Eye(3*sz/4, sz/4, eyesz);
      eyes[4] = new Eye(3*sz/4, sz/2, eyesz);
      eyes[5] = new Eye(3*sz/4, 3*sz/4, eyesz);
      break;
    }
  }
}
