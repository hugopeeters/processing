Ship ship;
ArrayList<Asteroid> asteroids;
ArrayList<Laser> lasers;

void setup() {
  size(1200, 800);
  ship = new Ship();
  asteroids = new ArrayList<Asteroid>();
  for (int i = 0; i < 8; i++) {
    asteroids.add(new Asteroid(null, 1));
  }
  lasers = new ArrayList<Laser>();
}

void draw() {
  background(0);

  for (Asteroid a : asteroids) {
    if (ship.hits(a)) {
      println("GAME OVER");
      noLoop();
    }
    a.show();
    a.update();
  }
  for (int j = lasers.size() - 1; j >= 0; j--) {
    lasers.get(j).show();
    lasers.get(j).update();
    if (lasers.get(j).offscreen()) {
      lasers.remove(j);
    } else {
      for (int i = asteroids.size() - 1; i >= 0; i--) {
        if (lasers.get(j).hits(asteroids.get(i))) {
          //hit
          if (asteroids.get(i).r > 10) {
            Asteroid[] newAsteroids = asteroids.get(i).breakup();
            asteroids.add(newAsteroids[0]);
            asteroids.add(newAsteroids[1]);
          }
          asteroids.remove(i);
          lasers.remove(j);
          break;
        }
      }
    }
  }
  ship.show();
  ship.turn();
  ship.update();
}

void keyPressed() {
  if (keyCode == LEFT) {
    ship.setRotation(-0.1);
  } else if (keyCode == RIGHT) {
    ship.setRotation(0.1);
  } else if (keyCode == UP) {
    ship.boosting = true;
  } else if (key == ' ') {
    lasers.add(new Laser(ship.pos, ship.heading));
  }
}

void keyReleased() {
  ship.setRotation(0);
  ship.boosting = false;
}
