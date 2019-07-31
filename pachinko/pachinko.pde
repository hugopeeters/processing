float gravity = 0.025;
Ball ball;
ArrayList<Pin> pins;
float gridSize = 30;
PVector grid[];
int cols, rows;

void setup() {
  size(450, 800);
  ball = new Ball(width / 2 + random(-15, +15), 0);
  pins = new ArrayList<Pin>();
  cols = floor(width / gridSize);
  rows = floor(height / gridSize);
  grid = new PVector[cols * rows];
  
  for (int i = 2 * cols; i < cols * rows; i += 2){
    float x = gridSize / 2 + (i % cols) * gridSize;
    float y = floor(i / cols) * gridSize;
    pins.add(new Pin(x, y));
  }
  
  
  //for (int i = 0; i < 7; i++) {
  //  pins.add(new Pin(40 * i + 100, 200));
  //}

}

void draw() {
  background(51);
  for (int i = 0; i < pins.size(); i++) {
    pins.get(i).show();
  }
  ball.update();
  ball.show();
}
