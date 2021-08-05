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
    }

    void handleMousePressed() {
        if ( startButton.isPointInside( mouseX , mouseY ) ) {
            stateHandler.changeStateTo( ROOM_SCENE );
            audio.PlaySFX("Pop_Button2.mp3");
            audio.PlayMusic("Warm_Casual.mp3");
        }
        if ( quitButton.isPointInside( mouseX , mouseY ) ) {
            audio.PlaySFX("Pop_Button2.mp3");
            exit();
        }
        inventory.handleMousePressed();
    }
}
