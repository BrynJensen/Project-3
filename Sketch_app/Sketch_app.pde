//drawing app
//ask about line that appears if i double clock on the file i want to load, draws over task bar even

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

//colour for button backgrounds
//eraser
color ebg = 200;
//grass
color gbg = 200;
//sun
color sbg = 200;


//booleans to track stamp
boolean grassOn = false;
boolean sunOn = false;


//store where mouse was right clicked
int startX;
int startY;
int endX;
int endY;

void setup() {
  surface.setTitle("Sketchy");
  imageMode(CENTER);

  PImage icon = loadImage("sun.png");
  size(800, 600);
  background(255);
  sliderY = 50;
  eraser = loadImage("eraser.png");
  grass = loadImage("grass.png");
  sun = loadImage("sun.png");
} // end setup ====================================================

void draw() {

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

  //slider
  slider(300);

  //stamp buttons
  grassButton(450, 25);
  sunButton(550, 25);

  //new button
  eraserButton(200, 25, 50, 50);

  //cursor changer
  cursorBehaviour();

  //reset booleans tracking mouse pressed or released at end of every frame
  justReleased = false;
  justPressed = false;


  //save button
  Sbutton(725, 25, 50, 20, gray);
  fill(white);
  textAlign(CENTER);
  text("save", 750, 39);


  //load button
  Sbutton(725, 55, 50, 20, gray);
  fill(white);
  textAlign(CENTER);
  text("load", 750, 69);
} // end draw =====================================================

void mousePressed() {
  if (mouseButton == LEFT) {
    justPressed = true;


    //draw dot if mouse is on canvas and pressed once
    noStroke();
    fill(shade);

    if (mouseY > 100 && grassOn != true && sunOn != true) {
      circle(mouseX, mouseY, wide);
    }

    //track if mouse is dragging for slider
    if (mouseX < 315 && mouseX > 285 && mouseY > 20 && mouseY < 80) {
      isDragging = true;
    }
  } else if (mouseButton == RIGHT) {
    //track where mouse was right clicked for straight line
    startX = mouseX;
    startY = mouseY;
  }
} // end mouse pressed ==========================================

void mouseDragged() {
  
  //draw line if mouse is held over canvas and neither stamp is turned on
  fill(shade);
  stroke(shade);
  strokeWeight(wide);

  if (mouseY > 100 && pmouseY >100 && grassOn == false && sunOn == false && mouseButton == LEFT) {
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
} // end mousedragged ========================================

void mouseReleased() {
  //track is mouse is released and also reset dragging variables
  justReleased = true;
  isDragging = false;
  pictureDragging = false;

//track where mouse was released for straight line
  endX = mouseX;
  endY = mouseY;

  //save button pressed
  if (mouseX > 725 && mouseX < 775 && mouseY > 25 && mouseY < 45) {
    selectOutput("Choose a name for your new image", "saveImage");
  }

  //load button pressed
  if (mouseX > 725 && mouseX < 775 && mouseY > 55 && mouseY < 75) {
    selectInput("Select an image to load", "openImage");
  }

  //draw straight line if right click
  if (mouseButton == RIGHT && startY > 100 && endY > 100) {
    stroke(shade);
    strokeWeight(wide);
    line(startX, startY, endX, endY);
  }
} // end mouseReleased ============================================



void Cbutton(float x, float y, int d, int Colour) { //circle colour buttons
  fill(Colour);
  stroke(Colour);
  strokeWeight(2);

  Ctactile(x, y, d, Colour);

  circle(x, y, d);

//if button is pressed, set indicator to colour, turn of stamps, and reset stamps background
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

//line slider follows
  line(x, 20, x, 80);

//circle of slider
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

//set sliderhover to true if mouse is hovering over button or dragging for cursor change
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
} // end slider ===================================================

void eraserButton (int x, int y, int w, int h) {
  fill(ebg);
  noStroke();
  rect(x, y, w, h);
  image(eraser, x + 25, y + 25, w, h);

//if eraser hovered, make button tactile
  if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
    ebg = 185;
  } else {
    ebg = 200;
  }

//if button is pressed, reset canvas to white
  if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h && justReleased == true) {
    fill(white);
    rect(0, 100, 800, 600);
  }
} // end eraser ======================================================

void grassButton (int x, int y) {
  fill(gbg);
  noStroke();
  rect(x - 12.5, y - 12.5, 75, 75);
  image(grass, x + 25, y + 17, 75, 75);

//if grass is clicked, track that it was and make switch show its on
  if (mouseX > x - 12.5 && mouseX < x + 62.5 && mouseY > y - 12.5 && mouseY < y + 62.5 && justReleased == true && grassOn == false) {
    grassOn = true;
    sunOn = false;
    sbg = 200;
    gbg = 185;
  } else if (grassOn == true && mouseX > x - 12.5 && mouseX < x + 62.5 && mouseY > y - 12.5 && mouseY < y + 62.5 && justReleased == true) {
    grassOn = false;
    gbg = 200;
  }

//if grass switch is on, when pressed or dragged draw grass not line
  if (grassOn == true && pictureDragging == true || justPressed == true && grassOn == true && pictureDragging == true) {
    image(grass, mouseX, mouseY, map(sliderY, 20, 80, 20, 150), map(sliderY, 20, 80, 20, 150));
  }

  if (mouseY > 100 && grassOn == true && justPressed == true || mouseY > 100 && sunOn == true && justPressed == true) {
    pictureDragging = true;
  }
} // end grass ============================================================


void sunButton (int x, int y) {
  fill(sbg);
  noStroke();
  rect(x - 12.5, y - 12.5, 75, 75);
  image(sun, x + 25, y + 25, 75, 75);

//if sun button is pressed, track that it was and make tactile
  if (mouseX > x - 12.5 && mouseX < x + 62.5 && mouseY > y - 12.5 && mouseY < y + 62.5 && justReleased == true && sunOn == false) {
    sunOn = true;
    grassOn = false;
    sbg = 185;
    gbg = 200;
  } else if (sunOn == true && mouseX > x - 12.5 && mouseX < x + 62.5 && mouseY > y - 12.5 && mouseY < y + 62.5 && justReleased == true) {
    sunOn = false;
    sbg = 200;
  }

//if sun is on, when clicked or dragged draw sun and not line or grass
  if (sunOn == true && pictureDragging == true || justPressed == true && sunOn == true && pictureDragging == true) {
    image(sun, mouseX, mouseY, map(sliderY, 20, 80, 20, 150), map(sliderY, 20, 80, 20, 150));
  }
} // end sun =============================================================

void cursorBehaviour () {
  // make cursor hand if hovering over slider and not hovering over canvas
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
} // end cursor =====================================================

void saveImage(File f) {
  if (f != null ) {
    PImage canvas = get(0, 100, width, height);
    canvas.save(f.getAbsolutePath());
  }
} // end save ======================================================

void openImage(File f) {
  if (f != null) {
    int n = 0;
    while (n < 10) {
      PImage pic = loadImage(f.getPath());
      image(pic, 400, 400);
      n = n + 1;
    }
  }
} // end open =======================================================
