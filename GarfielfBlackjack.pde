//====Blackjack==== //<>//

import java.util.concurrent.ConcurrentLinkedQueue;
import java.io.FileNotFoundException;
import java.util.Scanner;

public static final int WIDTH = 700;
public static  int HEIGHT = WIDTH;
public static final int START_MONEY = 20;
public static final float CARD_SIZE = WIDTH * 0.1;
public static boolean CPU_MUTED;
public static String DATA_PATH;
public static String TEXT_LANGUAGE;
public static int MONEY_FOR_LOSE;
public static String DATA_PACK;
public static final String DEFAULT_DATA_PACK = "default/";
public static final String SCORE_FILENAME = "score.dat";
public static boolean GARFIELF_VOICE_OPTION;
public static File SCORE_FILE;
public static XMLReader xml;
public static BoomBox bb;

public static PFont FONT;

private int prevTimeMillis = 0;

Main main = new Main(1);
Menu menu = new Menu(0);
ErrorScreen error = new ErrorScreen(2);

Scene[] scenes = {menu, main, error};
Scene currentScene = menu;
int currentSceneIndex = 0;

PImage spadesImage, heartsImage, diamondsImage, clubsImage, cpuSprite, cpuSpriteAngry, cpuSpriteHappy, titleImage;


void settings() {
  loadSettings();
  size(WIDTH, WIDTH);
}

void setup() {
  
  DATA_PATH = dataPath("settings.txt").substring(0,dataPath("settings.txt").length() - 12);
  TEXT_LANGUAGE = loadGameLanguage();
  xml = new XMLReader(TEXT_LANGUAGE);
  bb = new BoomBox();
  bb.minim = new Minim(this);
  loadText();
  loadSounds();
  SCORE_FILE = new File(dataPath(SCORE_FILENAME));
  if (!SCORE_FILE.exists()) {
    saveBytes(SCORE_FILE, new byte[4]);
  }
  FONT = loadFont("text/SourceCodePro-Bold-68.vlw");
  spadesImage = loadGameImage("spades.png");
  heartsImage = loadGameImage("hearts.png");
  diamondsImage = loadGameImage("diamonds.png");
  clubsImage = loadGameImage("clubs.png");
  cpuSprite = loadGameImage("garfielf.png");
  cpuSpriteAngry = loadGameImage("garfielf_angry.png");
  cpuSpriteHappy = loadGameImage("garfielf_happy.png");
  titleImage = loadGameImage("title.png");
  titleImage.resize(WIDTH, WIDTH);
  currentScene.init();
}

void draw() 
{
  currentScene.onDraw();
  
  int nextScene = currentScene.nextScene();
  if (nextScene != currentSceneIndex) {
   currentSceneIndex = nextScene;
   currentScene = scenes[currentSceneIndex];
   currentScene.init();
  }
}

void keyPressed() {
  currentScene.onKey(keyCode);
}

void mousePressed() {
  currentScene.onMouse(mouseButton);
}

PImage loadGameImage(String imageName) {
  String imageNameWithPath = DATA_PACK + imageName;
  File theImageFile = dataFile(imageNameWithPath);
  PImage theImage;
  if (theImageFile.exists()) {
    theImage = loadImage(imageNameWithPath);
  }else{
    if (DATA_PACK != DEFAULT_DATA_PACK) {
      imageNameWithPath = DEFAULT_DATA_PACK + imageName;
      theImageFile = dataFile(imageNameWithPath);
      if (theImageFile.exists()) {
       theImage = loadImage(imageNameWithPath);
       return theImage;
      }
    }
    println(imageName + " was not loaded. The image was probably renamed or removed from the data folder.");
    theImage = createImage(25,25,RGB);
    theImage.loadPixels();
    for (int i = 0; i < theImage.pixels.length; ++i) {
     theImage.pixels[i] = color(#ff00ff); 
    }
    theImage.updatePixels();

  }
  return theImage;
}

String loadGameLanguage() {
  try {
    Scanner fileReader = new Scanner(new File(dataPath("settings.txt")));
    String languageString = fileReader.nextLine();
    fileReader.close();
    languageString = languageString.substring(5, languageString.length());
    return dataPath("text/text_" + languageString + ".xml");
  }catch (FileNotFoundException e) {
    errorScreen(e);
    return "";
  }
}

void loadSettings() {
 String moneyString = "";
 try 
 {
   Scanner fileReader = new Scanner(new File(dataPath("settings.txt")));
   fileReader.nextLine();
   moneyString = fileReader.nextLine();//money_for_lose
   int moneyNumber = Integer.parseInt(moneyString.substring(15, moneyString.length()));
   print(moneyNumber + "  ");
   MONEY_FOR_LOSE = moneyNumber;
   
   String datapackString = fileReader.nextLine();//datapack
   DATA_PACK = datapackString.substring(5, datapackString.length()) + "/";
   print(DATA_PACK);
   
   String voiceOptionString = fileReader.nextLine();
   if (voiceOptionString.substring(6, voiceOptionString.length()).startsWith("t")) {
     GARFIELF_VOICE_OPTION = true;
   }else {
    GARFIELF_VOICE_OPTION = false; 
   }
   
   fileReader.close();
 }catch(Exception e) 
 {
  errorScreen(e); 
 }

}

void errorScreen(Exception e) {
    currentSceneIndex = 2;
    currentScene = scenes[2];
    StackTraceElement[] stackTrace = e.getStackTrace();
    String errorMessage = e + "\n";
    for (StackTraceElement element : stackTrace) {
      errorMessage += element.toString() + "\n";
    }
    error.setMessage(errorMessage);
}

int deltaTime() {
  int time = millis() - prevTimeMillis;
  prevTimeMillis = millis();
  return time;
}
