//import processing.sound.*;
import ddf.minim.*;

class BoomBox extends Thread{  
  
  public float MUSIC_VOLUME = 0.3;
  
  Minim minim;

  AudioPlayer music;
  AudioSample click;
  AudioSample startTaunt;
  ArrayList<AudioSample> tauntFiles = new ArrayList();
  ArrayList<AudioSample> loseFiles = new ArrayList();
  

  
  void playMusic() 
  {
    if (music != null) {
      music.setGain(MUSIC_VOLUME);
      music.loop(); //<>//
    }
  }
  
  public void run() {
    try {
    playMusic();
    }catch (Exception e) {
     errorScreen(e); 
    }
  }
  
  void playSound(String soundName) 
  {
   if (soundName.equals("click")) 
   {
     if (click != null) {
      click.trigger(); 
     }
   }else if (soundName.equals("start")) {
     if (startTaunt != null) {
      startTaunt.trigger(); 
     }
   }
  }
  
  void playTaunt(int index) {
   tauntFiles.get(index - 1).trigger();
  }
  
  void playLoseVoice(int index) {
   loseFiles.get(index - 1).trigger();
  }
}

void loadSounds() 
{
  try 
  {
    File clickSoundFile = new File(DATA_PATH + DATA_PACK + "sound/click.wav");
    if (!clickSoundFile.exists()) {
      clickSoundFile = new File(DATA_PATH + DEFAULT_DATA_PACK + "sound/click.wav");
    }
    if (clickSoundFile.exists()) {
      bb.click = bb.minim.loadSample(clickSoundFile.toString());
    }
    
    File musicFile = new File(DATA_PATH + DATA_PACK + "sound/music.wav");
    if (!musicFile.exists()) {
      musicFile = new File(DATA_PATH + DEFAULT_DATA_PACK + "sound/music.wav");
    }
    if (musicFile.exists()) {
      bb.music = bb.minim.loadFile(musicFile.toString());
    }
    
    File startTauntFile = new File(DATA_PATH + DATA_PACK + "sound/start.wav");
    if (!startTauntFile.exists()) {
      startTauntFile = new File(DATA_PATH + DEFAULT_DATA_PACK + "sound/start.wav");
    }
    if (startTauntFile.exists()) {
      bb.startTaunt = bb.minim.loadSample(startTauntFile.toString());
    }
    
    //find the taunt/lose sound files
    int iterator = 1;
    while (true) 
    {
     File tauntFile = new File(DATA_PATH + DATA_PACK + "sound/taunt" + iterator + ".wav");
     if (tauntFile.exists()) {
       bb.tauntFiles.add(bb.minim.loadSample(tauntFile.toString()));
       ++iterator;
     }else {
      tauntFile = new File(DATA_PATH + DEFAULT_DATA_PACK + "sound/taunt" + iterator + ".wav");
      if (tauntFile.exists()) {
        bb.tauntFiles.add(bb.minim.loadSample(tauntFile.toString()));
        ++iterator;
      }else {
       break; 
      }
     }
    }
    iterator = 1;
    while (true) 
    {
     File loseFile = new File(DATA_PATH + DATA_PACK + "sound/lose" + iterator + ".wav");
     if (loseFile.exists()) {
       bb.loseFiles.add(bb.minim.loadSample(loseFile.toString()));
       ++iterator;
     }else {
      loseFile = new File(DATA_PATH + DEFAULT_DATA_PACK + "sound/lose" + iterator + ".wav");
      if (loseFile.exists()) {
        bb.tauntFiles.add(bb.minim.loadSample(loseFile.toString()));
        ++iterator;
      }else {
       break; 
      }
     }
    }
    
  }catch(Exception e) 
  {
   errorScreen (e); 
  }
}
