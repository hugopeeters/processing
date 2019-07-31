class Curve {

  PVector basePos, pos;
  ArrayList<PVector> curvePoints;

  Curve(PVector basePos) {
    this.basePos = basePos;
    pos = basePos.copy();
    curvePoints = new ArrayList<PVector>();
  }

  void update(float x, float y) {
    pos.x = basePos.x + x; 
    pos.y = basePos.y + y;
    curvePoints.add(pos.copy());
    if(curvePoints.size() > 250){
      curvePoints.remove(0);
    }
  }

  void render() {
    stroke(255, 0, 0);
    noFill();
    beginShape();
    for (PVector pt : curvePoints){
      vertex(pt.x, pt.y);
    }
    endShape();
  }
}
