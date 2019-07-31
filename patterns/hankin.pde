class Hankin {

  PVector a, v, b, end;
  float angle, prevD;

  Hankin(PVector a, PVector v) {
    this.a = a;
    this.v = v;
    b = a.copy().add(v);
  }

  void show() {
    stroke(255, 0, 0);
    line(a.x, a.y, end.x, end.y);
  }

  void findEnd(Hankin other) {
    float den = (other.v.y * this.v.x) - (other.v.x * this.v.y);
    float numa = (other.v.x * (this.a.y - other.a.y)) - (other.v.y * (this.a.x - other.a.x));
    float numb = (this.v.x * (this.a.y - other.a.y)) - (this.v.y * (this.a.x - other.a.x));
    float ua = numa / den;
    float ub = numb / den;
    float x = this.a.x + ua * this.v.x;
    float y = this.a.y + ua * this.v.y;

    if (ua > 0 && ub > 0) {
      PVector candidate = new PVector(x, y);
      float d1 = candidate.dist(a);
      float d2 = candidate.dist(other.a);
      float d = d1 + d2;
      float diff = abs(d1 - d2);
      if (diff < 0.001) {
        if (end == null) {
          end = candidate;
          prevD = d;
        } else if (d < prevD) {
          end = candidate;
          prevD = d;
        }
      }
    }
  }
}
