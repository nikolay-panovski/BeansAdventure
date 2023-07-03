// ============ FIELD/OBJECT INITIALIZATION ============
PFont mainFont;
PImage cursorImage;
MinimAudio audio;

StateHandler stateHandler;

final State    MENU_SCENE = new    MenuScene();
final State    ROOM_SCENE = new    RoomScene();
final State    BREW_SCENE = new    BrewScene();
final State LIBRARY_SCENE = new LibraryScene();
final State     END_SCENE = new     EndScene();

Inventory inventory = new Inventory( "inventory_color.png", 300, 0 );

DialogBox dialog = new DialogBox( "dialog_box.png", 140, 720 );    // (140, 720) if needed
final DialogTextDict dialogDict = new DialogTextDict();

public PImage     beans_default;
public PImage beans_hamsterdark;
public PImage beansdark_hamster;
public PImage     beans_batdark;
public PImage     beansdark_bat;

// ============ SETUP/DRAW ============

void setup() {
    size( 1280, 960, FX2D );
    noStroke(); 
    initAudioPlayer();
    initTextFont();
    customizeCursorImage();
    initStateHandler(MENU_SCENE);  // change start scene name here
    initImages();
}


void draw() {
    stateHandler.executeCurrentStateStep();
    if( stateHandler.getStateName() != "MenuScene" ) inventory.display();
}



   
   // many public accesses (on RoomScene display()), this is bad
   void checkNrOfInventoryTelescopeItems() {
      inventory.nrOfTelescopeItems = 0;
      for( int c = 0; c < inventory.items.size(); c++ ) {
          RiddleItem checkItem = inventory.items.get(c);
          if( checkItem.filename.substring( 0, min( 9, checkItem.filename.length() ) ).equals( "telescope" ) ) inventory.nrOfTelescopeItems++;
      } 
   }


// ============ INIT METHODS ============

// Initializers for stuff before/in setup(), organized in methods for better readability/less visual clutter.

private void initAudioPlayer() {
  audio = new MinimAudio(this, "another_chance_to_live.mp3", "Pop_Button2.mp3");
  audio.SetGain(MinimAudio.DEFAULT_GAIN);
}

private void initTextFont() {
  mainFont = createFont( "ArbeiBerry-rg3Ky.ttf", 32 );
}

private void customizeCursorImage() {
  cursorImage = loadImage( "cursor.png" );
  cursor(cursorImage);
}

private void initStateHandler(State startScene) {
  stateHandler = new StateHandler( "Example game" );
  stateHandler.changeStateTo( startScene ); 
}

private void initImages() {
  beans_default = loadImage("beans.png");
  beans_hamsterdark = loadImage("beans_hamsterdark.png");
  beansdark_hamster = loadImage("beansdark_hamster.png");
  beans_batdark = loadImage("beans_batdark.png");
  beansdark_bat = loadImage("beansdark_bat.png");
}

// ============ EVENT HANDLERS ============

// only put stuff in here that is valid for all states
// otherwise use the handleKeyPressed in the state itself

void keyPressed()    { stateHandler.handleKeyPressed();    }
void keyReleased()   { stateHandler.handleKeyReleased();   }
void keyTyped()      { stateHandler.handleKeyTyped();      }

void mousePressed()  { stateHandler.handleMousePressed();  }
void mouseClicked()  { stateHandler.handleMouseClicked();  }
void mouseReleased() { stateHandler.handleMouseReleased(); }
void mouseDragged()  { stateHandler.handleMouseDragged();  }
void mouseMoved()    { stateHandler.handleMouseMoved();    }

void mouseWheel(MouseEvent event) { stateHandler.handleMouseWheel( event ); }
