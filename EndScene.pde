
class EndScene extends Scene
{
  boolean firstTime = true;
  
    EndScene() {
        super( "end_scene.png" );  
    }

    public void doStepWhileInState()
    {
        super.doStepWhileInState();
        inventory.isVisible = false;
        
        // (very dirty) for the first game ending, display extra "final" dialog saying that the game is, in fact, over and not continued
        if (firstTime == true) {
         dialog.Trigger(DialogTextDict.endSceneFinale, beans_default);
         firstTime = false;
        }
        if( dialog.isVisible == true ) dialog.display();
    }

    void handleMousePressed() {
            stateHandler.changeStateTo( MENU_SCENE );
            audio.PlayMusic("another_chance_to_live.mp3");
            
        if( dialog.isVisible == true ) dialog.handleMousePressed();
    }
}
