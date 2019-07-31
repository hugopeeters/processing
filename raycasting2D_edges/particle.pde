class Particle {

  PVector pos;
  ArrayList<Ray> rays;

  Particle() {
    pos = new PVector(200, 200);
    rays = new ArrayList<Ray>();
  }

  void render() {
    fill(255);
    ellipse(pos.x, pos.y, 4, 4);
    for ( int i = 0; i < rays.size(); i++) {
      rays.get(i).render();
    }
  }

  void createRays(ArrayList<Boundary> walls) {
    rays = new ArrayList<Ray>();
    for (Boundary wall : walls) {
      rays.add(new Ray(pos, wall.a));
      PVector closest = null;
      float record = height + width;
      for (Boundary testwall : walls) {
        if (testwall != wall) {
          PVector pt = rays.get(rays.size() - 1).getIntersections(testwall);
          if (null != pt) {
            float d = PVector.dist(pos, pt);
            if (d < record) {
              record = d;
              closest = pt;
              //ellipse(pt.x, pt.y, 4, 4);
            }
          }
        }
      }
      for (Boundary testwall : outsidewalls) {
        if (testwall != wall) {
          PVector pt = rays.get(rays.size() - 1).getIntersections(testwall);
          if (null != pt) {
            float d = PVector.dist(pos, pt);
            if (d < record) {
              record = d;
              closest = pt;
              //ellipse(pt.x, pt.y, 4, 4);
            }
          }
        }
      }
      if (null != closest) {
        float min = PVector.dist(pos, wall.a);
        if (record < min) {
          rays.remove(rays.size() - 1);
        } else {
          rays.get(rays.size() - 1).end = closest;
          ellipse(closest.x, closest.y, 4, 4);
        }
      }
      rays.add(new Ray(pos, wall.b));
      closest = null;
      record = height + width;
      for (Boundary testwall : walls) {
        if (testwall != wall) {
          PVector pt = rays.get(rays.size() - 1).getIntersections(testwall);
          if (null != pt) {
            float d = PVector.dist(pos, pt);
            if (d < record) {
              record = d;
              closest = pt;
              //ellipse(pt.x, pt.y, 4, 4);
            }
          }
        }
      }
      for (Boundary testwall : outsidewalls) {
        if (testwall != wall) {
          PVector pt = rays.get(rays.size() - 1).getIntersections(testwall);
          if (null != pt) {
            float d = PVector.dist(pos, pt);
            if (d < record) {
              record = d;
              closest = pt;
              //ellipse(pt.x, pt.y, 4, 4);
            }
          }
        }
      }
      if (null != closest) {
        float min = PVector.dist(pos, wall.b);
        if (record < min) {
          rays.remove(rays.size() - 1);
        } else {
          rays.get(rays.size() - 1).end = closest;
          ellipse(closest.x, closest.y, 4, 4);
        }
      }
    }
  }



  void update(float x, float y) {
    pos.set(x, y);
  }
}
