class Grid {
  float size = 250;
  ArrayList<Square> squares;
  Grid() {
    squares = new ArrayList<Square>();
    float d = size / 3;
    squares.add(new Square(width / 2 - d, height / 2 - d, d, ' '));
    squares.add(new Square(width / 2, height / 2 - d, d, ' '));
    squares.add(new Square(width / 2 + d, height / 2 - d, d, ' '));
    squares.add(new Square(width / 2 - d, height / 2, d, ' '));
    squares.add(new Square(width / 2, height / 2, d, ' '));
    squares.add(new Square(width / 2 + d, height / 2, d, ' '));
    squares.add(new Square(width / 2 - d, height / 2 + d, d, ' '));
    squares.add(new Square(width / 2, height / 2 + d, d, ' '));
    squares.add(new Square(width / 2 + d, height / 2 + d, d, ' '));
  }

  void show() {
    for (Square s : squares) {
      s.show();
    }
  }
}
