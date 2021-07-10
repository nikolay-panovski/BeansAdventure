/*
table of contents:
NoImageObject
ImageObject
TextButton
DigitButton(TextButton)
DialogBox(ImageObject)
*/

class NoImageObject {                  //requires manual labor, do not use in industrial quantities :)
    int x;
    int y;
    int w;
    int h;
    
    NoImageObject( int newX, int newY, int newW, int newH ) {
        x = newX;
        y = newY;
        w = newW;
        h = newH;
    }
    
    void display() {
        noStroke();
        fill( 0, 0 );
        //fill( 255, 0, 255, 127 );    //DEBUG only, replace with fill(); with 0 alpha
        rect( x, y, w, h );
    }
    
   boolean isPointInside( int px, int py ) {
       return isPointInRectangle( px, py, x, y, w, h );
   }
}

class ImageObject {
    int x;
    int y;
    int w;
    int h;
    int riddleValue = 0;
    int buffer = 15;
    int characterCounter;
    boolean isVisible = true;

    String filename;
    PImage objectImage;
    
    ImageObject( String imageFilename, int newX, int newY ) {
        filename = imageFilename;
        x = newX;
        y = newY;
    }
    
    void display() {
        if ( objectImage == null ) {
          objectImage = loadImage( filename );
          w = objectImage.width;
          h = objectImage.height;
        }
        if( isVisible ) image( objectImage, x, y );
        //noFill();
        //stroke( 255, 0, 255 );
        //rect( x, y, buttonImage.width, buttonImage.height );
    }
    
   boolean isPointInside( int px, int py ) {
     if ( objectImage == null ) objectImage = loadImage( filename );
       return isPointInRectangle( px, py, x, y, objectImage.width, objectImage.height );
   }
}


class TextButton {
    int x;
    int y;

    String buttonText;
    int buttonTextSize;
    int buttonWidth;
    int buttonHeight;
    
    int offset;
    

    
    TextButton( int newX, int newY, String aButtonText, int aButtonTextSize ) {
        x = newX;
        y = newY;
        buttonText = aButtonText;
        buttonTextSize = aButtonTextSize;
        buttonWidth = 0;
        offset = buttonTextSize / 5;
    }
    
    void display() {
        stroke( 0 );
        strokeWeight( 3 );
        fill( 255, 128 );
        rect( x - offset, y - offset, buttonWidth + 2 * offset, buttonHeight + 2 * offset);
        fill( 0 );
        textFont( mainFont );
        textSize( buttonTextSize );
        if ( buttonWidth == 0 ) {
             buttonWidth = (int) textWidth( buttonText );
             buttonHeight = buttonTextSize;
        }
        text( buttonText, x, y + buttonTextSize * 0.9);
    }
    
   boolean isPointInside( int px, int py ) {
       return isPointInRectangle( px, py, x - offset, y - offset ,
                                  buttonWidth + 2 * offset, buttonTextSize +  2 * offset);
   }
}

class DigitButton extends TextButton {
    int digit = 0;
    int buttonWidth = 80;
    int buttonHeight = 130;
  
    DigitButton( int newX, int newY, String aButtonText, int aButtonTextSize ) {
      super( newX, newY, aButtonText, aButtonTextSize );
    }
    
    void handleMousePressed() {
      if( isPointInRectangle ( mouseX, mouseY, x - offset, y - offset, buttonWidth + 2 * offset, buttonHeight + 2 * offset ) ) {
        if( digit >= 9 ) digit = 0;
        else digit++;
      }
      player_SFX = minim.loadFile("Lock_number_Switch.mp3");
      player_SFX.play();
    }
    
    void display() {
      noStroke();
      fill( 255, 0 );
        rect( x - offset, y - offset, buttonWidth + 2 * offset, buttonHeight + 2 * offset );
        fill( 0 );
        textFont( mainFont );
        textSize( buttonTextSize );

        text( str( digit ), x, y + buttonTextSize * 0.9);
    }
}

class DialogBox extends ImageObject {
    int counter = 0;
    String currentText;
    ImageObject currentImage;
  
    ImageObject             beans = new ImageObject(             "beans.png", 0, 0 );
    ImageObject beans_hamsterdark = new ImageObject( "beans_hamsterdark.png", 0, 0 );
    ImageObject beansdark_hamster = new ImageObject( "beansdark_hamster.png", 0, 0 );
    ImageObject     beans_batdark = new ImageObject(     "beans_batdark.png", 0, 0 );
    ImageObject     beansdark_bat = new ImageObject(     "beansdark_bat.png", 0, 0 );
    
    StringList textManager = new StringList();
    
    DialogBox( String imageFilename, int newX, int newY ) {
        super( imageFilename, newX, newY );
        
        //beans init 4 || first item 0 / previously sections subdivided - 5, 10, 12, 17, 22, 24, 28, 31 / now each section will be of length 6 
        textManager.append("Hello! My name is Beans the cat, and I live in this tower. The place \nyou're standing in right now is my bedroom. I had a telescope in\nhere and I wanted to use it tonight to observe the annual\nfull moon. However, it's broken and I need your help to fix it.");
        textManager.append("There are 3 pieces hidden somewhere in this tower and I need\nyour help to find them. My tower has a mind of its own and likes\nto mess around with me, so there is probably a twist to getting\nthe parts back. Please help me find them! We'll be a great team!");
        textManager.append("Let's see... where might the parts be? Let's check the\nlibrary room first. Those books might be helpful if I read\nthem after all.");
        textManager.append("Oh, by the way, feel free to see what we have collected\nwith the 'I' button. You can press 'I' again to\nhide that out of view.");
        textManager.append("");
        textManager.append("");
        //beans-chonk 4 then display puzzle book
        textManager.append("Let me guess, you're here because the tower wanted you\nto be?");
        textManager.append("How did you know?");
        textManager.append("Just a guess. So I guess I'll have to solve a riddle to get a part\nof my telescope back?");
        textManager.append("Exactly. I'm too lazy to actually tell you the riddle, so have this\nbook. The riddle is in there and it tells you what to do.\nOnce you have an answer and want to try it,\ncome back to me.");
        textManager.append("");
        textManager.append("");
        //beans-chonk 1 then book (player is in puzzle)
        //textManager.append("I'll remind you what the riddle is. Of course, you can try to\nanswer after that.");
        textManager.append("To remind yourself of what the riddle is, click on the moon.\nNow try to answer it. If nothing happens after you\norder all gods, click the 'Reset' button.");
        textManager.append("");
        textManager.append("");
        textManager.append("");
        textManager.append("");
        textManager.append("");
        //beans-chonk 4 then telescope piece spawn (dead)
        textManager.append("We got the code!");
        textManager.append("Well done! Here you go, you deserve this piece!");
        textManager.append("Thanks Chonk. Okay, player, let's go look for another piece. Where could it be though?");
        textManager.append("You could try looking in the brewery room. You should know where it is.");
        textManager.append("");
        textManager.append("");
        //beans-bat 5 
        textManager.append("Who are you? Why are you here? Have you seen pieces of a\ntelescope laying around anywhere?");
        textManager.append("Hello there! No worries! I am here because the tower asked\nme to, I can give you a potion that will\nallow you to find a part of your telescope.\nOnce you find the ingredients, the piece will be revealed.");
        textManager.append("And what might the recipe for that be?");
        textManager.append("The recipe is: Milk, cat hair, leaves, tuna, and another potion.\nHowever, I've lost the ingredients, so could you find them\nfor me? I'm sure they're all in this room. Also, try looking in\nyour bedroom. Maybe the last part wasn't the tower's doing.");
        textManager.append("Okay, player, could you help me out? Find the different\ningredients in the room.");
        textManager.append("");
        //beans-bat 1 then screen (player is in puzzle) (dead)
        textManager.append("You've got all the ingredients? If that's the case, you can hand\nthem to me now and I'll spawn that piece. Otherwise\n try to find the rest of them.");
        textManager.append("");
        textManager.append("");
        textManager.append("");
        textManager.append("");
        textManager.append("");
        //beans-bat 3 then telescope piece spawn (dead)
        textManager.append("There you go! That's a nice potion! Well, you deserve this piece now. Good luck finding the last one! :D");
        textManager.append("Thanks, that's another part collected! Well done player! Where do we go now though?");
        textManager.append("Have you tried looking in your bedroom? Maybe the last part wasn't the tower's doing.");
        textManager.append("");
        textManager.append("");
        textManager.append("");
        //beans re-init 2 (before chest)
        textManager.append("The bat has a point, I recently cleaned up my room a little\nbit and stuffed a lot of things into that chest over there.");
        textManager.append("However, I forgot how to solve the puzzle to open the chest.\nThere should be a scroll with clues somewhere around\nhere. Could you help me out again, player?");
        textManager.append("");
        textManager.append("");
        textManager.append("");
        textManager.append("");
        //beans re-init 1 (after chest) then telescope piece (and telescope) spawn
        textManager.append("Well done! Maybe I could finally assemble my telescope again to look at the moon!");
        textManager.append("");
        textManager.append("");
        textManager.append("");
        textManager.append("");
        textManager.append("");
        currentText = textManager.get(0);
        currentImage = beans;
    }
    
    void handleMousePressed() {
      counter++;
      currentText = textManager.get( min(counter + characterCounter, 53) );    // min is failsafe just to avoid crashes, not intended thing anyway
      if( currentText.length() == 0) {
        isVisible = false;
      }
      if( counter + characterCounter == 44 ) {
        counter = 0;
        characterCounter = 52;
      }
      
      if( counter + characterCounter < 5 ) currentImage = beans;
      else if ( counter + characterCounter >= 5 && counter + characterCounter <= 10 && ( counter + characterCounter ) % 2 == 0 ) currentImage = beans_hamsterdark;
      else if ( counter + characterCounter >= 5 && counter + characterCounter <= 10 && ( counter + characterCounter ) % 2 == 1 ) currentImage = beansdark_hamster;
      else if ( counter + characterCounter == 12 ) currentImage = beansdark_hamster;
      else if ( counter + characterCounter >= 23 && counter + characterCounter <= 29 && ( counter + characterCounter ) % 2 == 0 ) currentImage = beans_batdark;
      else if ( counter + characterCounter >= 23 && counter + characterCounter <= 29 && ( counter + characterCounter ) % 2 == 1 ) currentImage = beansdark_bat;
      else if( counter + characterCounter > 39 ) currentImage = beans;
    }
    
    void display() {

      currentImage.display();
      super.display();
      textFont( mainFont );
      fill( 255, 255, 255 );
      text( currentText, 190, 790 );    // (140, 720) + (50, 70)
    }   
}
