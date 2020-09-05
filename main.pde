class Main implements Scene {
  
  int scene;
  //ArrayList<Card> hand;
  ArrayList<Button> buttons;
  DrawMaster draw;
  ComputerPlayer cpu;
  GameManager gm;
                    
  
  
  Main(int s) {
    scene = s;
    buttons = new ArrayList();
    gm = new GameManager();
    draw = new DrawMaster(gm);
    cpu = new ComputerPlayer(gm);
  }
  
  void init() 
  {
    //bb.playMusic();
    gm.generateDeck();
    gm.hand.clear();
    cpu.hand.clear();
    gm.shuffle(2);
    gm.reset();
    gm.load();
    //gm.money = START_MONEY;
    draw.setupButtons(buttons);
    cpu.changeSprite("neutral");
    bb.playSound("start");

  }
  
  void onDraw()
  {
   
    draw.drawMainLayout(cpu);
    if (gm.gameState.equals("deal"))
    {
      gm.deal(cpu);
      draw.winTextSet = false;
      draw.loseTextSet = false;
    }else if (gm.gameState.equals("play"))
    {
      draw.drawComputerHand(cpu.hand, 1);
    }
    
    else if (gm.gameState.equals("comp")) 
    {
      gm.computerMove(cpu);
    }else if (gm.gameState.equals("eval")) 
    {
      int cpuCardsToDraw = (gm.turnIsOver()) ? -1 : 1;
      draw.drawComputerHand(cpu.hand, cpuCardsToDraw);
      gm.currentMouseClickTimeDelay += deltaTime();
      if (!draw.winTextSet) {
        draw.setWinText();
      }
    }else if (gm.gameState.equals("lost")) 
    {
      draw.drawComputerHand(cpu.hand, -1);
      gm.currentMouseClickTimeDelay += deltaTime();
      if (!draw.loseTextSet) {
        draw.setWinText();
      }
    }
    
    draw.drawPlayerHand(gm.hand);
    draw.drawText(gm.cardTotal, gm.money, gm.bet, cpu);
    draw.drawGUI(buttons);
    
  }
  
  
  void onMouse(int k) 
  {
    gm.onMouse(k, buttons, cpu);
    
    if (gm.hasLost && gm.currentMouseClickTimeDelay > gm.mouseClickWinTimeDelay) {
     init(); 
     gm.money = START_MONEY;
    }
  }
  
  void onKey (int k) {
   gm.onKey(k, cpu);
   if ((k == ENTER && gm.hasLost)) 
   {
     init();
     gm.money = START_MONEY;
   }
  }
  
  int nextScene() {
    return scene;
  }
 
  
}
