
class EndScene extends Scene
{
    EndScene() {
        super( "end_scene.png" );  
    }

    public void doStepWhileInState()
    {
        super.doStepWhileInState();
        inventory.isVisible = false;
    }

    void handleMousePressed() {
            stateHandler.changeStateTo( MENU_SCENE );
            audio.PlayMusic("another_chance_to_live.mp3");
    }
}
