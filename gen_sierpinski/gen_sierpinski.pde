/*
OPTIMAL C-VALUE FOR SIM MODES 0 AND 1:
 simMode 1:
 3-3.14
 4-2.125
 5-1.8
 6-1.65
 7-1.54
 
 simMode 0:
 3-2
 4-1.75
 5-1.65
 6-1.55
 7-1.45
 8-
 */

final double pi = 3.141592653589793238462643383279502; //thats pi duh

final int n = 3; //number of sides to polygon

final float c = 2; //constant for scaling of fractal

final int numGens = 1000000; //number of generations to be executed at once

final int simMode = 3; //chosen mode for random number picker (see chooseRandom method below)

final boolean col = true; //whether color is shown or not (can only work for up to 9 vertices)

final boolean pretty = true; //when true, hides counter box in top left and polygon points: makes it look good

final int size = (1080/2); //size of polygon

float fx = random(0, 600), fy = random(0, 600); //starting point coordinates
float cx = fx, cy = fy; //actual coordinates

int gen = 0; //generation number

final float r = 0.1  ; //radius of one dot
int value = (int)(Math.random()*n), current, before;

void setup() {
  fullScreen();
  background(0);
  float[][] points = drawPoly(n, size, false); //draw a polygon, save points in array

  fill(255, 0, 0);
  noStroke();
  ellipse(fx, fy, (r*2), (r*2)); //make starting point

  for (int i = 0; i < numGens; i++)
    dots(points); //run loop
}

void draw() {
  if (keyPressed && key == 's') save("./images/N"+n+"-C"+c+"-SIM"+simMode+"-H"+size+".jpg");
}

//to make a polygon with n sides and a radius of r, text is a display option
public float[][] drawPoly(int n, float r, boolean text) {
  double a = (2*pi)/n;
  float[] pointx = new float[n];
  float[] pointy = new float[n];
  stroke(255, 255, 0);
  strokeWeight(3);
  if (!pretty)
    point(width/2, height/2);

  for (int i =0; i < n; i++) {
    if (!col) stroke(255, 255, 0);
    else colorSelector(i);
    pointx[i] = r*cos((float)a*i) + (width/2);
    pointy[i] = r*sin((float)a*i) + (height/2);
    if (col) strokeWeight(10);
    else strokeWeight(5);
    if (!pretty)
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
  if (!pretty) {
    fill(255, 255, 255);
    rect(0, 0, 400, 30);
  }

  chooseRandom(simMode);
  if (!pretty) {
    fill(0);
    textSize(20);
    text("Dot # = " + (value + 1), 7, 20);
    text("Generation: " + gen, 200, 20);
  }

  //moves point to halfway between itself and chosen vertex of polygon
  for (int i = 0; i<n; i++) {
    if (value == i) {
      cx = cx + ((p[0][i] - cx)/c);
      cy = cy + ((p[1][i] - cy)/c);
    }
    //draw the point
    noStroke();
    if (!col) fill(255, 255, 255);
    else colorSelectorFill(value);
    ellipse(cx, cy, (r*2), (r*2));
  }
  gen++; //increment gen
}

void chooseRandom(int mode) {
  if (mode == 0) value = (int)(Math.random()*n);
  else if (mode == 1) {
    current = value;
    value = (int)(Math.random()*n); //random value to choose which point to move toward
    while (value==current) {
      value = (int)(Math.random()*n);
    }
  } else if (mode == 2) {
    current = value;
    value = (int)(Math.random()*n);
    while (value%n == current-1) value = (int)(Math.random()*n);
  } else if (mode == 3) {
    current = value;
    value = (int)(Math.random()*n);
    while (value-1 == current%n) value = (int)(Math.random()*n);
  } else if (mode == 4) {
    current = value;
    value = (int)(Math.random()*n);
    while (abs(value%n - current%n) != 1) value = (int)(Math.random()*n);
  } else if (mode == 5) {
    before = current;
    current = value;
    value = (int)(Math.random()*n);
    while (value == current || value == before) value = (int)(Math.random()*n);
  }
}

void colorSelector(int i) {
  if (i == 0) stroke(255, 255, 255);
  else if (i==1) stroke(255, 0, 0);
  else if (i==2) stroke(#FF9900);
  else if (i==3) stroke(#F6FF00);
  else if (i==4) stroke(#02D60A);
  else if (i==5) stroke(0, 255, 255);
  else if (i==6) stroke(0, 0, 255);
  else if (i==7) stroke(#9503FF);
  else if (i==8) stroke(#FF03FB);
}
void colorSelectorFill(int i) {
  if (i == 0) fill(255, 255, 255);
  else if (i==1) fill(255, 0, 0);
  else if (i==2) fill(#FF9900);
  else if (i==3) fill(#F6FF00);
  else if (i==4) fill(#02D60A);
  else if (i==5) fill(0, 255, 255);
  else if (i==6) fill(0, 0, 255);
  else if (i==7) fill(#9503FF);
  else if (i==8) fill(#FF03FB);
}
