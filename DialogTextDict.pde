public static class DialogTextDict {
   // declare lists with fitting names here
   public static StringList introText = new StringList(); 
   public static StringList chonkPuzzleInit = new StringList(); 
   public static StringList chonkPuzzleAfterBook = new StringList(); 
   public static StringList chonkPuzzleSolved = new StringList(); 
   public static StringList batPuzzleInit = new StringList(); 
   public static StringList batPuzzleCheckout = new StringList(); 
   public static StringList batPuzzleSolved = new StringList(); 
   public static StringList bedroomPuzzleInit = new StringList(); 
   public static StringList bedroomPuzzleSolved = new StringList(); 
   
   // append individual text entries to the lists here
   
   // TABLE OF CONTENTS (for preservation):
   //beans init 4 || first item 0 / previously sections subdivided - 5, 10, 12, 17, 22, 24, 28, 31 / now each section will be of length 6 
   //beans-chonk 4 then display puzzle book
   //beans-chonk 1 then book (player is in puzzle)
   //beans-chonk 4 then telescope piece spawn (dead)
   //beans-bat 5 
   //beans-bat 1 then screen (player is in puzzle) (dead)
   //beans-bat 3 then telescope piece spawn (dead)
   //beans re-init 2 (before chest)
   //beans re-init 1 (after chest) then telescope piece (and telescope) spawn

   DialogTextDict() {
      introText.append("Hello! My name is Beans the cat, and I live in this tower. The place \nyou're standing in right now is my bedroom. I had a telescope in\nhere and I wanted to use it tonight to observe the annual\nfull moon. However, it's broken and I need your help to fix it.");
      introText.append("There are 3 pieces hidden somewhere in this tower and I need\nyour help to find them. My tower has a mind of its own and likes\nto mess around with me, so there is probably a twist to getting\nthe parts back. Please help me find them! We'll be a great team!");
      introText.append("Let's see... where might the parts be? Let's check the\nlibrary room first. Those books might be helpful if I read\nthem after all.");
      introText.append("Oh, by the way, feel free to see what we have collected\nwith the 'I' button. You can press 'I' again to\nhide that out of view.");
      
      chonkPuzzleInit.append("Let me guess, you're here because the tower wanted you\nto be?");
      chonkPuzzleInit.append("How did you know?");
      chonkPuzzleInit.append("Just a guess. So I guess I'll have to solve a riddle to get a part\nof my telescope back?");
      chonkPuzzleInit.append("Exactly. I'm too lazy to actually tell you the riddle, so have this\nbook. The riddle is in there and it tells you what to do.\nOnce you have an answer and want to try it,\ncome back to me.");
      
      //chonkPuzzleAfterBook.append("I'll remind you what the riddle is. Of course, you can try to\nanswer after that.");
      chonkPuzzleAfterBook.append("To remind yourself of what the riddle is, click on the moon.\nNow try to answer it. If nothing happens after you\norder all gods, click the 'Reset' button.");
      
      chonkPuzzleSolved.append("We got the code!");
      chonkPuzzleSolved.append("Well done! Here you go, you deserve this piece!");
      chonkPuzzleSolved.append("Thanks Chonk. Okay, player, let's go look for another piece. Where could it be though?");
      chonkPuzzleSolved.append("You could try looking in the brewery room. You should know where it is.");
      
      batPuzzleInit.append("Who are you? Why are you here? Have you seen pieces of a\ntelescope laying around anywhere?");
      batPuzzleInit.append("Hello there! No worries! I am here because the tower asked\nme to, I can give you a potion that will\nallow you to find a part of your telescope.\nOnce you find the ingredients, the piece will be revealed.");
      batPuzzleInit.append("And what might the recipe for that be?");
      batPuzzleInit.append("The recipe is: Milk, cat hair, leaves, tuna, and another potion.\nHowever, I've lost the ingredients, so could you find them\nfor me? I'm sure they're all in this room. Also, try looking in\nyour bedroom. Maybe the last part wasn't the tower's doing.");
      batPuzzleInit.append("Okay, player, could you help me out? Find the different\ningredients in the room.");
      
      batPuzzleCheckout.append("You've got all the ingredients? If that's the case, you can hand\nthem to me now and I'll spawn that piece. Otherwise\n try to find the rest of them.");
      
      batPuzzleSolved.append("There you go! That's a nice potion! Well, you deserve this piece now. Good luck finding the last one! :D");
      batPuzzleSolved.append("Thanks, that's another part collected! Well done player! Where do we go now though?");
      batPuzzleSolved.append("Have you tried looking in your bedroom? Maybe the last part wasn't the tower's doing.");
      
      bedroomPuzzleInit.append("The bat has a point, I recently cleaned up my room a little\nbit and stuffed a lot of things into that chest over there.");
      bedroomPuzzleInit.append("However, I forgot how to solve the puzzle to open the chest.\nThere should be a scroll with clues somewhere around\nhere. Could you help me out again, player?");
      
      bedroomPuzzleSolved.append("Well done! Maybe I could finally assemble my telescope again to look at the moon!");
   }
}
