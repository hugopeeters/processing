PVector anchor;
Section s1;

void setup(){
  size(800, 800);
  anchor = new PVector(width / 2, 0);
  s1 = new Section(anchor, 400, PI/4);
}

void draw(){
  background(51);
  s1.render();
  s1.update();
}
