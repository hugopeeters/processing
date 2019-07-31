class Hankin {

  PVector a, v, b;
  float angle;

  Hankin(PVector a, PVector v) {
    this.a = a;
    this.v = v;
    b = a.copy().add(v);
  }

  void show() {
    stroke(255, 0, 0);
    line(a.x, a.y, b.x, b.y);
  }
}
