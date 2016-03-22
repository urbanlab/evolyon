int nbPoly = 1;
ArrayList<Polygon> polygons = new ArrayList<Polygon>();


void setup() {
  size(500, 500);
  noFill();

  strokeWeight(3);
  strokeJoin(ROUND);
  strokeCap(ROUND);

  smooth();

  for (int i=0; i<nbPoly; i++) {
    stroke(#ff217c);
    polygons.add( new Polygon(width/2, height/2, 3, 50, -90, 1));

  }
}

void draw() {
  background(#241f38);

  for (int i=0; i<polygons.size(); i++) {
     Polygon poly = polygons.get(i);
    
    poly.move();
  }
}

class Polygon {

  int centreX;
  int centreY; 
  int trajectoireX;
  int trajectoireY;
  int nbCotes; 
  int rayon;
  float angle; 
  float amplitude;
  int delay;

  Polygon(int centreX_, int centreY_, int nbCotes_, int rayon_, float angle_, float amplitude_) {
    centreX = centreX_;
    centreY = centreY_; 
    nbCotes = nbCotes_; 
    rayon = rayon_;
    angle = angle_; 
    amplitude = amplitude_;
    
    delay = int(random(5,100));
  }
  
  void move() {

    if ( frameCount % delay  == 0 ) {
      trajectoireX = int(random (rayon, width-rayon));
      trajectoireY = int(random (rayon, height-rayon));
    }

    centreX  = ease(centreX, trajectoireX, 0.05 );
    centreY = ease(centreY, trajectoireY, 0.05 );

    draw();
  }
  
  int ease(int value, int target, float easingVal) {
    int d = target - value;
    if (abs(d)>1) value+= d*easingVal;
    return int(value);
  }


  void draw() {


    PVector[] pos = new PVector[nbCotes];

    // La forme s'inscrit dans un cerlce (radians : en degrès)
    for (int i=0; i<nbCotes; i++) {
      pos[i] = new PVector( cos(radians(angle + 360./nbCotes * i)) * rayon, sin(radians(angle + 360./nbCotes * i)) * rayon);
    }

    // Trouver les milieux des sommets
    PVector[] middles = new PVector[nbCotes];

    // Prendre le centre de tous les sommets (pos)
    for (int i=0; i<nbCotes; i++) {
      middles[i] = new PVector( (pos[ i ].x + pos[ (i+1) % nbCotes ].x ) / 2, (pos[ i ].y + pos[ (i+1) % nbCotes ].y ) / 2);
      middles[i].mult(amplitude);
    }

    // Dessiner à partir du premier point, et venir fermer la forme au point d'origine
    beginShape();
    for (int i=0; i<nbCotes; i++) {
      vertex(centreX+pos[i].x, centreY+pos[i].y);
      vertex(centreX+middles[i].x, centreY+middles[i].y);
    }

    endShape(CLOSE);
  }
}

void mousePressed() {
  
  Polygon poly = polygons.get(0);
  poly.rayon = 30; 
  
  for (int i=0; i<2; i++) {
    
    stroke(#ff217c);
    polygons.add( new Polygon(poly.centreX, poly.centreY, 3, 30, -90, 1 ));
  }
}

