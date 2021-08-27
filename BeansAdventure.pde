// ============ STATE HANDLER, STATES, (hopefully) PERSISTENT OBJECTS + AUDIO ============
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

public PImage             beans;
public PImage beans_hamsterdark;
public PImage beansdark_hamster;
public PImage     beans_batdark;
public PImage     beansdark_bat;

void setup() {
    size( 1280, 960, FX2D );
    noStroke();
    audio = new MinimAudio(this, "another_chance_to_live.mp3", "Pop_Button2.mp3");
    audio.SetGain(MinimAudio.DEFAULT_GAIN);
    mainFont = createFont( "ArbeiBerry-rg3Ky.ttf", 32 );
    cursorImage = loadImage( "cursor.png" );
    cursor(cursorImage);
    stateHandler = new StateHandler( "Example game" );
    stateHandler.changeStateTo( MENU_SCENE );
    
    beans = loadImage("beans.png");
    beans_hamsterdark = loadImage("beans_hamsterdark.png");
    beansdark_hamster = loadImage("beansdark_hamster.png");
    beans_batdark = loadImage("beans_batdark.png");
    beansdark_bat = loadImage("beansdark_bat.png");
}


void draw() {
    stateHandler.executeCurrentStateStep();
    if( stateHandler.getStateName() != "MenuScene" ) inventory.display();
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
