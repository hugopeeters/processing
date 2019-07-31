class Stream {

  int n;
  ArrayList<Symbol> symbols;
  float speed;
  float x, y;
  int z, size;

  Stream(float x_) {
    x = x_;
    z = round(random(-2, 2));
    size = textSize + 2 * z;
    n = round(random(5, 20));
    speed = 7 - z / 2 + random(-2, 2);
    symbols = new ArrayList<Symbol>();
    generateSymbols();
  }

  void generateSymbols() {
    float y =  random(0, height);
    boolean first = random(1) < 0.3;
    for (int i = 0; i < n; i++) {
      Symbol symbol = new Symbol(x, y, speed, first);
      symbol.setRandomSymbol();
      symbols.add(symbol);
      y -= size;
      first = false;
    }
  }

  void render() {
    for (Symbol s : symbols) {
      int alpha = floor(map(z, -2, 2, 50, 150));
      if (s.first) {
        fill(200, 255, 200, alpha + 100);
      } else {
        fill(90, 255, 90, alpha);
      }
      text(s.value, s.x, s.y);
      s.rain();
      s.setRandomSymbol();
    }
  }
}
