class ErrorScreen implements Scene {
  
  int scene;
  String errorMessage;
  
  ErrorScreen(int s) {
    scene = s;
  }
  
  
  void init() {
    errorMessage = "";
    bb.interrupt();
  }
  
  void onDraw() {
    background(0);
    fill(255);
    textSize(WIDTH / 30);
    text(errorMessage, 0, 0, WIDTH, WIDTH);
  }
  
  void onMouse(int k) {
  }
  
  void onKey (int k) {
    
  }
  
  int nextScene() {
    return scene;
  }
  
  void setMessage(String s) {
   errorMessage = s; 
  }
  
}
