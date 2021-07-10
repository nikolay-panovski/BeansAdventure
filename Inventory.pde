class Inventory extends ImageObject {
  int nrOfRiddleItems;
  int nrOfTelescopeItems;
  
  int offset = 60;
  boolean isVisible = false;
  ArrayList<RiddleItem> items = new ArrayList<RiddleItem>();

  Inventory( String buttonImageFilename, int newX, int newY ) {
    super( buttonImageFilename, newX, newY );
  }

  public void handleMousePressed() {
    for ( int i = 0; i < items.size(); i++ ) {
      RiddleItem item = items.get(i);
      int item_x = int(x + offset + 108 * i);
      int item_y = int(y + offset);
      if ( item.isPointInRectangle ( mouseX, mouseY, item_x, item_y, 40, 40 ) && item.buffer == 0 ) {
            item.buffer += 15;
            ( ( Scene ) stateHandler.currentState ).container.add( item );
            items.remove( item );
      }
    }
  }

  public void handleKeyPressed() {
    if ( keyPressed ) {
      if ( key == 'i' || key == 'I' ) isVisible = ! isVisible;
    }
  }

  public void display() {
    if ( isVisible ) {
      super.display();
    }
    for ( int i = 0; i < items.size(); i++ ) {
      RiddleItem item = items.get(i);
      int item_x = int(x + offset + 108 * i);
      int item_y = int(y + offset);
      displayItemAt( item, item_x, item_y, 50, 50 );
      item.buffer--;
      if( item.buffer < 0) item.buffer = 0;
    }
  }

  private void displayItemAt( ImageObject item, int item_x, int item_y, int objectWidth, int objectHeight ) {
    float factor_w =  objectWidth / (float) item.w;
    float factor_h = objectHeight / (float) item.h;
    pushMatrix();
    translate( item_x, item_y );
    // if you want to have the same proportions use scale( min( factor_w, factor_h ) );
    // you should also calculate an offset in either horizontal or vertical direction
    scale( min( factor_w, factor_h ) );
    translate( -item.x, -item.y );
    item.display();
    popMatrix();
  }
}
