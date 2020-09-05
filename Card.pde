class Card {
  
  private static final float SUIT_IMAGE_WIDTH = 0.2; //the percentage of the card's width that the suit image should be.
  private static final float SUIT_IMAGE_OFFSET = 0.1; //how  much of the card's width to offset the suit image's position by.
  private static final float ASPECT_RATIO = 1.5; //height will be width times this number.
  
 int suit; //0 = spades, 1 = clubs, 2 = hearts, 3 = diamonds
 SuitValue value;
 PImage suitImage;
 PImage suitImageOriginal; //this is the full size image that never gets resized
 PImage cardImage;
 color suitColor;
 
 //position/dimensions
 int x, y, w, h;
 
 Card(int suit, int value) {
   this.suit = suit;
   this.value = new SuitValue();
   
   switch (suit) {
    case 0:
      suitImageOriginal = spadesImage.copy();
      suitColor = #000000;
      break;
    case 1:
      suitImageOriginal = clubsImage.copy();
      suitColor = #000000;
      break;
    case 2:
      suitImageOriginal = heartsImage.copy();
      suitColor = #ff0000;
      break;
    default:
      suitImageOriginal = diamondsImage.copy();
      suitColor = #ff0000;
      break;
   }
   
   switch(value) {
    case(1):
      this.value.numericalValue = 1;
      this.value.faceValue = 'A';
      break;
    case (10):
      this.value.numericalValue = 10;
      this.value.faceValue = 'X';
      break;
    case (11):
      this.value.numericalValue = 10;
      this.value.faceValue = 'J';
      break;
    case (12):
      this.value.numericalValue = 10;
      this.value.faceValue = 'Q';
      break;
    case (13):
      this.value.numericalValue = 10;
      this.value.faceValue = 'K';
      break;
    default:
      this.value.numericalValue = value;
      this.value.faceValue = Character.forDigit(value, 10);
      break;
   }
   
   resize(10); //initialize the size with something that won't make the text size 0.
   
 }
 
 void draw(int x_, int y_) {
   noStroke();
   fill(#ffffff);
   rect(x_, y_, w, h);
   
   //suitImage.resize((int)(w * 0.2), (int)(w * 0.2));
   
   image (suitImage, x_ + w * SUIT_IMAGE_OFFSET, y_ + w * SUIT_IMAGE_OFFSET);
   image (suitImage, x_ + w - (w * (SUIT_IMAGE_WIDTH + SUIT_IMAGE_OFFSET)), y_ + h - (w * (SUIT_IMAGE_WIDTH + SUIT_IMAGE_OFFSET)));
   
   fill(suitColor);
   textSize(w * 0.5);
   text(value.faceValue, x_ + w / 3, y_ + h / 2);
   
 }
 
 void resize (float w) {
  suitImage = suitImageOriginal.copy();
  h = (int)(w * ASPECT_RATIO);
  suitImage.resize((int)(w * SUIT_IMAGE_WIDTH), (int)(w * SUIT_IMAGE_WIDTH));
  this.w = (int)w;
 }
 
 int getNumValue() {
  return value.numericalValue; 
 }
 
 char getFaceValue() {
  return value.faceValue; 
 }
 
}

//struct to hold some card values
class SuitValue {
  public int numericalValue;
  public char faceValue;
}
