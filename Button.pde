/*
table of contents:
NoImageObject
ImageObject
TextButton
DigitButton(TextButton)
DialogBox(ImageObject)
*/

class NoImageObject {                  //object for attaching a different rect collision to oddly-shaped images
                                       //requires manual labor, do not use in industrial quantities :)
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
    }
    
    public void Trigger(StringList textCluster, PImage pMainImg) {
      if (textCounter != 0) textCounter = 0;
      isVisible = true;
      currentTextCluster = textCluster;
      currentText = currentTextCluster.get(0);
      mainImage = pMainImg;
      currentImage = mainImage;
    }
    
    public void Trigger(StringList textCluster, PImage pMainImg, PImage pSecImg) {
      if (textCounter != 0) textCounter = 0;
      isVisible = true;
      currentTextCluster = textCluster;
      currentText = currentTextCluster.get(0);
      mainImage = pMainImg;
      secImage = pSecImg;
      currentImage = mainImage;
    }
    
    void handleMousePressed() {
      textCounter++;
      
      // exit clause, now dependent on cluster size instead of empty string terminators
      if( textCounter >= currentTextCluster.size()) {
        isVisible = false;
      }
      else currentText = currentTextCluster.get(textCounter);
      
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
