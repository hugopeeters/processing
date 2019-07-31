class Polygon {

  ArrayList<Edge> edges;
  ArrayList<PVector> vertices;

  Polygon() {
    edges = new ArrayList<Edge>();
    vertices = new ArrayList<PVector>();
  }

  void addVertex(float x, float y) {
    PVector a = new PVector(x, y);
    int total = vertices.size();
    if (total > 0) {
      PVector prev = vertices.get(total-1);
      Edge edge = new Edge(prev, a);
      edges.add(edge);
    }
    vertices.add(a);
  }

  void close() {
    int total = vertices.size();
    PVector last = vertices.get(total - 1);
    PVector first = vertices.get(0);
    Edge edge = new Edge(last, first);
    edges.add(edge);
  }

  void hankin() {
    for (int i = 0; i < edges.size(); i++) {
      edges.get(i).hankin();
    }
    for (int i = 0; i < edges.size(); i++) {
      for (int j = 0; j < edges.size(); j++) {
        if (j != i) {
          edges.get(j).findEnds(edges.get(i));
        }
      }
    }
  }

  void show() {
    for (int i = 0; i < edges.size(); i++) {
      edges.get(i).show();
    }
  }
}
