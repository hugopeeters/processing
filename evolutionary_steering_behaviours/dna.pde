class DNA {

  float goodVel;
  float badVel;
  float otherVel;
  float otherHealth;
  float goodRange;
  float badRange;
  float otherRange;
  float maxRange = 200;
  float minRange = -maxRange;

  DNA() {
    goodVel = random(-2, 2);
    badVel = random(-2, 2);
    otherVel = random(-2, 2);
    otherHealth = random(-100, 100);
    goodRange = random(10, 200);
    badRange = random(10, 200);
    otherRange = random(10, 200);
  }

  DNA copy(){
    DNA copiedDNA = new DNA();
    copiedDNA.goodVel = goodVel;
    copiedDNA.badVel = badVel;
    copiedDNA.otherVel = otherVel;
    copiedDNA.goodRange = goodRange;
    copiedDNA.badRange = badRange;
    copiedDNA.otherRange = otherRange;
    return copiedDNA;
  }

  void mutate() {
    int x = floor(random(6));
    switch(x) {
    case 0:
      goodVel += random(-0.1, 0.1);
      if (goodVel >= 2) {
        goodVel = 2;
      } else if (goodVel < -2) {
        goodVel = -2;
      }
      break;
    case 1:
      badVel += random(-0.1, 0.1);
      if (badVel >= 2) {
        badVel = 2;
      } else if (badVel < -2) {
        badVel = -2;
      }
      break;
    case 2:
      otherVel += random(-0.1, 0.1);
      if (otherVel >= 2) {
        otherVel = 2;
      } else if (otherVel < -2) {
        otherVel = -2;
      }
      break;
    case 3:
      otherHealth += random(-5, 5);
      if (otherHealth >= 100) {
        otherHealth = 100;
      } else if (otherHealth < -100) {
        otherHealth = -100;
      }
      break;
    case 4:
      goodRange += random(-10, 10);
      if (goodRange >= maxRange) {
        goodRange = maxRange;
      } else if (goodRange < minRange) {
        goodRange = minRange;
      }
      break;
    case 5:
      badRange += random(-10, 10);
      if (badRange >= maxRange) {
        badRange = maxRange;
      } else if (badRange < minRange) {
        badRange = minRange;
      }
      break;
    case 6:
      otherRange += random(-10, 10);
      if (otherRange >= maxRange) {
        otherRange = maxRange;
      } else if (otherRange < minRange) {
        otherRange = minRange;
      }
      break;
    }
  }
}
