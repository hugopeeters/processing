class Ray {

  PVector pos, dir;

  Ray(PVector pos, float angle) {
    this.pos = pos;
    dir = PVector.fromAngle(angle);
  }

  void render() {
    stroke(255);
    pushMatrix();
    translate(pos.x, pos.y);
    line(0, 0, 10 * dir.x, 10 * dir.y);
    popMatrix();
  }
  
  void lookAt(float x, float y){
    dir.x = x - pos.x;
    dir.y = y - pos.y;
    dir.normalize();
  }

  PVector cast(Boundary wall) {
    PVector pt = new PVector(0,0);
    float x1 = wall.a.x;
    float y1 = wall.a.y;
    float x2 = wall.b.x;
    float y2 = wall.b.y;
    float x3 = pos.x;
    float y3 = pos.y;
    float x4 = pos.x + dir.x;
    float y4 = pos.y + dir.y;
    float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    if (den == 0) {
      return null;
    } else {
      float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
      float u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den;
      if (t > 0 && t < 1 && u > 0) {
        pt.x = x1 + t * (x2 - x1);
        pt.y = y1 + t * (y2 - y1);        
        return pt;
      } else {
        return null;
      }
    }
  }
}
