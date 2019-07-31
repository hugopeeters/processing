class Edge {

  PVector a, b, offset1, offset2;
  Hankin h1, h2;

  Edge(PVector a, PVector b) {
    this.a = a;
    this.b = b;
  }

  void show() {
    stroke(255, 10);
    line(a.x, a.y, b.x, b.y);
    h1.show();
    h2.show();
  }

  void hankin() {
    PVector mid = a.copy().add(b.copy()).mult(0.5);
    PVector v1 = a.copy().sub(mid);
    PVector v2 = b.copy().sub(mid);
    if (delta > 0) {
      v1.setMag(delta);
      v2.setMag(delta);
      offset1 = mid.copy().add(v2);
      offset2 = mid.copy().add(v1);
    } else {
      offset1 = mid;
      offset2 = mid;
    }
    v1.normalize();
    v2.normalize();
    v1.rotate(radians(-angle));
    v2.rotate(radians(angle));
    h1 = new Hankin(offset1, v1);
    h2 = new Hankin(offset2, v2);
  }

  void findEnds(Edge edge) {
    h1.findEnd(edge.h1);
    h1.findEnd(edge.h2);
    h2.findEnd(edge.h1);
    h2.findEnd(edge.h2);
  }
}
