import ddf.minim.*;

class MinimAudio {
  Minim minim;
  PApplet root;
  AudioPlayer player_background;
  AudioPlayer player_SFX;
  final static int DEFAULT_GAIN = 12;
  int currentGain = 12;

  MinimAudio(PApplet sketchRoot) {
    root = sketchRoot;
    minim = new Minim(root);
  }
  
  MinimAudio(PApplet sketchRoot, String initBGMfilename, String initSFXfilename) {
    root = sketchRoot;
    minim = new Minim(root);
    player_background = minim.loadFile(initBGMfilename);
    player_SFX = minim.loadFile(initSFXfilename);
    PlayMusic(initBGMfilename);
  }
  
  public void PlayMusic(String filename) {
    PlayMusic(filename, true);     // default to looping = true (no default args in java)
  }
  
  public void PlayMusic(String filename, boolean looping) {
    if (player_background != null && player_background.isPlaying()) player_background.pause();  // ??
    player_background = minim.loadFile(filename);
    if (looping) {
      player_background.loop();    // loop() forces play as well so it can replace play() for BGM
    }
    else player_background.play();
  }
  
  public void PlaySFX(String filename) {
    player_SFX = minim.loadFile(filename);
    player_SFX.play();
  }
  
  public void SetGain(float gain) {
    if (player_background != null) player_background.setGain(gain);  
    if (player_SFX != null) player_SFX.setGain(gain); 
  }
  
  public void SetGain(float gain, AudioPlayer player) {
    if (player != null) player.setGain(gain);
  }
  
  /*public void RewindBGM() {
    if ( player_background.position() == player_background.length() ) player_background.rewind();
  }*/
}
