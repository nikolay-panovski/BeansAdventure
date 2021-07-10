
class BrewScene extends Scene
{
    //ArrayList<RiddleItem> container = new ArrayList<RiddleItem>();
  
    ImageObject    leftButton = new ImageObject( "arrowLeft.png"  ,   60, 550 );

    RiddleCharacterBat bat = new RiddleCharacterBat( "bat_color.png",  840, 320 );
    
    RiddleItem           milk = new  RiddleItem( "milk_bottle.png", 540, 160 );
    RiddleItem          hairs = new  RiddleItem( "cat_hair.png",   840, 260 );
    RiddleItem         leaves = new  RiddleItem( "leaf.png",   1100, 780 );
    RiddleItem         potion = new  RiddleItem( "potion.png",   1180, 200 );
    RiddleItem           tuna = new  RiddleItem( "tuna_can.png",   1070, 220 );
    
    RiddleItem  telescope_lens = new  RiddleItem( "telescope_lens.png",   665, 310 );

    BrewScene() {
        super( "brewery_room.png" );
        telescope_lens.isVisible = false;
    }

    public void doStepWhileInState()
    {
        super.doStepWhileInState();
        leftButton.display();
        
        if ( ! ( ( Scene ) stateHandler.currentState ).container.contains(   milk ) && ! inventory.items.contains(   milk ) ) container.add( milk );         
        if ( ! ( ( Scene ) stateHandler.currentState ).container.contains(  hairs ) && ! inventory.items.contains(  hairs ) ) container.add( hairs ); 
        if ( ! ( ( Scene ) stateHandler.currentState ).container.contains( leaves ) && ! inventory.items.contains( leaves ) ) container.add( leaves ); 
        if ( ! ( ( Scene ) stateHandler.currentState ).container.contains( potion ) && ! inventory.items.contains( potion ) ) container.add( potion ); 
        if ( ! ( ( Scene ) stateHandler.currentState ).container.contains(   tuna ) && ! inventory.items.contains(   tuna ) ) container.add( tuna ); 
        
        if ( ! ( ( Scene ) stateHandler.currentState ).container.contains( telescope_lens ) && ! inventory.items.contains( telescope_lens ) ) container.add( telescope_lens );
        
        
        
      for( int i = 0; i < container.size(); i++ ) {
        RiddleItem item = container.get(i);
        item.display();
        item.buffer--;
        if ( item.buffer < 0) item.buffer = 0;
      }
      
      bat.display();
      if( dialog.isVisible == true ) dialog.display();
      
      if ( player_background.position() == player_background.length() ) player_background.rewind();
      player_background.play();
    }

    void handleMousePressed() {
      super.handleMousePressed();
        if ( leftButton.isPointInside( mouseX , mouseY ) ) {
            stateHandler.changeStateTo( LIBRARY_SCENE );
            inventory.isVisible = false;
            player_background.pause();
            player_background = minim.loadFile("Fireplace_Loop.mp3");
        }
        if ( bat.isPointInside( mouseX , mouseY ) ) bat.handleMousePressed();
        inventory.handleMousePressed();
        if( dialog.isVisible == true ) dialog.handleMousePressed();
        
        if( inventory.nrOfRiddleItems == 5 && telescope_lens.isVisible == false ) {
           for( int c = inventory.items.size(); c > 0 ; c-- ) {
                RiddleItem checkItem = inventory.items.get(c-1);
                if( ! checkItem.filename.substring( 0, min( 9, checkItem.filename.length() ) ).equals( "telescope" ) ) {
                  inventory.items.remove( checkItem );
                  checkItem.isVisible = false;
                }
            }
          telescope_lens.isVisible = true;
          player_SFX = minim.loadFile("Good_Job2.mp3");
          player_SFX.play();
        }
  }
    
    void handleKeyPressed() {
      inventory.handleKeyPressed();
    }
}
