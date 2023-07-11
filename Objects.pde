/*
table of contents:
 RiddleItem
 RiddleBook
 RiddleChest
 RiddleCharacterChonk
 RiddleCharacterBat
 
 == TODO?: make riddle character out of Beans, because of game start and 3rd puzzle ==
 */

class RiddleItem extends ImageObject {

  RiddleItem( String imageFilename, int newX, int newY ) {
    super( imageFilename, newX, newY );
  }

  void handleMousePressed() {
    if ( isPointInside ( mouseX, mouseY ) && ! inventory.items.contains( this ) && buffer == 0 ) {
      buffer += 15;
      inventory.isVisible = true;
      inventory.items.add( this );
      ( ( Scene ) stateHandler.currentState ).container.remove( this );
    }
  }

  void display() {
    if ( inventory.isVisible && inventory.items.contains( this ) ) super.display();
    else if ( ( ( Scene ) stateHandler.currentState ).container.contains( this ) ) super.display();
  }

  boolean isPointInRectangle(float px, float py, float rx, float ry, float rw, float rh) {
    return px >= rx && px <= rx + rw && py >= ry && py <= ry + rh;
  }
}

class RiddleBook extends NoImageObject {
  ImageObject subImg;

  RiddleBook( int newX, int newY, int newW, int newH, String displayImg ) {
    super( newX, newY, newW, newH );
    subImg = new ImageObject( displayImg, 0, 0 );
    subImg.isVisible = false;
  }

  void handleMousePressed() {
    if ( subImg.isVisible == false && isPointInside ( mouseX, mouseY ) ) {
      subImg.isVisible = true;
      //audio.PlaySFX("Book_Page.mp3");
    } else if ( subImg.isVisible == true && subImg.isPointInside ( mouseX, mouseY ) ) {
      subImg.isVisible = false;
    }
  }

  void display() {
    super.display();
    subImg.display();
  }
}

class RiddleChest extends ImageObject {
  int currentValue;
  int requiredValue = 420;
  boolean riddleSolved = false;

  ImageObject subImg;
  DigitButton codeDigit1;
  DigitButton codeDigit2;
  DigitButton codeDigit3;

  RiddleChest( String imageFilename, int newX, int newY, String displayImg ) {
    super( imageFilename, newX, newY );
    subImg = new ImageObject( displayImg, 0, 0 );
    subImg.isVisible = false; 
    codeDigit1 = new DigitButton( 440, 470, "", 140 );
    codeDigit2 = new DigitButton( 620, 470, "", 140 );
    codeDigit3 = new DigitButton( 790, 470, "", 140 );
  }

  void handleMousePressed() {
    if ( subImg.isVisible == false && isPointInside ( mouseX, mouseY ) ) {
      subImg.isVisible = true;
      buffer += 15;
    } else if ( subImg.isVisible == true && ! isPointInRectangle ( mouseX, mouseY, 150, 150, 980, 660 ) ) {
      subImg.isVisible = false;
      buffer += 15;
    }



    if ( subImg.isVisible == true && buffer == 0 ) {
      codeDigit1.handleMousePressed();
      codeDigit2.handleMousePressed();
      codeDigit3.handleMousePressed();
    }   
    currentValue = codeDigit1.digit * 100 + codeDigit2.digit * 10 + codeDigit3.digit;
  }

  void display() {
    super.display();
    subImg.display();
    if ( subImg.isVisible == true ) {
      buffer--;
      if ( buffer < 0 ) buffer = 0;
      codeDigit1.display();
      codeDigit2.display();
      codeDigit3.display();
    }
  }
}

public class RiddleCharacter extends ImageObject {
  // Capable of tracking the state of the relevant riddle (not started, started, solved).
  // Contains fields for a static image (riddle explanation) and an image with buttons drawn over (riddle execution). 
  // Contains lists to exchange objects between a starting list of imaged items (unordered - see riddleValue @ ImageObject,
  // owned etc.) and a "solution" list of items (correct order, all <number> of items).
  
  boolean riddleStarted = false;
  boolean riddleSolved = false;
  
  ImageObject explImg;
  ImageObject execImg;
  
  ArrayList<ImageObject> sender = new ArrayList<ImageObject>();
  ArrayList<ImageObject> receiver = new ArrayList<ImageObject>();
  
  RiddleCharacter(String imageFilename, int newX, int newY, String displayExplImg, String displayExecImg) {
    super( imageFilename, newX, newY );
    if (displayExplImg.length() != 0) {
      explImg = new ImageObject(displayExplImg, 0, 0);
      explImg.isVisible = false;  // TODO: automate in another way? requires restructurig ImageObject
    }
    if (displayExecImg.length() != 0) {
      execImg = new ImageObject(displayExecImg, 0, 0);
      execImg.isVisible = false;
    }
  }
  
  public void TriggerExplanation() {
    if (explImg != null) explImg.isVisible = true;
    dialog.dialogEndSignal = false;
  }
  
  public void TriggerExecution() {
    if (execImg != null) execImg.isVisible = true;
    dialog.dialogEndSignal = false;
  }
}

class RiddleCharacterChonk extends RiddleCharacter {
  int currentValue;
  int requiredValue = 31524;                    // mind the character order when the value is scrambled from 12345!

  ImageObject answerHint = new ImageObject( "button_hermes.png", 812, 104 );  // Hermes (image only)    
  // all other names in comments below are of the CORRECT order. this does not mean ANY corresponds to the ImageObject on the same row.
  ImageObject answer1;                          // Aphrodite
  ImageObject answer2;                          // Ares
  ImageObject answer3;                          // Zeus
  ImageObject answer4;                          // Poseidon
  ImageObject answer5;                          // Hades
  ImageObject resetButton = new ImageObject( "button_reset.png", 262, 104 );

  RiddleCharacterChonk( String imageFilename, int newX, int newY, String displayExplImg, String displayExecImg ) {
    super( imageFilename, newX, newY, displayExplImg, displayExecImg );
    //riddleImg.isVisible = false;
    //subImg.isVisible = false;
    answer1 = new ImageObject( "button_ares.png", 262, 224 );            // current starting position to draw frow (262, 224)
    answer1.riddleValue = 1;
    sender.add( answer1 );
    answer2 = new ImageObject( "button_poseidon.png", 262, 344 );
    answer2.riddleValue = 2;
    sender.add( answer2 );
    answer3 = new ImageObject( "button_aphro.png", 262, 464 );
    answer3.riddleValue = 3;
    sender.add( answer3 );
    answer4 = new ImageObject( "button_hades.png", 262, 584 );
    answer4.riddleValue = 4;
    sender.add( answer4 );
    answer5 = new ImageObject( "button_zeus.png", 262, 704 );
    answer5.riddleValue = 5;
    sender.add( answer5 );
  }

  void handleMousePressed() {

    
    //====================== DIALOGUE PART ======================
      if (isPointInside(mouseX, mouseY) && execImg.isVisible == false) {
        if (riddleSolved == true) {
          dialog.Trigger(DialogTextDict.chonkPuzzleAftermath, beansdark_hamster, beans_hamsterdark);
        }
        else {
          if (riddleStarted == false) {
            dialog.Trigger(DialogTextDict.chonkPuzzleInit, beans_hamsterdark, beansdark_hamster);
          }
          else if (riddleStarted == true && explImg.isVisible == false) {
            dialog.Trigger(DialogTextDict.chonkPuzzleAfterBook, beans_hamsterdark, beansdark_hamster);
          }
        }
      }
      
      else if ( explImg.isVisible == true && ! isPointInRectangle( mouseX, mouseY, 105, 71, 1020, 771 ) ) {    // exit puzzle: only if you click out of the img
        explImg.isVisible = false;
        if (riddleStarted == true) TriggerExecution();
      }
      else if ( execImg.isVisible == true && ! isPointInRectangle( mouseX, mouseY, 105, 71, 1020, 771 ) ) {    // exit puzzle: only if you click out of the img
        execImg.isVisible = false;
        //if (riddleSolved == true) dialog.Trigger(DialogTextDict.chonkPuzzleSolved, beans_hamsterdark, beansdark_hamster);
      }


    //====================== RIDDLE PART ======================

    if ( execImg.isVisible && buffer == 0 ) {
      for ( int i = 0; i < sender.size(); i++ ) {
        ImageObject button = sender.get(i);
        if ( button.isPointInside ( mouseX, mouseY ) && buffer == 0  ) {
          //audio.PlaySFX("Pop_Button1.mp3");
          buffer += 15;
          button.x += 550;
          button.y = 224 + receiver.size() * 120;
          sender.remove(i);
          for ( int c = 0; c < sender.size(); c++ ) {
            ImageObject remaining = sender.get(c);
            remaining.y = 224 + c * 120;
          }
          receiver.add( receiver.size(), button );
          currentValue += button.riddleValue * pow( 10, ( 5 - receiver.size() ) );
          println( currentValue );
        }
      }

      if ( resetButton.isPointInside( mouseX, mouseY ) ) {
        //audio.PlaySFX("Pop_Button1.mp3");
        sender.removeAll(sender);
        receiver.removeAll(receiver);
        sender.add( answer1 );
        sender.add( answer2 );
        sender.add( answer3 );
        sender.add( answer4 );
        sender.add( answer5 );
        for ( int i = 0; i < sender.size(); i++ ) {
          ImageObject button = sender.get(i);
          button.x = 262;
          button.y = 224 + i * 120;
        }
        currentValue = 0;
      }
    }
    buffer += 15;
  }

  void display() {
    // display self (ImageObject default)
    //if (!((explImg != null && explImg.isVisible) || (execImg != null && execImg.isVisible)))  // if any part of the puzzle is active, do not display character
    super.display();
    // display sub-images (ImageObject default, which btw has the stupid isVisible clause within itself so it's unreadable here)
    explImg.display();
    execImg.display();
    
    // if character has clicked and triggered the initial dialogue and it has ended, show puzzle book image immediately
    // also mark riddle as started if it isn't, so that on next click the puzzle area with buttons image is shown
    if (riddleSolved == false && dialog.dialogEndSignal == true) { //<>//
      TriggerExplanation();
      if (riddleStarted == false) {  //<>//
        riddleStarted = true;
      }
    }
          
    // handle "buffer" timer cooldown for clicks (which prevents double clicks)
    // (decrement but only when a clickable image is visible, and keep buffer at 0 minimum)
    if ( explImg.isVisible || execImg.isVisible ) buffer--;
    if ( buffer < 0) buffer = 0;
    
    
    // if image with the puzzle with buttons is visible, display all owned (by this object, good job) buttons and their slots
    if ( execImg.isVisible ) {
      answerHint.display();
      resetButton.display();
      stroke( 0 );
      strokeWeight( 3 );
      fill( 255, 128 );
      for ( int i = 0; i < 5; i++ ) {
        rect( 262, 104 + 120 * (i + 1), 180, 90 );
        rect( 812, 104 + 120 * (i + 1), 180, 90 );
      }

      for ( int i = 0; i < sender.size(); i++ ) {
        ImageObject button = sender.get(i);
        button.display();
      }
      for ( int i = 0; i < receiver.size(); i++ ) {
        ImageObject button = receiver.get(i);
        button.display();
      }
    }
  }
}

class RiddleCharacterBat extends RiddleCharacter {

  RiddleCharacterBat( String imageFilename, int newX, int newY, String displayExplImg, String displayExecImg ) {
    super( imageFilename, newX, newY, displayExplImg, displayExecImg );
  }

  void handleMousePressed() {
    if (isPointInside(mouseX, mouseY)) {
      //markRiddleSolvedAfterItems();  // check for riddle solve only on mouse press - slightly lighter execution + forces talking to bat to solve riddle
      
      triggerActiveDialog();
    }
  }
  
  private void triggerActiveDialog() {
    // TODO: to state-based (NOT if/else or switch/case)
      if (riddleSolved == true) {
        dialog.Trigger(DialogTextDict.batPuzzleAftermath, beansdark_bat, beans_batdark);    // TODO: auto trigger(?) batPuzzleSolved on riddleSolved, and never again?
      }
      else {
        if (riddleStarted == false) {
          dialog.Trigger(DialogTextDict.batPuzzleInit, beans_batdark, beansdark_bat);
        }
        else if (riddleStarted == true && riddleSolved == false) {
          dialog.Trigger(DialogTextDict.batPuzzleReminder, beansdark_bat, beans_batdark);
        }
      } 
  }
  
  private void markRiddleStartedAfterDialog() {
    if (riddleStarted == false && dialog.dialogEndSignal == true) {
      riddleStarted = true;
    }
  }
  
  private void markRiddleSolvedAfterItems() {
    if ( riddleSolved == false && inventory.nrOfRiddleItems == 5 ) {
      riddleSolved = true;
      if (inventory.nrOfTelescopeItems < 2) dialog.Trigger(DialogTextDict.batPuzzleSolved, beansdark_bat, beans_batdark);
      else                                  dialog.Trigger(DialogTextDict.batPuzzleSolvedLast, beansdark_bat, beans_batdark);
      dialog.textCounter++;  // same dirty fix to the same problem as in starting Beans dialog (RoomScene)
    }
  }

  void display() {
    // display self (ImageObject default)
    super.display();
    
    // if character has clicked and triggered the initial dialogue and it has ended, mark riddle as started
    // (updates active dialogue) (an Update()'s job, but is it a display()'s job?)
    markRiddleStartedAfterDialog();
    
    // CURRENT puzzle state: if character has collected all the items, immediately mark riddle as solved
    // TODO: not that; re-implement sub-screen for transfer, or leave the player to click for another dialogue
    /**/
    markRiddleSolvedAfterItems();
    /**/
  }
}
