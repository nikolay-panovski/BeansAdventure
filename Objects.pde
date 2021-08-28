/*
table of contents:
 RiddleItem
 RiddleBook
 RiddleChest
 RiddleCharacterChonk
 RiddleCharacterBat
 */

class RiddleItem extends ImageObject {

  RiddleItem( String imageFilename, int newX, int newY ) {
    super( imageFilename, newX, newY );
  }

  void handleMousePressed() {
    if ( isPointInside ( mouseX, mouseY ) && ! inventory.items.contains( this ) && buffer == 0 ) {
      println( "handleMousePressed.added" );
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
      audio.PlaySFX("Book_Page.mp3");
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

class RiddleCharacterChonk extends ImageObject {
  int currentValue;
  int requiredValue = 31524;                    // mind the character order when the value is scrambled from 12345!
  boolean riddleStarted = false;
  boolean riddleSolved = false;

  ImageObject riddleImg = new ImageObject( "openbook_puzzle.png", 0, 0 );
  ImageObject subImg;

  ArrayList<ImageObject> sender = new ArrayList<ImageObject>();
  ArrayList<ImageObject> receiver = new ArrayList<ImageObject>();

  ImageObject answerHint = new ImageObject( "button_hermes.png", 812, 104 );  // Hermes (image only)    // all other names below are of the CORRECT order. this does not mean ANY corresponds to the ImageObject on the same row.
  ImageObject answer1;                          // Aphrodite
  ImageObject answer2;                          // Ares
  ImageObject answer3;                          // Zeus
  ImageObject answer4;                          // Poseidon
  ImageObject answer5;                          // Hades
  ImageObject resetButton = new ImageObject( "button_reset.png", 262, 104 );

  RiddleCharacterChonk( String imageFilename, int newX, int newY, String displayImg ) {
    super( imageFilename, newX, newY );
    characterCounter = 5;
    subImg = new ImageObject( displayImg, 0, 0 );
    riddleImg.isVisible = false;
    subImg.isVisible = false;
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

    dialog.Trigger(DialogTextDict.chonkPuzzleInit, beans_hamsterdark, beansdark_hamster);
    //====================== DIALOGUE PART ======================
    if ( subImg.isVisible == false && isPointInside ( mouseX, mouseY ) ) {
      if ( riddleStarted == false  ) {
        if ( dialog.counter + dialog.characterCounter <= 5 ) { 
          dialog.counter = 0;
          dialog.isVisible = true;
        }
        dialog.characterCounter = characterCounter;
      } else if ( riddleStarted == true && riddleImg.isVisible == false ) {
        dialog.isVisible = true;
        dialog.counter = 0;
        //if( dialog.counter + dialog.characterCounter == 13 ) riddleImg.isVisible = true;
        audio.PlaySFX("Book_Page.mp3");
        subImg.isVisible = true;
      }
      /*else if( riddleStarted == true && riddleImg.isVisible == true ) {
       //dialog.counter = 0;
       riddleImg.isVisible = false;
       }*/
    } else if ( subImg.isVisible == true && ! isPointInRectangle( mouseX, mouseY, 105, 71, 1020, 771 ) ) {    // exit puzzle: only if you click out of subImg
      subImg.isVisible = false;
    }

    if ( riddleImg.isVisible == true && riddleStarted == false ) {
      riddleStarted = true;
      riddleImg.isVisible = false;
      dialog.characterCounter = characterCounter;
      dialog.counter = 0;
      println(dialog.counter + dialog.characterCounter);
    }
    if ( dialog.counter + dialog.characterCounter == 9 ) {
      characterCounter = 11;
      riddleImg.isVisible = true;
      audio.PlaySFX("Book_Page.mp3");
    }

    //====================== RIDDLE PART ======================

    if ( subImg.isVisible && buffer == 0 ) {
      for ( int i = 0; i < sender.size(); i++ ) {
        ImageObject button = sender.get(i);
        if ( button.isPointInside ( mouseX, mouseY ) && buffer == 0  ) {
          audio.PlaySFX("Pop_Button1.mp3");
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
        audio.PlaySFX("Pop_Button1.mp3");
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
    if ( riddleImg.isVisible || subImg.isVisible ) buffer--;
    if ( buffer < 0) buffer = 0;
    if ( receiver.size() == 0 ) currentValue = 0;
    super.display();
    riddleImg.display();
    subImg.display();
    if ( subImg.isVisible ) {
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

class RiddleCharacterBat extends ImageObject {
  //characterCounter;
  boolean riddleSolved = false;

  RiddleCharacterBat( String imageFilename, int newX, int newY ) {
    super( imageFilename, newX, newY );
  }

  void handleMousePressed() {
    if ( dialog.isVisible == false && dialog.characterCounter < 23 ) {
      dialog.counter = 0;
      dialog.characterCounter = 23;
      dialog.isVisible = true;
    }

    if ( dialog.counter + dialog.characterCounter == 30 ) {
      dialog.counter = 0;
      dialog.characterCounter = 29;
      if( isPointInside (mouseX, mouseY) ) dialog.isVisible = true;
    }



    if ( dialog.counter + dialog.characterCounter > 31 ) {    // spam failsafe
      dialog.counter = 0;
      dialog.characterCounter = 31;
    }
    
    if ( inventory.nrOfRiddleItems == 5 ) {
      riddleSolved = true;
    }
  }


  void display() {
    super.display();
  }
}
