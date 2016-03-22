Cell[] polygonArray = new Cell[1];

void setup() {
  size(500, 500);
  noFill();

  stroke(#a184b7);
  strokeWeight(2);
  strokeJoin(ROUND);
  strokeCap(ROUND);

  smooth();

  for (int i=0; i<polygonArray.length; i++) {
    polygonArray[i] = new Cell(width/2, height/2, 3, 50, -90, sin(frameCount/40.)*0.2+1);
  }
}

void draw() {
  background(0);

  for (int i=0; i<polygonArray.length; i++) {
    polygonArray[i].move();
  }
}


void mousePressed() {
}