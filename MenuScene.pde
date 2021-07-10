class MenuScene extends Scene
{
    ImageObject  startButton = new ImageObject(  "newgame_button.png", 1020, 360 );
    ImageObject   quitButton = new ImageObject(     "quit_button.png", 1020, 600 );

    MenuScene() {
        super( "main_menu_color2.png" );
    }

    public void doStepWhileInState()
    {
        super.doStepWhileInState();
        startButton.display();
        quitButton.display();
        if ( player_background.position() == player_background.length() ) player_background.rewind();
        player_background.play();
    }

    void handleMousePressed() {
        if ( startButton.isPointInside( mouseX , mouseY ) ) {
            stateHandler.changeStateTo( ROOM_SCENE );
            player_background.pause();
            player_background = minim.loadFile("Warm_Casual.mp3");
            player_SFX = minim.loadFile("Pop_Button2.mp3");
            player_SFX.play();
        }
        if ( quitButton.isPointInside( mouseX , mouseY ) ) {
            player_SFX = minim.loadFile("Pop_Button2.mp3");
            player_SFX.play();
            exit();
        }
        inventory.handleMousePressed();
    }
}
