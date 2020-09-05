//Purpose: To consolidate all of the methods that draw to the screen and allow for easier project management and fewer copy-pastes

//TODO: Pretty up this entire ugly mess
class DrawMaster {
  
  private static final  int VW = WIDTH / 100; //A unit of measurement set as 1% of the screen's width
  
  private static final  int DRAW_PLAYER_HAND_X_START          = VW * 5;
  private static final  int DRAW_PLAYER_HAND_Y_START          = VW * 75;
  private static final  int STANDARD_CARD_SEPARATION          = VW;
  
  private static final  int DRAW_CPU_HAND_X_START             = VW * 5;
  private static final  int DRAW_CPU_HAND_Y_START             = VW * 50;
  private static final  color CPU_HAND_HIDDEN_CARD_COLOR      = #007000;
  private static final  int DRAW_CPU_SPRITE_X_START           = VW * 20;
  private static final  int DRAW_CPU_SPRITE_Y_START           = VW * 10;
  
  private static final  int GUI_RECT_WIDTH                    = VW * 25;
  private static final  int DRAW_CPU_MESSAGE_X_START          = 0;
  private static final  int DRAW_CPU_MESSAGE_Y_START          = 0;
  private static final  int DRAW_CPU_MESSAGE_RECT_WIDTH       = WIDTH - GUI_RECT_WIDTH;
  private static final  int DRAW_CPU_MESSAGE_RECT_HEIGHT      = VW * 7;
  private static final  int DRAW_CPU_MESSAGE_TEXT_OFFSET      = DRAW_CPU_MESSAGE_X_START + DRAW_CPU_MESSAGE_RECT_WIDTH / 50;
  private static final  int DRAW_CPU_MESSAGE_TEXT_OFFSET_Y    = DRAW_CPU_MESSAGE_Y_START + DRAW_CPU_MESSAGE_RECT_HEIGHT / 10;
  
  private static final int DRAW_WIN_TEXT_X_START              = DRAW_PLAYER_HAND_X_START;
  private static final int DRAW_WIN_TEXT_Y_START              = DRAW_PLAYER_HAND_Y_START - DRAW_CPU_SPRITE_Y_START;
  private static final int DRAW_WIN_TEXT_WIDTH                = VW * 60;
  private static final int DRAW_WIN_TEXT_HEIGHT               = VW * 20;
  
  private String WIN_TEXT = "";
  private int WIN_TEXT_SIZE = DRAW_WIN_TEXT_HEIGHT;
  public boolean winTextSet = false;
  public boolean loseTextSet = false;
  
  
  private static final  int BUTTON_WIDTH                      = VW * 13;
  private static final  int BUTTON_HEIGHT                     = VW * 5;
  private static final  color BACKGROUND_COLOR                = #0A950A;
  private static final  color IS_DOUBLE_COLOR                 = #ff0000;
  
  
  
  GameManager gm;
  PImage cpuSpriteLocal;
  
  DrawMaster(GameManager g) {
   gm = g;
  }
  
  
  void drawMainLayout(ComputerPlayer cpu) 
  {
    background(BACKGROUND_COLOR);
    fill(0);
    rect(width - GUI_RECT_WIDTH, 0, width, height);
    image(cpu.sprite, DRAW_CPU_SPRITE_X_START, DRAW_CPU_SPRITE_Y_START);
  }
  
  void setupButtons(ArrayList<Button> buttons) 
  {
    buttons.clear();
        
    buttons.add(new Button(
                WIDTH - (GUI_RECT_WIDTH - (VW * 5)),
                WIDTH - VW * 35,
                BUTTON_WIDTH,
                BUTTON_HEIGHT, 
                BUTTON_HIT_LABEL));
    buttons.add(new Button(
                WIDTH - (GUI_RECT_WIDTH - (VW * 5)),
                WIDTH - VW * 27,
                BUTTON_WIDTH, 
                BUTTON_HEIGHT,
                BUTTON_SIT_LABEL));
    buttons.add(new Button(
                WIDTH - (GUI_RECT_WIDTH - (VW * 5)), 
                WIDTH - VW * 19, 
                BUTTON_WIDTH, 
                BUTTON_HEIGHT, 
                BUTTON_DOUBLE_LABEL));
    buttons.add(new Button(
                WIDTH - (GUI_RECT_WIDTH - (VW * 5)), 
                WIDTH - VW * 11, 
                BUTTON_WIDTH, 
                BUTTON_HEIGHT, 
                BUTTON_SPLIT_LABEL));
                
  }
  
 void drawPlayerHand(ArrayList<Card> hand) 
 {
   int startPos = DRAW_PLAYER_HAND_X_START;
   int startHeight = DRAW_PLAYER_HAND_Y_START;
   for (int i = 0; i < hand.size(); ++i) {
     hand.get(i).draw(startPos + ((hand.get(i).w + STANDARD_CARD_SEPARATION) * i), startHeight);
   }
 }
 
 void drawComputerHand(ArrayList<Card> hand, int shown) 
 {
   int startPos = DRAW_CPU_HAND_X_START;
   int startWIDTH = DRAW_CPU_HAND_Y_START;
   
   if (shown <= -1) {
     shown = hand.size();
   }
   
   int i;
   for (i = 0; i < shown; ++i) {
     hand.get(i).draw(
                     startPos  + ((hand.get(i).w + STANDARD_CARD_SEPARATION) * i), 
                     startWIDTH
                     );
   }
   fill(CPU_HAND_HIDDEN_CARD_COLOR);
   
   //This places a dummy hidden card
   if (shown != hand.size()) 
   {
     rect(
         startPos + ((hand.get(i - 1).w + STANDARD_CARD_SEPARATION) * i), 
         startWIDTH,
         hand.get(i - 1).w,
         hand.get(i - 1).h
         );
   }
 }
 
 void drawText(int total, int money, int bet, ComputerPlayer cpu) {
   textSize(VW * 3.3);
   //textSize(VW * 3.3);
   fill(255);
   String totalText;
   if (total <= 21) {
     totalText = CARD_TOTAL_TEXT + total;

   }else {
     totalText = CARD_TOTAL_TEXT + total + CARD_TOTAL_TEXT_BUST;
   }
   text(totalText, 
       WIDTH - GUI_RECT_WIDTH + VW,
       VW * 20,
       GUI_RECT_WIDTH,
       VW * 20);
   
   String cpuTotalText;
   if (cpu.total <= 21) {
     cpuTotalText = CPU_CARD_TOTAL_TEXT + cpu.total;

   }else {
     cpuTotalText = CPU_CARD_TOTAL_TEXT + cpu.total + CARD_TOTAL_TEXT_BUST;
   }
   text(cpuTotalText, 
       WIDTH - GUI_RECT_WIDTH + VW, 
       VW * 35, 
       GUI_RECT_WIDTH, 
       VW * 25);

   //textSize(VW * 3.2);
   if (gm.betLocked)
       fill(#ff0000);

   text(BET_TEXT + bet, 
       WIDTH - GUI_RECT_WIDTH + VW, 
       VW * 5, 
       GUI_RECT_WIDTH, 
       VW * 10);
   
   fill (#ffffff);
   text(TOTAL_MONEY_TEXT + money, 
       WIDTH - GUI_RECT_WIDTH + VW, 
       VW * 10, 
       GUI_RECT_WIDTH, 
       VW * 10);
   
   
   if (gm.hasWon || gm.hasLost) {
     
     textSize(WIN_TEXT_SIZE);
     text(WIN_TEXT, 
         DRAW_WIN_TEXT_X_START, 
         DRAW_WIN_TEXT_Y_START, 
         DRAW_WIN_TEXT_WIDTH, 
         DRAW_WIN_TEXT_HEIGHT);
   }
   
   if (gm.hasWon || gm.hasLost || gm.gameState == "start") {
    
    fill (0);
    rect (DRAW_CPU_MESSAGE_X_START, 
          DRAW_CPU_MESSAGE_Y_START, 
          DRAW_CPU_MESSAGE_RECT_WIDTH, 
          DRAW_CPU_MESSAGE_RECT_HEIGHT);
    fill(255);
    float textSize = DRAW_CPU_MESSAGE_RECT_HEIGHT - DRAW_CPU_MESSAGE_TEXT_OFFSET_Y;
    textSize(textSize);
    while (textWidth(gm.cpuMessage) > DRAW_CPU_MESSAGE_RECT_WIDTH) {
      textSize(--textSize);
    }
    text (gm.cpuMessage, 
          DRAW_CPU_MESSAGE_TEXT_OFFSET, 
          DRAW_CPU_MESSAGE_TEXT_OFFSET_Y,
          DRAW_CPU_MESSAGE_RECT_WIDTH,
          DRAW_CPU_MESSAGE_RECT_HEIGHT);
   }
   
 }
 
 void setWinText () {
     if (gm.hasWon && !gm.hasLost) {
       WIN_TEXT = WINNER_ANNOUNCE_TEXT + gm.winner;
       winTextSet = true;
     }else if (gm.hasLost) {
       WIN_TEXT = LOSE_TEXT;
       loseTextSet = true;
     }
     WIN_TEXT_SIZE = DRAW_WIN_TEXT_HEIGHT;
     textSize(WIN_TEXT_SIZE);
     while (textWidth(WIN_TEXT) > DRAW_WIN_TEXT_WIDTH) {
      textSize(--WIN_TEXT_SIZE); 
     }
 }
 
  void drawGUI(ArrayList<Button> buttons) {
   for (Button button : buttons) 
   {
    if (button.hovering() 
        && !(button.getLabel() == BUTTON_DOUBLE_LABEL 
        && (gm.isDouble || gm.betLocked))) 
    {
     button.currentCol = button.hoverCol;
    }else {
      button.currentCol = button.col;
    }
    
    if (button.getLabel() == BUTTON_DOUBLE_LABEL) {
      if (!gm.isDouble && button.getTextColor() == IS_DOUBLE_COLOR) {
       button.setTextColor(#000000); 
      }else if (gm.isDouble && button.getTextColor() != IS_DOUBLE_COLOR) {
       button.setTextColor(IS_DOUBLE_COLOR); 
      }
    }
   
    button.draw();
   }
  }
 
}
