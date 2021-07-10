// ============ STATE HANDLER, STATES, (hopefully) PERSISTENT OBJECTS + AUDIO ============
import ddf.minim.*;

Minim minim;
AudioPlayer player_background;
AudioPlayer player_SFX;
int currentGain = 12;

PFont mainFont;
PImage cursorImage;

StateHandler stateHandler;

final State    MENU_SCENE = new    MenuScene();
final State    ROOM_SCENE = new    RoomScene();
final State    BREW_SCENE = new    BrewScene();
final State LIBRARY_SCENE = new LibraryScene();
final State     END_SCENE = new     EndScene();

Inventory inventory = new Inventory( "inventory_color.png", 300, 0 );

DialogBox dialog = new DialogBox( "dialog_box.png", 140, 720 );    // (140, 720) if needed

void setup() {
    size( 1280, 960, FX2D );
    noStroke();
    minim = new Minim(this);
    player_background = minim.loadFile("another_chance_to_live.mp3");    // why is THIS global
    player_background.setGain(currentGain);
    player_SFX = minim.loadFile("Pop_Button2.mp3");
    player_SFX.setGain( -(currentGain / 1.5) );
    mainFont = createFont( "ArbeiBerry-rg3Ky.ttf", 32 );
    cursorImage = loadImage( "cursor.png" );
    cursor(cursorImage);
    stateHandler = new StateHandler( "Example game" );
    stateHandler.changeStateTo( MENU_SCENE );
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
