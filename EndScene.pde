
class EndScene extends Scene
{
    EndScene() {
        super( "end_scene.png" );  
    }

    public void doStepWhileInState()
    {
        super.doStepWhileInState();
        inventory.isVisible = false;
        if ( player_background.position() == player_background.length() ) player_background.rewind();
        player_background.play();
    }

    void handleMousePressed() {
            stateHandler.changeStateTo( MENU_SCENE );
            player_background.pause();
            player_background = minim.loadFile("another_chance_to_live.mp3");
    }
}
