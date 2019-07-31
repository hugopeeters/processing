Dicegroup dicegroup;
Scoresheet score;
int phase;

//phase 0 start of the turn, roll all dice
//phase 1 select dice to hold and roll others, or skip to phase 3
//phase 2 select dice to hold and roll others, or skip to phase 3
//phase 3 select which box to score

void setup() {
  size(800, 900);
  dicegroup = new Dicegroup();
  score = new Scoresheet();
  phase = 0;
}

void draw() {
  background(0, 120, 40);
  dicegroup.render();
  score.render();
  textAlign(LEFT);
  textSize(16);
  fill(255);
  switch(phase){
    case 0 : 
      text("Roll 1: Press any key to roll the dice", 50, 30);
      break;
    case 1 :
      text("Roll 2: Click dice to hold and press a key to roll, or write down your score", 50, 30);
      break;
    case 2 :
      text("Roll 3: Click dice to hold and press a key to roll, or write down your score", 50, 30);
      break;
    case 3 :
      text("End of turn: Write down your score", 50, 30);
      break;
  }
}

void keyPressed() {
  if (phase < 3) {
    dicegroup.roll();
    phase++;
  }
  if (phase > 3) { 
    phase = 0;
  }
}

void mouseClicked() {
  if (phase == 1 || phase == 2) {
    //select dice to hold in phase 1 and 2
    for (int i = 0; i < dicegroup.dice.length; i++) {
      Die d = dicegroup.dice[i];
      if (mouseX >= d.pos.x && mouseX <= d.pos.x + d.sz && mouseY >= d.pos.y && mouseY <= d.pos.y + d.sz) {
        d.held = !d.held;
      }
    }
  }
  if (phase == 1 || phase == 2 || phase == 3){
    //write down a score and end the round
    for (int i = 0; i < 13; i++){
      Box b = score.boxes[i];
      if(!b.set && mouseX >= b.pos.x && mouseX <= b.pos.x + b.w * 2 + b.w2 && mouseY > b.pos.y && mouseY < b.pos.y + b.h){
        b.set = true;
        score.totals();
        dicegroup.reset();
        phase = 0;
      }
    }
  }
}
