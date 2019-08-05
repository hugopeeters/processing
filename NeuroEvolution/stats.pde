//void calculateStats() {

//  //ages
//  for (int i = 0; i < maxAge; i++) {
//    ages[i] = 0;
//  }
//  for (int i = 0; i < vehicles.size(); i++) {
//    int age;
//    if (vehicles.get(i).age < maxAge - 1) {
//      age = vehicles.get(i).age;
//    } else { 
//      age = maxAge - 1;
//    }
//    ages[age] += 1;
//  }

//  //generations
//  for (int i = 0; i < maxGens; i++) {
//    generations[i] = 0;
//  }
//  for (int i = 0; i < vehicles.size(); i++) {
//    int gen;
//    if (vehicles.get(i).generation < maxGens - 1) {
//      gen = vehicles.get(i).generation;
//    } else { 
//      gen = maxGens - 1;
//    }
//    generations[gen] += 1;
//  }

//  //ancestors
//  int[] ancestors = new int[numStarters];
//  for (int i = 0; i < numStarters; i++) {
//    ancestors[i] = 0;
//  }
//  for (int i = 0; i < vehicles.size(); i++) {
//    int anc;
//    if (vehicles.get(i).ancestor < numStarters - 1) {
//      anc = vehicles.get(i).ancestor;
//    } else { 
//      anc = numStarters - 1;
//    }
//    ancestors[anc] += 1;
//  }
//  ancestorSeries.add(ancestors);

//  //determine the best performer
//  float highestPerformance = 0;
//  Vehicle best = null;
//  for (Vehicle v : vehicles) {
//    if (v.performance > highestPerformance) {
//      highestPerformance = v.performance;
//      best = v;
//    }
//  }
//  if (best != null) {
//    best.best = true;
//  }
//}
