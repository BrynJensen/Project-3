//drawing app
//add background to button background invis unless tactile

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

color shade;
boolean justReleased;

void setup() {
  size(800, 600);
  background(255);
} // end setup ====================================================

void draw() {
  //tool bar
  fill(200);
  noStroke();
  rect(0, 0, 800, 100);

  //indicator
  stroke(shade);
  //  strokeWeight(slider thickness);
  //  line(

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
} // end draw =====================================================


void mouseReleased() {
  justReleased = true;
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
  }
} // end Sbutton ==================================================


void Ctactile(float xx, float yy, int D, int c) { // tactile for circles
  if (dist(mouseX, mouseY, xx, yy) < D / 2 && c != white && c != yellow) {
    stroke(white);
  } else {
    stroke(c);
  }
  
  if(c == yellow && dist(mouseX, mouseY, xx, yy) < D / 2|| c == white && dist(mouseX, mouseY, xx, yy) < D / 2){
   stroke(black);
  }
} // end Ctactile =================================================


void Stactile(float XX, float YY, int W, int H, int C) { // tactile for squares
  if (mouseX > XX && mouseX < XX + W && mouseY > YY && mouseY < YY + H) {
    stroke(white);
  } else {
    stroke(C);
  }
} // end Stactile =================================================
