float angle;
ArrayList<Branch> tree;

void setup() {
  size(400, 400);
  angle = PI / 4;
  PVector a = new PVector(width / 2, height);
  PVector b = new PVector(width / 2, height - 100);
  Branch root = new Branch(a, b);
  tree = new ArrayList<Branch>();
  tree.add(root);
  

  
}

void mousePressed() {
  for (int i = tree.size(); i > 0; i--){
    if(!tree.get(i-1).finished){
      tree.add(tree.get(i-1).spawn(PI / 4));
      tree.add(tree.get(i-1).spawn(-PI / 4));
      tree.get(i-1).finished = true;
    }
  }
}

void draw() {
  angle = map(mouseY, 0, height, 0, PI);
  background(51);
  for (Branch branch : tree){
    branch.show();
  }

}

void branch(float len) {
  strokeWeight(len / 16);
  line(0, 0, 0, -len);
  translate(0,-len);
  if (len > 4){
    push();
    rotate(angle);
    branch(len*0.67);
    pop();
    push();
    rotate(-angle);
    branch(len*0.67);
    pop();
  }
  
}
