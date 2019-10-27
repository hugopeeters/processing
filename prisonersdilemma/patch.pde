class Patch {

  int k, i, j;     //index, col, row
  float sz;  //size
  double score;
  boolean prevCoop, coop, nextCoop;
  color c;
  PVector pos;
  ArrayList<Patch> neighbours;

  Patch(int k) {
    this.k = k;
    this.sz = floor(canvasSize/N);
    this.score = 0;
    this.reset();
    this.setColor();
    this.i = this.k % N;
    this.j = floor(this.k / N);
    float x = (this.i + 0.5) * sz;
    float y = (this.j + 0.5) * sz;
    pos = new PVector(x, y);
    neighbours = new ArrayList<Patch>();
  }

  void reset() {
    this.coop = random(1) >= 0.5;
    this.prevCoop = this.coop;
  }

  void setColor() {
    if (this.coop && this.prevCoop) {
      c = color(255, 0, 0);
    } else if (this.coop && !this.prevCoop) {
      c = color(255, 100, 100);
    } else if (!this.coop && !this.prevCoop) {
      c = color(0, 0, 255);
    } else {
      c = color(100, 100, 255);
    }
  }

  void update() {
    findNeighbours();
    calculateScore();
    updateStrategy();
    setColor();
  }

  void render() {
    noStroke();
    fill(c);
    ellipse(this.pos.x, this.pos.y, this.sz, this.sz);
  }

  private void findNeighbours() {
    for (int a = -1; a <= 1; a++) {
      for (int b = -1; b <= 1; b++) {
        int in = (this.i + a + N) % N;
        int jn = (this.j + b + N) % N;
        int kn = jn * N + in;
        this.neighbours.add(grid[kn]);
      }
    }
  }

  private void calculateScore() {
    int sum = 0;
    for (Patch p : this.neighbours) {
      if (p.isCooperating()) {
        sum++;
      }
    }
    if (this.coop) {
      this.score = sum;
    } else {
      this.score = alpha * sum;
    }
  }

  private void updateStrategy() {
    double highScore = this.score;
    boolean topStrategy = this.coop;
    for (Patch p : this.neighbours) {
      if (p.getScore() > highScore) {
        highScore = p.getScore();
        topStrategy = p.isCooperating();
      }
    }
    this.nextCoop = topStrategy;
  }

  void next() {
    this.prevCoop = this.coop;
    this.coop = this.nextCoop;
  }

  boolean isCooperating() {
    return this.coop;
  }

  double getScore() {
    return this.score;
  }
}
