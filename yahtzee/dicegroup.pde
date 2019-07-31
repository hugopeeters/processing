class Dicegroup {

  Die[] dice;

  Dicegroup() {
    dice = new Die[5];
    float offset = 0;
    for (int i = 0; i < dice.length; i++) {
      dice[i] = new Die(50+offset, 50, round(random(1, 6)));
      offset += 75;
    }
  }

  void render() {
    for (int i = 0; i < dice.length; i++) {
      dice[i].render();
    }
  }

  void roll() {
    for (int i = 0; i < dice.length; i++) {
      if (dice[i].held == false) {
        dice[i].roll();
      }
    }
    score.updateScore();
  }
  
  void reset(){
    for (int i = 0; i < dice.length; i++) {
      dice[i].held = false;
    }
  }
}
