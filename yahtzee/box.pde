class Box {

  String name, description;
  int score;
  boolean set;
  PVector pos;
  float w, w2, h;

  Box(String name, String description, float x, float y) {
    this.name = name;
    this.description = description;
    score = 0;
    set = false;
    pos = new PVector(x, y);
    w = 150;
    w2 = 300;
    h = 50;
  }

  void render() {
    fill(255);
    stroke(0);
    strokeWeight(2);
    rect(pos.x, pos.y, w, h); 
    rect(pos.x + w, pos.y, w2, h);
    fill(0);
    textSize(16);
    textAlign(LEFT);
    text(name, pos.x + 8, pos.y + h/2 + 8);
    text(description, pos.x + w + 8, pos.y + h/2 + 8);
    textAlign(RIGHT);
    if (!set) {
      fill(168);
      rect(pos.x + w + w2, pos.y, w, h);
      fill(255);
      text(score, pos.x + 2*w + w2 - 8, pos.y + h/2 + 8);
    } else {
      fill(255);
      rect(pos.x + w + w2, pos.y, w, h);
      fill(0);
      text(score, pos.x + 2*w + w2 - 8, pos.y + h/2 + 8);
    }
    
  }
}
