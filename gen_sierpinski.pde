double pi = 3.141592653589793238462643383279502;

int n = 3; //number of sides to polygon

float fx = random(0, 600), fy = random(0, 600); //starting point coordinates
float cx = fx, cy = fy; //actual coordinates

int gen = 0; //generation number

float r = 0.5; //radius of one dot

void setup() {
  size(900, 900);
}

void draw() {
  float[][] points = drawPoly(n, 445, false); //draw a polygon, save points in array

  fill(255, 0, 0);
  noStroke();
  ellipse(fx, fy, (r*2), (r*2)); //make starting point
  dots(points); //run loop
}

//to make a polygon with n sides and a radius of r, text is a display option
public float[][] drawPoly(int n, float r, boolean text) {
  double a = (2*pi)/n;
  float[] pointx = new float[n];
  float[] pointy = new float[n];
  stroke(0);
  strokeWeight(3);
  point(width/2, height/2);

  for (int i =0; i < n; i++) {
    stroke(0, 0, 0);
    pointx[i] = r*cos((float)a*i) + (width/2);
    pointy[i] = r*sin((float)a*i) + (height/2);
    strokeWeight(5);
    point(pointx[i], pointy[i]);

    stroke(0);
    /*if (i>0) {
     line(pointx[i], pointy[i], pointx[i-1], pointy[i-1]);
     }*/
  }
  //line(pointx[0], pointy[0], pointx[n-1], pointy[n-1]);

  if (text == true) {
    fill(0);
    textSize(15);
    text("Number of sides: " + n + " | Length of radius: " + r, 10, 20);
  }
  float[][] ret = new float[2][n];
  for (int i = 0; i<pointx.length; i++) ret[0][i] = pointx[i];
  for (int i = 0; i<pointy.length; i++) ret[1][i] = pointy[i];
  return ret;
}

//loop for the dot generation
void dots(float[][] p) {
  fill(255, 255, 255);
  rect(0, 0, 400, 30);

  int value = (int)(Math.random()*n); //random value to choose which point to move toward

  fill(0);
  textSize(20);
  text("Dot # = " + (value + 1), 7, 20);
  text("Generation: " + gen, 200, 20);
  
  //moves point to halfway between itself and chosen vertex of polygon
  for (int i = 0; i<n; i++) {
    if (value == i) {
      cx = cx + ((p[0][i] - cx)/2);
      cy = cy + ((p[1][i] - cy)/2);
    }
    //draw the point
    noStroke();
    fill(255, 0, 0);
    ellipse(cx, cy, (r*2), (r*2));
  }
  gen++; //increment gen
}
