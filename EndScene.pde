
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
        
        audio.PlaySFX("Pop_Button2.mp3");
        particles.EmitParticlesOnClick(new PVector(10, 20), new PVector(-25, 25), new PVector(-10, 10), new PVector(127, 255));
    }
}
