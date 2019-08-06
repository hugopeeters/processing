class Generation {

  ArrayList<Vehicle> vehicles;

  Generation() {
    //create vehicles
    vehicles = new ArrayList<Vehicle>();
  }

  void spawnGenZero() {
    for (int i = 0; i < numStarters; i++) {
      vehicles.add(new Vehicle(new PVector(random(field[0].x, field[1].x), random(field[0].y, field[1].y)), i));
    }
  }
}

void nextGen() {
  Generation lastGen = population.get(population.size() - 1);
  Collections.sort(lastGen.vehicles);
  //for ( Vehicle v : lastGen.vehicles) {
  //  println(v.performance);
  //}
  population.add(new Generation());
  Generation newGen = population.get(population.size() - 1);
  //the best half of the previous generation procreate
  for (int i = numStarters - 1; i >= (numStarters / 2); i--) {
    Vehicle parentV = lastGen.vehicles.get(i);
    //two children are born
    Vehicle childV1 = new Vehicle(new PVector(random(field[0].x, field[1].x), random(field[0].y, field[1].y)), parentV.brain.copy(), parentV.ancestor);
    newGen.vehicles.add(childV1);
    Vehicle childV2 = new Vehicle(new PVector(random(field[0].x, field[1].x), random(field[0].y, field[1].y)), parentV.brain.copy(), parentV.ancestor);
    newGen.vehicles.add(childV2);
  }
  println(newGen.vehicles.size());
}
