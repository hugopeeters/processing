class Food {

  PVector pos;
  boolean good;
  int index;
  color c;

  Food(PVector pos, boolean good, int index) {
    this.pos = pos;
    this.good = good;
    this.index = index;
    if (good) {
      c = color(0, 255, 0);
    } else {
      c = color(255, 0, 0);
    }
  }

  void render() {
    noStroke();
    fill(c);
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, 4, 4);
  }
}


//GLOBAL FUNCTIONS
void addPoison() {
  while (countPoison() < vehicles.size() / 4) {
    food.add(new Food(new PVector(random(field[0].x + 5, field[1].x - 5), random(field[0].y + 5, field[1].y - 5)), false, food.size()));
  }
}

void addFood() {
  while (food.size() < 100) {
    food.add(new Food(new PVector(random(field[0].x + 5, field[1].x - 5), random(field[0].y + 5, field[1].y - 5)), true, food.size()));
  }
}

int countPoison() {
  int poisonCount = 0;
  for (int i = 0; i < food.size(); i++) {
    if (food.get(i).good != true) {
      poisonCount++;
    }
  }
  return poisonCount;
}
