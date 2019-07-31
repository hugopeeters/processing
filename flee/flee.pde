ArrayList<Vehicle> flock;
int n = 500;

void setup(){
  size(800, 800);
  flock = new ArrayList<Vehicle>();
  for (int i = 0; i < n; i++){
    flock.add(new Vehicle(random(width), random(height)));
  }
}

void draw(){
  background(51);
  for (Vehicle v : flock){
    v.update();
    v.show();
  }
}
