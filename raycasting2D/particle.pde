class Particle {

  PVector pos;
  ArrayList<Ray> rays;

  Particle() {
    pos = new PVector(200, 200);
    rays = new ArrayList<Ray>();
    for (int i  =0; i < 360; i += 3) {
      rays.add(new Ray(pos, radians(i)));
    }
  }

  void render() {
    fill(255);
    ellipse(pos.x, pos.y, 4, 4);
    for ( int i = 0; i < rays.size(); i++) {
      rays.get(i).render();
    }
  }

  void look(ArrayList<Boundary> walls) {
    for ( Ray ray : rays) {
      PVector closest = null;
      float record = height + width;
      for (Boundary wall : walls) {
        PVector pt = ray.cast(wall);
        if (null != pt) {
          float d = PVector.dist(pos, pt);
          if (d < record) {
            record = d;
            closest = pt;
          }
        }
      }
      if (null != closest) {
        stroke(255, 10);
        line(pos.x, pos.y, closest.x, closest.y);
      }
    }
  }

  void update(float x, float y) {
    pos.set(x, y);
  }
}
