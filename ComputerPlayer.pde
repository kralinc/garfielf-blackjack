class ComputerPlayer{ 
  
  private static final int CPU_SPRITE_WIDTH                  = (WIDTH / 100) * 40;
  private static final int CPU_SPRITE_HEIGHT                 = (WIDTH / 100) * 20;
  
  ArrayList<Card> hand;
  
  int total;
  PImage sprite;
  //int bet;
  //int money;
  
  GameManager gm;
  
  ComputerPlayer() {
   hand = new ArrayList(); 
   total = 0;
   //money = START_MONEY;
   //bet = 1;
  }
  
  ComputerPlayer(GameManager g) {
   hand = new ArrayList();
   total = 0;
   gm = g;
   sprite = new PImage();
   //money = START_MONEY;
   //bet = 1;
  }
  
  void changeSprite(String spriteName) 
  {
    if (spriteName.equals("happy")) 
    {
      sprite = cpuSpriteHappy.copy();
    }else if (spriteName.equals("angry")) 
    {
     sprite = cpuSpriteAngry.copy(); 
    }else {
      sprite = cpuSprite.copy();
    }
    
    sprite.resize(CPU_SPRITE_WIDTH, CPU_SPRITE_HEIGHT);
  }
  
  
  
  //TODO: Make it actually play intelligently
  int play() {
    total = gm.evaluate(hand);

    float riskChance = random(1);
    boolean takeRisk = true;
    while (takeRisk){
      if (total < 14 
      || (total < 16 && riskChance > 0.2) 
      || (total < 18 && riskChance > 0.6)
      || (total < 20 && riskChance > 0.94)
      || (total < 21 && riskChance > 0.99)
      && total <= 21) {
       hand.add(gm.deck.remove()); 
      }else {
       takeRisk = false; 
      }
      total = gm.evaluate(hand);
    }
    
    return total;
  }
  
  //NOTE: Removed the AI betting feature. Commenting remains in case I want to add it back in later.
  /*void bet(int playerCardValue) {
    total = gm.evaluate(hand);
    float betFactor = random(0.0,0.2);
    
    if (total == 21) {
      betFactor += 0.2;
    }else if (total > 18) {
     betFactor += 0.1; 
    }else if (total > 16) {
     betFactor += 0.05; 
    }else {
     betFactor += 0.01; 
    }
    
    if (playerCardValue == 1) {
      if (total == 21) {
       betFactor += 0.1; 
      }else if (total > 17) {
       betFactor += 0.05; 
      }
    }else if (playerCardValue == 10) {
      betFactor -= 0.1;
    }else if (playerCardValue > 7) {
      betFactor += 0.05;
    }else {
      betFactor += 0.1;
    }
    
    //Minimum bet is 1 + 5%, bet factor is how much more the AI wants to wager
    bet = 1 + (int)(money * (betFactor + 0.05));
    
    if (bet <= 0) {
     bet = 1; 
    }else if (bet > money) {
     bet = money; 
    }
    
  }*/
}
