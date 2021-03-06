
class LibraryScene extends Scene
{
    //ArrayList<RiddleItem> container = new ArrayList<RiddleItem>();
  
    ImageObject       leftButton = new ImageObject( "arrowLeft.png",     80, 480 );
    ImageObject      rightButton = new ImageObject( "arrowRight.png",   1120, 850 );
    RiddleCharacterChonk   chonk = new RiddleCharacterChonk( "chonk_color.png",   200, 200, "openbook.png" );

    RiddleBook         book_aphro = new RiddleBook( 635, 300,  50,  80, "openbook_aphro.png" );
    RiddleBook          book_ares = new RiddleBook( 943, 440,  50,  45, "openbook_ares.png" );
    RiddleBook         book_hades = new RiddleBook( 885, 925,  90,  35, "openbook_hades.png" );
    RiddleBook      book_poseidon = new RiddleBook( 510, 604,  80, 100, "openbook_poseidon.png" );
    RiddleBook          book_zeus = new RiddleBook( 700, 805, 100,  90, "openbook_zeus.png" );
    
      RiddleBook       debug_puzzle = new RiddleBook( 950, 0, 100,  120, "openbook_puzzle.png" );    // click on the moon to display puzzle book.
    
    RiddleItem     telescope_tube = new RiddleItem( "telescope_tube.png", 600, 700 );


    LibraryScene() {
        super( "library_color.png" );
        telescope_tube.isVisible = false;
    }

    public void doStepWhileInState()
    {
        super.doStepWhileInState();
        if ( ! ( ( Scene ) stateHandler.currentState ).container.contains( telescope_tube ) && ! inventory.items.contains( telescope_tube ) ) container.add( telescope_tube );       
        leftButton.display();
        rightButton.display();

        chonk.display();   
        if( chonk.subImg.isVisible == false ) {
          book_aphro.display();
          book_ares.display();
          book_hades.display();
          book_poseidon.display();
          book_zeus.display();
            debug_puzzle.display();
          for( int i = 0; i < container.size(); i++ ) {
            RiddleItem item = container.get(i);
            if( item != telescope_tube ) item.display();
            if( item == telescope_tube && telescope_tube.isVisible ) item.display();
          }
          if( chonk.riddleSolved == true ) telescope_tube.isVisible = true;
        }
        if( dialog.isVisible == true ) dialog.display();
        
        if( chonk.currentValue == chonk.requiredValue && chonk.riddleSolved == false ) {
          audio.PlaySFX("Good_Job2.mp3");
          chonk.riddleSolved = true;
        }
        

    }

    void handleMousePressed() {
        if( dialog.isVisible == false || dialog.counter + dialog.characterCounter == 9
                                      || dialog.counter + dialog.characterCounter == 13) chonk.handleMousePressed();
        
        if( dialog.isVisible == false && chonk.riddleImg.isVisible == false && chonk.subImg.isVisible == false ) {
          if ( leftButton.isPointInside( mouseX , mouseY ) ) {
            stateHandler.changeStateTo( ROOM_SCENE );
            audio.PlayMusic("Warm_Casual.mp3");
          }
          if ( rightButton.isPointInside( mouseX , mouseY ) ) {
            stateHandler.changeStateTo( BREW_SCENE );
            audio.PlayMusic("Groovy_Tower.mp3");
          }
        
          book_aphro.handleMousePressed();
          book_ares.handleMousePressed();
          book_hades.handleMousePressed();
          book_poseidon.handleMousePressed();
          book_zeus.handleMousePressed();
            debug_puzzle.handleMousePressed();
          inventory.handleMousePressed();
          //telescope_tube.handleMousePressed();
        }
        
        if( chonk.riddleStarted == true && chonk.riddleImg.isVisible == true && chonk.buffer == 0 ) chonk.riddleImg.isVisible = false;
      
      if( dialog.isVisible == true ) dialog.handleMousePressed();
        
      for( int i = 0; i < container.size(); i++ ) {
        RiddleItem item = container.get(i);
        item.buffer = 0;
        if( chonk.riddleImg.isVisible == false && chonk.subImg.isVisible == false ) item.handleMousePressed();
      }
    }
    
    void handleKeyPressed() {
      inventory.handleKeyPressed();
    }
}
