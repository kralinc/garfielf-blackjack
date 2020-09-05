//==== Button ====
class Button {
 private static final int BUTTON_LABEL_MARGIN = 5; //button labels have a 5px margin on either size
 public int x;
 public int y;
 public int w;
 public int h;
 color col;
 color hoverCol;
 color currentCol;
 public boolean active;
 String label;
 color textColor;
 PFont font;
 int textSize;
 
 //Button() {
 //  x = 0;
 //  y = 0;
 //  w = 0;
 //  h = 0;
 //  col = color(#ffffff);
 //  active = true;
 //  label = "";
 //  textColor = color(0);
 //  font = createFont("Source Code Pro Bold", 18);
 //}
 
 //Button(int x_, int y_, int w_, int h_) {
 // x = x_;
 // y = y_;
 // w = w_;
 // h = h_;
 // col = color(#ffffff);
 // active = true;
 // label = "";
 // textColor = color(0);
 // font = createFont("Source Code Pro Bold", 18);
 //}
 

 //Button(int x_, int y_, int w_, int h_, color c) {
 // x = x_;
 // y = y_;
 // w = w_;
 // h = h_;
 // col = c;
 // active = true;
 // label = "";
 // font = createFont("Source Code Pro Bold", 18);
 // //contrasting color
 // //double textCLinear = Math.pow(col >> 16 + col >> 8 + col & 0xFF, 2.2);
 // float alpha = 0.5 * ((col >> 16) * 2 - col >> 8 - col & 0xFF);
 // float beta = (sqrt(3)/2) * (col >> 8 - col & 0xFF);
 // float hue = atan2(alpha, beta);
 // if (hue >= 0 && hue < 60) {
 //  textColor = (#55ccff); //cyan
 // }else if (hue >= 60 && hue < 120) {
 //   textColor = (#0033cc); //blue
 // }else if (hue >= 120 && hue < 180) {
 //   textColor = (#ff00ff); //fuchsia
 // }else if (hue >= 180 && hue < 240) {
 //   textColor = (#ff0000); //red
 // }else if (hue >= 240 && hue < 300) {
 //  textColor =  (#ffff00); //yellow
 // }else {
 //   textColor = (#00ff00); //green
 // }
  
 //}
 
  Button(int x_, int y_, int w_, int h_, String l) {
  x = x_;
  y = y_;
  w = w_;
  h = h_;
  col = (255);
  hoverCol = (200);
  currentCol = col;
  active = true;
  label = l;
  textColor = (0);
  textSize = h;
  textSize(textSize);
  while (textWidth(label) > w * 0.9 - BUTTON_LABEL_MARGIN * 2) {
    textSize(textSize--); 
  }
  //font = createFont("Source Code Pro Bold", textSize);
 }
 
 //Button(int x_, int y_, int h_, String l) {
 // x = x_;
 // y = y_;
 // h = h_;
 // col = (255);
 // hoverCol = (200);
 // currentCol = col;
 // active = true;
 // label = l;
 // textColor = (0);
 // int textSize = (int)(h * 0.9);
 // w = (int)(textSize * l.length() * 0.66);
 // font = createFont("Source Code Pro Bold", textSize);
 //}

 
 public void draw() {
   if (active) {
     fill(currentCol);
     rect(x, y, w, h);
     fill(textColor);
     textFont(FONT, textSize);
     text(label, x + BUTTON_LABEL_MARGIN, y + h - (h / 4));
     
   }
 }
 
 public boolean hovering() {
   return (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h);
 }
 
 public void setPosition(int x, int y) {
  this.x = x;
  this.y = y;
 }
 
 public String getLabel() {
  return label; 
 }
 
 public void setTextColor(color txtclr) {
  textColor = txtclr; 
 }
 
 public color getTextColor() {
  return textColor; 
 }
 
}
