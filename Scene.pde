
class Scene extends State
{
  ArrayList<RiddleItem> container = new ArrayList<RiddleItem>();
  
  int buffer = 15;

  PImage background;
  String filename;

  Scene( String backgroundFilename ) {
    filename = backgroundFilename;
  }

  void enterState( State oldState )
  {
    if ( background == null ) {
      background = loadImage( filename );
    }
  }

  public void handleMousePressed() {
    for ( int i = container.size() - 1; i >= 0; i-- ) {
      RiddleItem item = container.get(i);
      item.handleMousePressed();
    }
      
    inventory.nrOfRiddleItems = 0;
    for( int c = 0; c < inventory.items.size(); c++ ) {
        RiddleItem checkItem = inventory.items.get(c);
        if( ! checkItem.filename.substring( 0, min( 9, checkItem.filename.length() ) ).equals( "telescope" ) ) inventory.nrOfRiddleItems++;
    }
  }

  public void doStepWhileInState()
  {
    image( background, 0, 0, width, height );
    for ( int i = 0; i < container.size(); i++ ) {
      RiddleItem item = container.get(i);
      item.display();
    }
    
    if (dialog.dialogEndSignal == true) buffer--;
    if (buffer < 0) {
      buffer = 0;
      dialog.dialogEndSignal = false;
    }
  }
}
