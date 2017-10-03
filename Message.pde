// Represents a message to be displayed to the user
class Message {

  String title; 

  String body; 

  PVector loc;

  boolean visible;

  Message(String title, String body, PVector loc) {
    if (title == null || body == null) {
      throw new IllegalArgumentException("Message must have valid title and content.");
    }

    if (loc == null) {
      throw new IllegalArgumentException("Invalid location.");
    }

    this.title = title + "\n";
    this.body = body;
    this.loc = loc;
    this.visible = false;
  }

  // Skeleton constructor for new game
  Message() {
    this.visible = false;
  }

  // Display message
  public void displayMessage() {
    pushStyle();
    rect(loc.x, loc.y, BOUNDING_TEXT_BOX_WIDTH, BOUNDING_TEXT_BOX_HEIGHT);

    image(messageBackground, loc.x - 300, loc.y - 200);

    fill(50);
    textAlign(CENTER, CENTER);
    textFont(pixelMaster, scaleFontSize());
    text(toString(), loc.x, loc.y, BOUNDING_TEXT_BOX_WIDTH, BOUNDING_TEXT_BOX_HEIGHT);

    popStyle();
  }

  private float scaleFontSize() {
    /* Source:
     https://forum.processing.org/two/discussion/13105/
     how-to-make-a-string-of-any-length-fit-within-text-box
     */

    String[] words = toString().split(" ");
    float currentSize = 5;
    float bestSize = 5;
    float sizeIncrement = 0.25;

    boolean searching = true;  
    while (searching) {
      if (testFontSize(currentSize, words)) {
        bestSize = currentSize;
        currentSize += sizeIncrement;
      } else {
        searching = false;
      }
    }

println(bestSize);
    return bestSize;
  }

 private boolean testFontSize(float s, String[] words) {
   pushStyle();
    textSize(s);
    // calculate max lines
    int currentLine = 1;
    int maxLines = floor((BOUNDING_TEXT_BOX_HEIGHT -100) / (g.textLeading + numCarriageReturns()));
    boolean fitHeight = true;
    int nextWord = 0;

    while (fitHeight) {
      if (currentLine > maxLines) {
        fitHeight = false;
      } else {
        String temp = words[nextWord];
        // check if single word is already too wide
        if (textWidth(temp)> BOUNDING_TEXT_BOX_WIDTH)
          return false;

        boolean fitWidth = true;
        // add words until string is too wide  
        while (fitWidth) {

          if (textWidth(temp) > BOUNDING_TEXT_BOX_WIDTH) {
            currentLine++;
            fitWidth = false;
          } else {
            if (nextWord < words.length -1) {
              nextWord++;
              temp += " "+words[nextWord];
            } else
              return true;
          }
        }
      }
    }
    popStyle();
    return false;
    

  } 

  private int numCarriageReturns() {
    String l = this.toString();
    int lines = 0;
    int pos = 0;
    while ((pos = l.indexOf("\n", pos) + 1) != 0) {
      lines++;
    }

    return lines;
  }

  public boolean isVisible() {
    return visible;
  }

  public void setVisibility(boolean set) {
    this.visible = set;
  }

  public String toString() {
    return title + body;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public void setBody(String body) {
    this.body = body;
  }
}