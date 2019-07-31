class Ray {

  PVector start, end;

  Ray(PVector start, PVector end) {
    this.start = start;
    this.end = end;
  }

  void render() {
    stroke(255);
    line(start.x, start.y, end.x, end.y);
  }

  PVector getIntersections(Boundary wall) {
    PVector pt = new PVector(0, 0);
    float x1 = wall.a.x;
    float y1 = wall.a.y;
    float x2 = wall.b.x;
    float y2 = wall.b.y;
    float x3 = start.x;
    float y3 = start.y;
    float x4 = end.x;
    float y4 = end.y;
    float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    if (den == 0) {
      return null;
    } else {
      float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
      float u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den;
      if (t >= 0 && t <= 1 && u > 0) {
        pt.x = x1 + t * (x2 - x1);
        pt.y = y1 + t * (y2 - y1);        
        return pt;
      } else if (u >= 0 && u <= 1) {
        pt.x = x3 + u * (x4 - x3);
        pt.y = y3 + u * (y4 - y3);        
        return null;
      } else {
        return null;
      }
    }
  }
}
