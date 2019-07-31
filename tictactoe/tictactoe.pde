Grid g;
boolean Xturn = true;

void setup(){
  size(400, 400);
  g = new Grid();
}

void draw(){
  background(255);
  g.show();
}

void mouseClicked(){
  for (Square s : g.squares){
    if (mouseX > s.x - s.d / 2 && mouseX < s.x + s.d / 2 && mouseY > s.y - s.d / 2 && mouseY < s.y + s.d / 2){
      if (Xturn){
        s.t = 'X';
        Xturn = false;
      } else {
        s.t = 'O';
        Xturn = true;
      }
      break;
    }
  }
}
