class Ground {

  float w; //width
  ArrayList<PVector> vertices;
  float resolution;

  Ground() {
    w = 12000;
    resolution = 60;
    vertices = new ArrayList<PVector>();
    float x1 = 0;
    float y1 = height - 300 * noise(0);
    vertices.add(new PVector(x1, y1));
    float prev = 0;
    for (int i = 1; i < resolution + 2; i++) {
      float x = prev+(width/resolution);
      float y = height - 300 * noise(i*0.15);
      vertices.add(new PVector(x, y));
      prev = x;
    }
  }

  void render() {
    stroke(255);
    for (int i = 1; i < vertices.size()-1; i++) {
      //ellipse(vertices.get(i).x, vertices.get(i).y, 4, 4);
      line(vertices.get(i-1).x, vertices.get(i-1).y, vertices.get(i).x, vertices.get(i).y);
    }
  }
}
