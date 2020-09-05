class Menu implements Scene {
  
  int scene;
  Button[] buttons = new Button[2];
  boolean showControls = false;
  int timeSinceControlsOpened = 0;
  int textSize;
  
  Menu(int s) {
    scene = s;
  }
  
  
  void init() {
    bb.start();
    int BUTTON_SIZE_UNIT = WIDTH / 20; //create the size of the buttons in units of 1/20 of the screen.
    buttons[0] = new Button(BUTTON_SIZE_UNIT, 
                            HEIGHT - BUTTON_SIZE_UNIT * 5, 
                            BUTTON_SIZE_UNIT * 6, 
                            BUTTON_SIZE_UNIT * 2, 
                            START_GAME_TEXT);
                            
    buttons[1] = new Button(WIDTH - BUTTON_SIZE_UNIT * 7, 
                            HEIGHT - BUTTON_SIZE_UNIT * 5, 
                            BUTTON_SIZE_UNIT * 6, 
                            BUTTON_SIZE_UNIT * 2, 
                            OPTIONS_TEXT);
                            
    setupControlsPanel();
  }
  
  void onDraw() {
    background(0);
    image(titleImage,0,0);
    drawButtons();
    if (showControls)
    {
     drawControlsPanel(); 
     timeSinceControlsOpened += deltaTime();
    }
  }
  
  void onMouse(int k) {
    for (Button b : buttons) {
      if (b.hovering() && !showControls) {
        if (b.label == START_GAME_TEXT) {
          ++scene;
        }else if (b.label == OPTIONS_TEXT) {
         showControls = true;
        }
      }
    }
    
    if (showControls == true && timeSinceControlsOpened > 100)
    {
      showControls = false;
      timeSinceControlsOpened = 0;
    }
  }
  
  void onKey (int k) {
    
  }
  
  int nextScene() {
    return scene;
  }
  
  void drawButtons() {
   for (Button button : buttons) 
   {
    if (button.hovering() 
        && !(button.getLabel() == BUTTON_DOUBLE_LABEL)) 
    {
     button.currentCol = button.hoverCol;
    }else {
      button.currentCol = button.col;
    }
    button.draw(); //<>//
   }
  }
  
  void drawControlsPanel() {
   stroke(0);
   fill(255);
   rect(WIDTH / 10, WIDTH / 10, WIDTH - 2*(WIDTH/10), WIDTH - 2*(WIDTH/10));
   fill(0);
   textSize(textSize);
   text(CONTROLS_TEXT, WIDTH / 7, WIDTH / 7); //<>//
  }
  
  void setupControlsPanel() {
    textSize = WIDTH / 10;
    textSize(textSize);
    while (textWidth(CONTROLS_TEXT) > (WIDTH - ((21 * WIDTH) / 70))) {
     textSize(textSize--); 
    }
  }
  
}
