class GameManager{
 
  ConcurrentLinkedQueue<Card> deck;
  ArrayList<Card> hand;
  ArrayList<Card> splitHand;
  
  //Various data to control the flow of the game
  boolean betLocked;
  boolean hasWon;
  boolean hasLost;
  boolean isDouble;
  boolean split;
  boolean handsHaveBeenSwapped;
  String winner;
  String cpuMessage;
  int mouseClickWinTimeDelay = 200;
  int currentMouseClickTimeDelay = 0;
  
  String gameState;
  int minimumBet;
  int money;
  int bet;
  int cardTotal;
  
  GameManager() {
    deck = new ConcurrentLinkedQueue();
    hand = new ArrayList(); 
    splitHand = new ArrayList();
    //reset();
  }
  
  void reset() {
    betLocked = false;
    hasWon = false;
    hasLost = false;
    isDouble = false;
    split = false;
    handsHaveBeenSwapped = false;
    winner = "";
    cpuMessage = START_GARFIELF_TEXT;
    gameState = "start";
  }
  
  //TODO: In blackjack, Ace can be either 1 or 11. Find a way to use the aces to get the optimal score.
  //Create the largest number less than 21
  int evaluate(ArrayList<Card> hand) 
  {
    int total = 0;
    int aces = 0;
    for(Card c : hand) {
      if (c.getNumValue() == 1) {
        ++aces;
      }else {
        total += c.value.numericalValue;
      }
    }
    
    for (int i = aces; i > 0; --i) {
      if (total + 11 + (i-1) <= 21) {
        total += 11;
      }else {
       total++; 
      }
    }
    
    return total;
  }
  
  void shuffle(int passes) 
  {
    Card[] tempDeck = new Card[52];
    for (int i = 0; i < tempDeck.length; ++i) {
     tempDeck[i] = deck.remove();
    }
    
    //User decides how many times to run the shuffle. More than 1 is usually overkill.
    for (int i = 0; i < passes; ++i)
    {
      //Fisher-Yates shuffle
      int end = tempDeck.length - 1;
      for (int j = 0; j < tempDeck.length; ++j) 
      {
        int index = (int)random(0,end - 1);
        Card temp = tempDeck[end];
        tempDeck[end] = tempDeck[index];
        tempDeck[index] = temp;
        --end;
      }
    }
    
    for (int i = 0; i < tempDeck.length; ++i) {
     deck.add(tempDeck[i]); 
    }
  
  }
  
  void deal(ComputerPlayer cpu) 
  {
    save();
    minimumBet = (int)(1 + (money * 0.1));
    bet = minimumBet;
    reset();
    refillDeck(cpu);
    shuffle(1);
    drawCards(hand, 2);
    drawCards(cpu.hand, 2);
    cpu.total = cpu.hand.get(0).getNumValue();
    cpu.changeSprite("Neutral");
    cardTotal = evaluate(hand);
    gameState = "play";
    currentMouseClickTimeDelay = 0;
    handsHaveBeenSwapped = false;
  }
  
  void drawCards(ArrayList<Card> hand, int amount) 
  {
    for (int i = 0; i < amount; ++i)
    {
      hand.add(deck.remove());
    }
  }
  
  void computerMove(ComputerPlayer cpu)
  {
    cpu.total = cpu.play();
    checkForVictory(cpu);
  }
  
  void checkForVictory(ComputerPlayer cpu) {
    
    int multiplier = (isDouble) ? 2 : 1;
    
    if ((cpu.total > 21 || cpu.total < cardTotal) && cardTotal <= 21)
    {
       winRound(multiplier, cpu);
    }else 
    {
     loseRound(multiplier, cpu);
    } 
  }
  
  void refillDeck(ComputerPlayer cpu) 
  {
   while (!hand.isEmpty()) {
    deck.add(hand.remove(hand.size() - 1));
   }
   while (!splitHand.isEmpty()) {
     deck.add(splitHand.remove(splitHand.size() - 1));
   }
   while (!cpu.hand.isEmpty()) {
    deck.add(cpu.hand.remove(cpu.hand.size() - 1)); 
   }
  }
  
    //Creates a standard, unshuffled 52 card deck;
  void generateDeck()
  {
    deck.clear();
    for (int suit = 0; suit < 4; ++suit) {
     for (int value = 1; value < 14; ++value) {
      Card c = new Card(suit, value);
      c.resize(CARD_SIZE);
      deck.add(c);
      
     }
    }
  }
  
  void hit(ComputerPlayer cpu) {
    if (gameState != "eval" && cardTotal <= 21) {
      betLocked = true;
      hand.add(deck.remove());
      int multiplier = 1;
      if (isDouble) {
        multiplier = 2;
        
      }
      
      if ((cardTotal = evaluate(hand)) > 21 && !split) 
      {
        loseRound(multiplier, cpu);
      }
    }
  }
  
  void sit() 
  {
    if (gameState != "eval") 
    {
      if (turnIsOver())
      {
        gameState = "comp";
      }else {
        swapHands();
      }
    }
  }
  
  void split() 
  {
    if (hand.size() == 2 && hand.get(0).getFaceValue() == hand.get(1).getFaceValue()) 
    {
      splitHand.add(hand.get(1));
      hand.remove(1);
      drawCards(hand, 1);
      drawCards(splitHand, 1);
      split = true;
      betLocked = true;
    }
  }
  
  void swapHands() 
  {
   ArrayList<Card> tempHand = new ArrayList(hand);
   hand.clear();
   hand = new ArrayList(splitHand);
   splitHand = new ArrayList(tempHand);
   handsHaveBeenSwapped = true;
   cardTotal = evaluate(hand);
   gameState = "play";
  }
  
    
  void winRound(int multiplier, ComputerPlayer cpu) 
  {
    winner = WINNER_PLAYER_TEXT;
    setRandomCPUMessage();
    money += bet * multiplier;
    cpu.changeSprite("angry");
    hasWon = true;
    gameState = "eval";
  }
  
  void loseRound(int multiplier, ComputerPlayer cpu)
  {
     winner = WINNER_CPU_TEXT;
     setRandomCPUMessage();
     money -= bet * multiplier;
     cpu.total = evaluate(cpu.hand);
     cpu.changeSprite("happy");
     hasWon = true;
     gameState = "eval";
  }
  
  boolean turnIsOver() {
   if (split) {
     if (handsHaveBeenSwapped) {
       return true;
     }else {
       return false;
     }
   }else {
    return true; 
   }
  }
  
  void nextRound(ComputerPlayer cpu) {
    if (money < MONEY_FOR_LOSE) 
    {
         hasLost = true;
         gameState = "lost";
         currentMouseClickTimeDelay = 0;
         cpu.changeSprite("happy");
    }
    else if (!split)
     {
       
       gameState = "deal";
  
     }else {
       swapHands();
       split = false;
       checkForVictory(cpu);
     }
  }
  
    
  void setRandomCPUMessage() {
   if (winner == WINNER_PLAYER_TEXT) {
      XML cpuMessageRaw = xml.getRandomString("lose");
      cpuMessage = xml.getStringContents(cpuMessageRaw); 
      int voiceIndex = xml.getStringSoundFile(cpuMessageRaw);
      if (voiceIndex > 0 && !(voiceIndex > bb.loseFiles.size()) && GARFIELF_VOICE_OPTION) {
        bb.playLoseVoice(voiceIndex);
      }
    }else {
      XML cpuMessageRaw = xml.getRandomString("win");
      cpuMessage = xml.getStringContents(cpuMessageRaw);
      int voiceIndex = xml.getStringSoundFile(cpuMessageRaw);
      if (voiceIndex > 0 && !(voiceIndex > bb.tauntFiles.size()) && GARFIELF_VOICE_OPTION) {
        bb.playTaunt(voiceIndex);
      }
    }
  }
  
  void save() {
   int moneyCopy = money;
   byte[] moneyBytes = new byte[4];
   
   int lorgeMoney = (int)pow(255,3);
   if (moneyCopy > lorgeMoney) 
   {
     int lorgeRemainder = moneyCopy % lorgeMoney;
     moneyCopy = (moneyCopy - lorgeRemainder) / lorgeMoney;
     moneyBytes[0] = (byte)moneyCopy;
     moneyCopy = lorgeRemainder;
   }else 
   {
    moneyBytes[0] = 0; 
   }
   
   int bigMoney = (int)pow(255,2);
   if (moneyCopy > bigMoney) 
   {
     int bigRemainder = moneyCopy % bigMoney;
     moneyCopy = (moneyCopy - bigRemainder) / bigMoney;
     moneyBytes[1] = (byte)moneyCopy;
     moneyCopy = bigRemainder;
   }else 
   {
     moneyBytes[1] = 0;
   }
   
   int mmoney = 255;
   if (moneyCopy > mmoney) 
   {
     int remainder = moneyCopy % mmoney;
     moneyCopy = (moneyCopy - remainder) / mmoney;
     moneyBytes[2] = (byte)moneyCopy;
     moneyCopy = remainder;
   }else 
   {
     moneyBytes[2] = 0;
   }
   
   moneyBytes[3] = (moneyCopy > 0) ? (byte)moneyCopy : 0;
   saveBytes(SCORE_FILE, moneyBytes);
  }
  
  void load() {
   byte[] score = loadBytes(SCORE_FILE);
   money = score[0] * (int)pow(255,3) 
         + score[1] * (int)pow(255,2) 
         + score[2] * 255
         + score[3];
   if (money <= MONEY_FOR_LOSE) {
    money = START_MONEY;
    save();
   }
  }
  
  void onMouse(int k, ArrayList<Button> buttons, ComputerPlayer cpu) 
  {
   if (gameState.equals("play")) 
    {
     for (Button b: buttons) 
     {
      if (b.hovering()) 
      {
        if (b.getLabel().equals(BUTTON_HIT_LABEL)) 
        {
          hit(cpu);
        }else if (b.getLabel().equals(BUTTON_SIT_LABEL)) 
        {
          sit();
        }else if (b.getLabel().equals(BUTTON_DOUBLE_LABEL) && !isDouble && !betLocked) 
        {
          isDouble = true;
          hit(cpu);
        }else if (b.getLabel().equals(BUTTON_SPLIT_LABEL) && !split) 
        {
          split();
        }
        bb.playSound("click");
      }
     }
    }
    
    if (gameState.equals("eval") && currentMouseClickTimeDelay > mouseClickWinTimeDelay)
    {
      nextRound(cpu);
    }
    
    if (gameState.equals("start")) {
     gameState = "deal"; 
    }
  }

  
  void onKey(int k, ComputerPlayer cpu) 
  {
   switch (k) 
   {
    case(UP):
      if (!betLocked)
        bet = (++bet > money) ? money : bet;
      break;
      
    case(DOWN):
      if (!betLocked)
        bet = (--bet < minimumBet) ? minimumBet : bet;
      break;
      
    case('W'):
      if (!betLocked)
        bet = (bet + 10 < money) ? bet + 10 : money;
        break;
        
    case('S'):
      if (!betLocked)
        bet = (bet - 10 > minimumBet) ? bet - 10 : minimumBet;
        break;
        
    case('H'):
      hit(cpu);
      break;
      
    case('J'):
      sit();
      break;
      
    case('K'):
      isDouble = true;
      hit(cpu);
      break;
      
    case ('L'):
      split();
      break;
      
    case(ENTER):
    case (' '):
      if (gameState.equals("eval")) {
       nextRound(cpu);
      }
      break;
   } 
   
   if (gameState.equals("start")) {
     gameState = "deal"; 
    }
    
  }
  
}
