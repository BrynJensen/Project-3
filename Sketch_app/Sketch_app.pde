//drawing app
//get clear background eraser

PImage eraser;

color red = #FF0000;
color orange = #FF8D00;
color yellow = #FFFF00;
color green = #00FF00;
color darkGreen = #018100;
color blue = #0000FF;
color lightBlue = #00FFFF;
color purple = #A500FF;
color white = #FFFFFF;
color black = #000000;
color gray = #747474;

color shade;

//track if mouse was released
boolean justReleased;

//track if mouse is dragging
boolean isDragging;

//track if mouse was pressed
boolean justPressed;

float sliderY;
color slide;

//indicator and line width
float wide;

//tell if mouse is over a button
boolean sliderHover;

//tell if drawing
boolean drawing;

void setup() {
  size(800, 600);
  background(255);
  sliderY = 50;
  eraser = loadImage("eraser.jpg");
} // end setup ====================================================

void draw() {
  println(mouseX, mouseY);

  //tool bar
  fill(200);
  noStroke();
  rect(0, 0, 800, 100);


  //colour selectors
  Cbutton(30, 33.33, 20, red);
  Cbutton(30, 66.66, 20, orange);
  Cbutton(60, 33.33, 20, yellow);
  Cbutton(60, 66.66, 20, green);
  Cbutton(90, 33.33, 20, blue);
  Cbutton(90, 66.66, 20, purple);
  Cbutton(120, 33.33, 20, darkGreen);
  Cbutton(120, 66.66, 20, lightBlue);
  Cbutton(150, 33.33, 20, white);
  Cbutton(150, 66.66, 20, black);

  slider(300);


  image(eraser, 225, 50, 500, 500);

// make cursor hand if hovering over a button and not hovering over canvas
  if (sliderHover == true) {
    cursor(HAND);
  } else if (drawing != true) {
    cursor(ARROW);
  }

//if cursor is over canvas, make mouse a cross
if (drawing == true) {
  cursor(CROSS);
  isDragging = false;
} else if (sliderHover != true) {
 cursor(ARROW); 
}

// if cursor is over canvas, set drawing boolean to true
  if (mouseY > 100) {
    drawing = true;
  } else {
    drawing = false;
  }

  justReleased = false;
  justPressed = false;
} // end draw =====================================================

void mousePressed() {
  justPressed = true;

  noStroke();
  fill(shade);

  if (mouseY > 100) {
    circle(mouseX, mouseY, wide);
  }


  if (mouseX < 315 && mouseX > 285) {
    isDragging = true;
  }
}

void mouseDragged() {

  fill(shade);
  stroke(shade);

  if (mouseY > 100) {
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}

void mouseReleased() {
  justReleased = true;
  isDragging = false;
} // end mouseReleased ============================================



void Cbutton(float x, float y, int d, int Colour) { //circle buttons
  fill(Colour);
  stroke(Colour);
  strokeWeight(2);

  Ctactile(x, y, d, Colour);

  circle(x, y, d);

  if (justReleased && dist(mouseX, mouseY, x, y) < d / 2) {
    shade = Colour;
    justReleased = false;
  }
  
} // end Cbutton ==================================================


void Sbutton(float X, float Y, int w, int h, int colour) { //square buttons
  strokeWeight(2.5);
  fill(colour);
  stroke(colour);


  Stactile(X, Y, w, h, colour);

  rect(X, Y, w, h);

  if (justReleased && mouseX > X && mouseX < X + w && mouseY > Y && mouseY < Y + h) {
    justReleased = false;
  }
} // end Sbutton ==================================================


void Ctactile(float xx, float yy, int D, int c) { // tactile for circles

  if (dist(mouseX, mouseY, xx, yy) < D / 2 && c != white) {
    stroke(white);
  } else {
    stroke(c);
  }

  if (c == white && dist(mouseX, mouseY, xx, yy) < D / 2) {
    stroke(black);
  }
} // end Ctactile =================================================


void Stactile(float XX, float YY, int W, int H, int C) { // tactile for squares

  if (mouseX > XX && mouseX < XX + W && mouseY > YY && mouseY < YY + H) {
    stroke(white);
  } else {
    stroke(C);
  }
} // end Stactile ==================================================


void slider(int x) {
  stroke(black);
  strokeWeight(3);

  //if slider is clicked on
  if (mouseX < x + 15 && mouseX > x - 15 && mouseY > 20 && mouseY < 80 && justPressed == true) {
    sliderY = mouseY;
  }

  //if slider is dragged
  if (isDragging == true && mouseY > 20 && mouseY < 80) {
    sliderY = mouseY;
  }


  line(x, 20, x, 80);

  strokeWeight(2);
  fill(200);
  stroke(slide);
  circle(x, sliderY, 12);

  //slider tactile
  if (isDragging == true || mouseX < x + 8 && mouseX > x - 8 && mouseY > 20 && mouseY < 80) {
    slide = white;
    sliderHover = true;
  } else {
    slide = black;
    sliderHover = false;
  }


  //indicator
  stroke(shade);
  fill(shade);
  wide = (map(sliderY, 20, 80, 1, 17));
  strokeWeight(wide);
  line(x + 30, 50, x + 100, 50);
}
