import interfascia.*;


/*
To represent a clickable Mole that contains a message
 to be displayed once the Mole has been successfully clicked. 
 */

class Pokemon {
  // The message to be displayed after being clicked.
  private Message content;

  private String imgName;

  public Pokemon(Message content, String imgName) {
    checkFields(content, imgName);

    this.content = content;
    this.imgName = imgName;
  }

  /* Ensures that content and imgName are not null, and that the imgName is properly
   formatted. */
  private void checkFields(Message content, String imgName) {
    if (content == null || imgName == null) {
      throw new IllegalArgumentException("Message content or image name cannot be null.");
    }

    if  (!imgName.contains(".png") && !imgName.contains(".jpg")) {
      throw new IllegalArgumentException("File name must be of the format "
        + "<filename>.png or <filename>.jpg -- Invalid "
        + "file name: " + imgName);
    }
  }

  public Message getContent() {
    return content;
  }

  public String getImgName() {
    return imgName;
  }
  
  public String toString() {
   return imgName; 
  }
}