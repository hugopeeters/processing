class Scoresheet {

  Box[] boxes;
  int sub1, sub2, total;

  Scoresheet() {
    boxes = new Box[13];
    boxes[0] = new Box("Aces", "Sum of dice with number 1", 50, 150);
    boxes[1] = new Box("Twos", "Sum of dice with number 2", 50, 200);
    boxes[2] = new Box("Threes", "Sum of dice with number 3", 50, 250);
    boxes[3] = new Box("Fours", "Sum of dice with number 4", 50, 300);
    boxes[4] = new Box("Fives", "Sum of dice with number 5", 50, 350);
    boxes[5] = new Box("Sixes", "Sum of dice with number 6", 50, 400);

    boxes[6] = new Box("Three of a Kind", "At least three dice the same", 50, 500);
    boxes[7] = new Box("Four of a Kind", "At least four dice the same", 50, 550);
    boxes[8] = new Box("Full House", "Three the same and two the same", 50, 600);
    boxes[9] = new Box("Small Straight", "Four sequential dice", 50, 650);
    boxes[10] = new Box("Large Straight", "Five sequential dice", 50, 700);
    boxes[11] = new Box("Yahtzee", "All five dice the same", 50, 750);
    boxes[12]= new Box("Chance", "Any combination", 50, 800);
  }

  void render() {
    for (int i = 0; i < 13; i++) {
      boxes[i].render();
    }
    fill(255);
    textSize(24);
    text(sub1, 725, 475);
    text(sub2, 725, 875);
    textSize(48);
    text(total, 725, 100);
  }

  void updateScore() {
    // count the number of dice with each value
    int ones = 0;
    int twos = 0;
    int threes = 0;
    int fours = 0;
    int fives = 0;
    int sixes = 0;
    for (int i = 0; i < dicegroup.dice.length; i++) {
      Die d = dicegroup.dice[i];
      if (d.val == 1) {
        ones++;
      } else if (d.val == 2) {
        twos++;
      } else if (d.val == 3) {
        threes++;
      } else if (d.val == 4) {
        fours++;
      } else if ( d.val == 5) {
        fives++;
      } else if (d.val == 6) {
        sixes++;
      } else {
        println("unexpected result");
      }
      //determine the potential score for each box
      if (!score.boxes[0].set) {
        score.boxes[0].score = ones * 1;
      }
      if (!score.boxes[1].set) {
        score.boxes[1].score = twos * 2;
      }
      if (!score.boxes[2].set) {
        score.boxes[2].score = threes * 3;
      }
      if (!score.boxes[3].set) {
        score.boxes[3].score = fours * 4;
      }
      if (!score.boxes[4].set) {
        score.boxes[4].score = fives * 5;
      }
      if (!score.boxes[5].set) {
        score.boxes[5].score = sixes * 6;
      }
      if (!score.boxes[6].set) {
        //three of a kind
        if (ones >= 3 || twos >= 3 || threes >= 3 || fours >= 3 || fives >= 3 || sixes >= 3) {
          score.boxes[6].score = ones * 1 + twos * 2 + threes * 3 + fours * 4 + fives * 5 + sixes * 6;
        } else {
          score.boxes[6].score = 0;
        }
      }
      if (!score.boxes[7].set) {
        //four of a kind
        if (ones >= 4 || twos >= 4 || threes >= 4 || fours >= 4 || fives >= 4 || sixes >= 4) {
          score.boxes[7].score = ones * 1 + twos * 2 + threes * 3 + fours * 4 + fives * 5 + sixes * 6;
        } else {
          score.boxes[7].score = 0;
        }
      }
      if (!score.boxes[8].set) {
        //full house
        if ((ones == 0 || ones == 2 || ones == 3) && (twos == 0 || twos == 2 || twos == 3) && (threes == 0 || threes == 2 || threes == 3) && (fours == 0 || fours == 2 || fours == 3) && (fives == 0 || fives == 2 || fives == 3) && (sixes == 0 || sixes == 2 || sixes == 3)) {
          score.boxes[8].score = 25;
        } else {
          score.boxes[8].score = 0;
        }
      }
      if (!score.boxes[9].set) {
        //small straight
        if ((ones >= 1 && twos >= 1 && threes >= 1 && fours >= 1) || (twos >= 1 && threes >= 1 && fours >= 1 && fives >= 1) || (threes >= 1 && fours >= 1 && fives >= 1 && sixes >= 1)) {
          score.boxes[9].score = 30;
        } else {
          score.boxes[9].score = 0;
        }
      }
      if (!score.boxes[10].set) {
        //large straight
        if ((ones >= 1 && twos >= 1 && threes >= 1 && fours >= 1 && fives >= 1) || (twos >= 1 && threes >= 1 && fours >= 1 && fives >= 1 && sixes >= 1)) {
          score.boxes[10].score = 40;
        } else {
          score.boxes[10].score = 0;
        }
      }
      if (!score.boxes[11].set) {
        //yahtzee
        if (ones == 5 || twos == 5 || threes == 5 || fours == 5 || fives == 5 || sixes == 5) {
          score.boxes[11].score = 50;
        } else {
          score.boxes[11].score = 0;
        }
      }
      if (!score.boxes[12].set) {
        //chance
        score.boxes[12].score = ones * 1 + twos * 2 + threes * 3 + fours * 4 + fives * 5 + sixes * 6;
      }
    }
  }

  void totals() {
    sub1 = 0;
    for (int i = 0; i < 6; i++) {
      if (score.boxes[i].set) {
        sub1 += score.boxes[i].score;
      }
    }
    sub2 = 0;
    for (int i = 6; i < 13; i++) {
      if (score.boxes[i].set) {
        sub2 += score.boxes[i].score;
      }
    }
    total = sub1 + sub2;
  }
}
