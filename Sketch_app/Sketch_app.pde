//drawing app

PImage eraser;
PImage grass;
PImage sun;

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
boolean pictureDragging;

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

//toolbar colour for button backgrounds
color BG = 200;
//grass
color gbg = 200;
//sun
color sbg = 200;


//booleans to track stamp
boolean grassOn = false;
boolean sunOn = false;

void setup() {
  surface.setTitle("Sketchy");
  imageMode(CENTER);

  PImage icon = loadImage("grass.png");
  size(800, 600);
  background(255);
  sliderY = 50;
  eraser = loadImage("eraser.png");
  grass = loadImage("grass.png");
  sun = loadImage("sun.png");
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

  eraserButton(200, 25, 50, 50);
  grassButton(450, 25);
  sunButton(550, 25);

  cursorBehaviour();

  justReleased = false;
  justPressed = false;
} // end draw =====================================================

void mousePressed() {
  justPressed = true;

  noStroke();
  fill(shade);

  if (mouseY > 100 && grassOn != true && sunOn != true) {
    circle(mouseX, mouseY, wide);
  }


  if (mouseX < 315 && mouseX > 285 && mouseY > 20 && mouseY < 80) {
    isDragging = true;
  }
}

void mouseDragged() {

  fill(shade);
  stroke(shade);

  if (mouseY > 100 && grassOn == false && sunOn == false) {
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}

void mouseReleased() {
  justReleased = true;
  isDragging = false;
  pictureDragging = false;
} // end mouseReleased ============================================



void Cbutton(float x, float y, int d, int Colour) { //circle buttons
  fill(Colour);
  stroke(Colour);
  strokeWeight(2);

  Ctactile(x, y, d, Colour);

  circle(x, y, d);

  if (justReleased && dist(mouseX, mouseY, x, y) < d / 2) {
    shade = Colour;
    sunOn = false;
    grassOn = false;
    gbg = 200;
    sbg = 200;
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
  } else {
    slide = black;
  }

  if (isDragging == true || dist(mouseX, mouseY, x, sliderY) < 6) {
    sliderHover = true;
  } else {
    sliderHover = false;
  }



  //indicator
  stroke(shade);
  fill(shade);
  wide = (map(sliderY, 20, 80, 1, 30));
  strokeWeight(wide);
  line(x + 30, 50, x + 100, 50);
}

void eraserButton (int x, int y, int w, int h) {
  fill(BG);
  noStroke();
  rect(x, y, w, h);
  image(eraser, x + 25, y + 25, w, h);


  if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
    BG = 185;
  } else {
    BG = 200;
  }

  if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h && justReleased == true) {
    fill(white);
    rect(0, 100, 800, 600);
  }
}

void grassButton (int x, int y) {
  fill(gbg);
  noStroke();
  rect(x, y, 50, 50);
  image(grass, x + 25, y + 25, 50, 50);

  if (mouseX > x && mouseX < x + 50 && mouseY > y && mouseY < y + 50 && justReleased == true && grassOn == false) {
    grassOn = true;
    sunOn = false;
    sbg = 200;
    gbg = 185;
  } else if (grassOn == true && mouseX > x && mouseX < x + 50 && mouseY > y && mouseY < y + 50 && justReleased == true) {
    grassOn = false;
    gbg = 200;
  }

  if (grassOn == true && pictureDragging == true || justPressed == true && grassOn == true && pictureDragging == true) {
    image(grass, mouseX, mouseY, map(sliderY, 20, 80, 20, 150), map(sliderY, 20, 80, 20, 150));
  }

  if (mouseY > 100 && grassOn == true && justPressed == true || mouseY > 100 && sunOn == true && justPressed == true) {
    pictureDragging = true;
  }
}


void sunButton (int x, int y) {
  fill(sbg);
  noStroke();
  rect(x, y, 50, 50);
  image(sun, x + 25, y + 25, 50, 50);

  if (mouseX > x && mouseX < x + 50 && mouseY > y && mouseY < y + 50 && justReleased == true && sunOn == false) {
    sunOn = true;
    grassOn = false;
    sbg = 185;
    gbg = 200;
  } else if (sunOn == true && mouseX > x && mouseX < x + 50 && mouseY > y && mouseY < y + 50 && justReleased == true) {
    sunOn = false;
    sbg = 200;
  }

  if (sunOn == true && pictureDragging == true || justPressed == true && sunOn == true && pictureDragging == true) {
    image(sun, mouseX, mouseY, map(sliderY, 20, 80, 20, 150), map(sliderY, 20, 80, 20, 150));
  }
}

void cursorBehaviour () {
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
}
