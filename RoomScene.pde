
class RoomScene extends Scene
{
    //ArrayList<RiddleItem> container = new ArrayList<RiddleItem>();
  
    ImageObject   downButton = new ImageObject(    "arrowDown.png", 1020, 780 );
    ImageObject        beans = new ImageObject(   "beans_orig.png",   40, 330 );
    RiddleChest        chest = new RiddleChest(        "chest.png",  612, 420, "chest_lock.png" );
    ImageObject    telescope = new ImageObject(    "telescope.png",  760, 325 );
    RiddleBook    scrolls = new RiddleBook( 450, 380, 150, 80, "scroll_text.png" );
    
    RiddleItem telescope_eye = new  RiddleItem( "telescope_eyepiece.png",   640, 605 );

    RoomScene() {
        super( "bean_room_color.png" );
        telescope_eye.isVisible = false;
        telescope.isVisible = false;
    }

    public void doStepWhileInState()
    {
        super.doStepWhileInState();
        if ( ! ( ( Scene ) stateHandler.currentState ).container.contains( telescope_eye ) && ! inventory.items.contains( telescope_eye ) ) container.add( telescope_eye );       
        downButton.display();
        if( telescope.isVisible == true ) telescope.display();
        
        if( dialog.isVisible == true && inventory.nrOfTelescopeItems != 2 ) beans.isVisible = false;
        else if( dialog.isVisible == false ) beans.isVisible = true;
        beans.display();
        chest.display();
        if( chest.currentValue == chest.requiredValue && chest.riddleSolved == false ) {
          audio.PlaySFX("Good_Job2.mp3");
          chest.riddleSolved = true;
        }
        if( dialog.isVisible == true ) dialog.display();
        scrolls.display();
        
      for( int i = 0; i < container.size(); i++ ) {
        RiddleItem item = container.get(i);
        item.display();
        item.buffer--;
        if ( item.buffer < 0) item.buffer = 0;
      }
            
      if( inventory.nrOfTelescopeItems == 2 /**&& dialog.counter + dialog.characterCounter < 42**/ ) {
        super.doStepWhileInState();       
        beans.display();
        chest.display();
        scrolls.display();
        downButton.display();
        dialog.isVisible = true;
        dialog.counter = 0;
        /**dialog.characterCounter = 41;**/
      }
      if( inventory.nrOfTelescopeItems == 3 && telescope.isVisible == false ) {
        telescope.isVisible = true;
      }
      
    }

    void handleMousePressed() {
      if( chest.subImg.isVisible == false && scrolls.subImg.isVisible == false && dialog.isVisible == false ) {
        if ( downButton.isPointInside( mouseX , mouseY ) ) {
            stateHandler.changeStateTo( LIBRARY_SCENE );
            audio.PlayMusic("Fireplace_Loop.mp3");
        }
        if( telescope.isVisible == true && telescope.isPointInside( mouseX , mouseY ) ) {
            stateHandler.changeStateTo( END_SCENE ); 
            audio.PlayMusic("another_chance_to_live.mp3");
        }
      }
      if( dialog.isVisible == true ) dialog.handleMousePressed();
      if( scrolls.subImg.isVisible == false && dialog.isVisible == false ) chest.handleMousePressed();
      if( chest.subImg.isVisible == false && dialog.isVisible == false ) scrolls.handleMousePressed();
      if( chest.riddleSolved == true && telescope_eye.isVisible == false ) telescope_eye.isVisible = true;
      
      // -- test of new DialogBox.Trigger() --
      if (beans.isVisible == true && beans.isPointInside(mouseX, mouseY)) dialog.Trigger(DialogTextDict.introText, beans_default);
      // -- end of test --
      
      inventory.nrOfTelescopeItems = 0;
      for( int c = 0; c < inventory.items.size(); c++ ) {
          RiddleItem checkItem = inventory.items.get(c);
          if( checkItem.filename.substring( 0, min( 9, checkItem.filename.length() ) ).equals( "telescope" ) ) inventory.nrOfTelescopeItems++;
      }
      
      inventory.handleMousePressed();
      for( int i = 0; i < container.size(); i++ ) {
        RiddleItem item = container.get(i);
        item.buffer = 0;
        if( item.isVisible ) item.handleMousePressed();
      }
    }
    
    void handleKeyPressed() {
      inventory.handleKeyPressed();
    }
}
