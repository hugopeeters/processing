class Branch {
  
  PVector start, end;
  float len;
  boolean finished;
  
  Branch(PVector s, PVector e) {
    start = s;
    end = e;
    finished = false;
    len = dist(start.x, start.y, end.x, end.y);
  }
  
  Branch spawn(float angle){
    float newx = end.x + 0.67 * len * sin(angle);
    float newy = end.y - 0.67 * len * cos(angle);
    PVector newEnd = new PVector(newx, newy);
    Branch right = new Branch(end, newEnd);
    return right;
  }
  
  void show() {
    stroke(255);
    line(start.x, start.y, end.x, end.y);
  }
}
