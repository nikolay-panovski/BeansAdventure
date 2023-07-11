
class RoomScene extends Scene
{
    //ArrayList<RiddleItem> container = new ArrayList<RiddleItem>();
  
    ImageObject   downButton = new ImageObject(    "arrowDown.png", 1020, 780 );
    ImageObject        beans = new ImageObject(   "beans_orig.png",   40, 330 );
    RiddleChest        chest = new RiddleChest(        "chest.png",  612, 420, "chest_lock.png" );
    ImageObject    telescope = new ImageObject(    "telescope.png",  760, 325 );
    RiddleBook    scrolls = new RiddleBook( 450, 380, 150, 80, "scroll_text.png" );
    
    RiddleItem telescope_eye = new  RiddleItem( "telescope_eyepiece.png",   640, 605 );
    
    boolean firstTime = true;
    boolean firstTimeAfterBatRiddleSolved = true;

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
        
        // very dirty: override first dialog automatic appearance (without being preceded by a click) with manual Trigger() + counter advance
        // in order to "fix" the "first click not advancing text" bug
        // (?!??) bugs every other instance of the same Beans dialog (if the character is clicked again in the same room)
        if (firstTime == true && dialog.isVisible == true) {
          dialog.Trigger(DialogTextDict.introText, beans_default);
          dialog.textCounter++;
          firstTime = false;
        }
        
        if( (dialog.isVisible == true && inventory.nrOfTelescopeItems != 2)
            || chest.subImg.isVisible == true || scrolls.subImg.isVisible == true ) beans.isVisible = false;
        else if( dialog.isVisible == false ) beans.isVisible = true;
        beans.display();
        chest.display();
        if( chest.currentValue == chest.requiredValue && chest.riddleSolved == false ) {
          audio.PlaySFX("Good_Job2.mp3");
          chest.riddleSolved = true;
          chest.subImg.isVisible = false;
          dialog.Trigger(DialogTextDict.bedroomPuzzleSolved, beans_default);
        }
        if( dialog.isVisible == true ) dialog.display();
        scrolls.display();
        
      for( int i = 0; i < container.size(); i++ ) {
        RiddleItem item = container.get(i);
        item.display();
        item.buffer--;
        if ( item.buffer < 0) item.buffer = 0;
      }
      
      checkNrOfInventoryTelescopeItems();
      
      // dirty: access of public variables
      if (((BrewScene)BREW_SCENE).bat.riddleSolved == true && firstTimeAfterBatRiddleSolved == true) {
        if ( inventory.nrOfTelescopeItems == 3 ) dialog.Trigger(DialogTextDict.bedroomFinal, beans_default);
        else                                     dialog.Trigger(DialogTextDict.bedroomPuzzleInit, beans_default);
        firstTimeAfterBatRiddleSolved = false;
      }
      
      if( chest.riddleSolved == true && dialog.isVisible == false && telescope_eye.isVisible == false ) telescope_eye.isVisible = true;
      
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
      if (dialog.dialogEndSignal == true) return;
      if( scrolls.subImg.isVisible == false && dialog.isVisible == false ) chest.handleMousePressed();
      if( chest.subImg.isVisible == false && dialog.isVisible == false ) scrolls.handleMousePressed();
      
      // -- test of new DialogBox.Trigger() --
      if (beans.isVisible == true && beans.isPointInside(mouseX, mouseY)) dialog.Trigger(DialogTextDict.introCallToAction, beans_default);
      // -- end of test --
      
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
