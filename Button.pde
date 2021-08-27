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
      audio.PlaySFX("Lock_number_Switch.mp3");
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
    int textCounter = 0;
    String currentText;
    PImage currentImage;
    PImage mainImage;
    PImage secImage;
    
    StringList currentTextCluster;
    
    DialogBox( String imageFilename, int newX, int newY ) {
        super( imageFilename, newX, newY );
        
        //beans init 4 || first item 0 / previously sections subdivided - 5, 10, 12, 17, 22, 24, 28, 31 / now each section will be of length 6 
        
        //beans-chonk 4 then display puzzle book
        
        //beans-chonk 1 then book (player is in puzzle)
        
        //beans-chonk 4 then telescope piece spawn (dead)
        
        //beans-bat 5 
        
        //beans-bat 1 then screen (player is in puzzle) (dead)
        
        /**textManager.append("");
        textManager.append("");
        textManager.append("");
        textManager.append("");
        textManager.append("");
        **/
        //beans-bat 3 then telescope piece spawn (dead)
        
        /**textManager.append("");
        textManager.append("");
        textManager.append("");
        **/
        //beans re-init 2 (before chest)
        
        /**textManager.append("");
        textManager.append("");
        textManager.append("");
        textManager.append("");
        **/
        //beans re-init 1 (after chest) then telescope piece (and telescope) spawn
        
        /**textManager.append("");
        textManager.append("");
        textManager.append("");
        textManager.append("");
        textManager.append("");
        **/
    }
    
    public void Trigger(StringList textCluster, PImage pMainImg) {
      isVisible = true;
      currentTextCluster = textCluster;
      currentText = currentTextCluster.get(0);
      mainImage = pMainImg;
      currentImage = mainImage;
    }
    
    public void Trigger(StringList textCluster, PImage pMainImg, PImage pSecImg) {
      isVisible = true;
      currentTextCluster = textCluster;
      currentText = currentTextCluster.get(0);
      mainImage = pMainImg;
      secImage = pSecImg;
      currentImage = mainImage;
    }
    
    void handleMousePressed() {
      textCounter++;
      println(currentTextCluster);
      currentText = currentTextCluster.get(textCounter);
      if( currentText.length() == 0) {
        isVisible = false;
      }
      if( counter + characterCounter == 44 ) {
        counter = 0;
        characterCounter = 52;
      }
      
      /**if( counter + characterCounter < 5 ) currentImage = beans;
      else if ( counter + characterCounter >= 5 && counter + characterCounter <= 10 && ( counter + characterCounter ) % 2 == 0 ) currentImage = beans_hamsterdark;
      else if ( counter + characterCounter >= 5 && counter + characterCounter <= 10 && ( counter + characterCounter ) % 2 == 1 ) currentImage = beansdark_hamster;
      else if ( counter + characterCounter == 12 ) currentImage = beansdark_hamster;
      else if ( counter + characterCounter >= 23 && counter + characterCounter <= 29 && ( counter + characterCounter ) % 2 == 0 ) currentImage = beans_batdark;
      else if ( counter + characterCounter >= 23 && counter + characterCounter <= 29 && ( counter + characterCounter ) % 2 == 1 ) currentImage = beansdark_bat;
      else if( counter + characterCounter > 39 ) currentImage = beans;
      **/
      
      if (secImage != null) {
        if (textCounter % 2 == 0) 
        {
          currentImage = mainImage;
        }
        
        else 
        {
          currentImage = secImage;
        }
      }
    }
    
    void display() {

      image(currentImage, 0, 0);
      super.display();
      textFont( mainFont );
      fill( 255, 255, 255 );
      text( currentText, 190, 790 );    // (140, 720) + (50, 70)
    }   
}
