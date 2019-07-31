class DNA {

  PVector[] genes;

  DNA() {
    genes = new PVector[lifespan];
    for (int i = 0; i < genes.length; i++) {
      genes[i] = PVector.random2D();
    }
  }

  DNA combine(DNA partner) {
    DNA newdna = new DNA();
    int mid = floor(random(0, lifespan));
    for (int i = 0; i < genes.length; i++) {
      if (i < mid) {
        newdna.genes[i] = genes[i];
      } else {
        newdna.genes[i] = partner.genes[i];
      }
    }
    //mutation
    for (int i = 0; i < genes.length; i++) {
      if (random(1) < 0.05) {
        numMut++;
        newdna.genes[i] = PVector.random2D();
      }
    }
    return newdna;
  }
}
