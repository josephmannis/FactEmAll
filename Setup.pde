// Sets up a new instance of factemall
void init() {
  controller = new GUIController(this);
  loadImages();
  initPokes();
  initGameArray();
  initCaughtArray();
  initSlotLocations();
  initCaughtLocations();
  initDependantConstants();
  rectMode(CENTER);
  ellipseMode(CENTER);
  currMode = new PokeGame();
}

// Loads all image assets
void loadImages() {
  factEmAllText = loadImage(uiPath + "factemall.png"); 
  madeWithLove = loadImage(uiPath + "madewithlove.png");
  helpButton = loadImage(uiPath + "help.png");
  backgroundImage = loadImage(uiPath + "scenet.png");
  pokeTray = loadImage(uiPath + "poketray.png");
  pokeball = loadImage(uiPath + "pokeball.png");
  openPokeball = loadImage(uiPath + "openpokeball.png");
  pixelMaster = loadFont("PixelMaster-48.vlw");
  messageBackground = loadImage(uiPath + "textbox.png");
}

/* Determines if the number of sprites for the moles and the number of 
 messages for the moles is equivalent. */
void checkValidSprites() {
  Integer f = facts.size();
  Integer s = sprites.size();
  if (f != s) {
    throw new IllegalArgumentException("Must have the same number of sprites and messages. Number of facts: " + f + " Number of sprites: " + s);
  }
}

// Initializes all the moles to be used in the game with the proper message and sprite.
void initPokes() {
  checkValidSprites();
  ArrayList<Pokemon> pokes = new ArrayList<Pokemon>();
  for (int i = 0; i < sprites.size(); i++) {
    String pokeName = formatPokename(i);

    Message m = new Message(
      pokeName, 
      facts.get(i), 
      DEFAULT_MESSAGE_POSITION);

    Pokemon temp = new Pokemon(m, sprites.get(i));

    pokes.add(temp);
  }

  allPokes = pokes;
}

private String formatPokename(int accessor) {
  String rawName = sprites.get(accessor);
  String captialize = rawName.substring(0, 1).toUpperCase() + rawName.substring(1);
  String removeFile = captialize.replace(".png", "!\n\n");

  return DEFAULT_MESSAGE_TITLE + removeFile;
}

// Initializes the game array for PokeGame
void initGameArray() {
  for (int y = 0; y < 2; y++) {
    for (int x = 0; x < 5; x++) {
      field[y][x] = new PokeSlot(x, y);
    }
  }
}

// Initializes the array of caught pokemon
void initCaughtArray() {
  for (int i = 0; i < 10; i++) {
    caughtPokes[i] = new CaughtSlot(i);
  }
}

// Sets the correct coordinates for drawing the PokeSlots based on their location in the array
void initSlotLocations() {
  slotLocations.put(new PVector(0, 0), new PVector(501, 166));
  slotLocations.put(new PVector(1, 0), new PVector(699, 166));
  slotLocations.put(new PVector(2, 0), new PVector(897, 166));

  slotLocations.put(new PVector(3, 0), new PVector(361, 383));
  slotLocations.put(new PVector(4, 0), new PVector(585, 383));
  slotLocations.put(new PVector(0, 1), new PVector(810, 383));
  slotLocations.put(new PVector(1, 1), new PVector(1035, 383));

  slotLocations.put(new PVector(2, 1), new PVector(501, 601));
  slotLocations.put(new PVector(3, 1), new PVector(699, 601));
  slotLocations.put(new PVector(4, 1), new PVector(897, 601));
}

// Sets the correct coordinates for drawing the CaughtSlots based on their location in the array
void initCaughtLocations() {
  caughtLocations.put(0, new PVector(1306, 110));
  caughtLocations.put(1, new PVector(1306, 170));
  caughtLocations.put(2, new PVector(1306, 228));

  caughtLocations.put(3, new PVector(1306, 288));
  caughtLocations.put(4, new PVector(1306, 347));
  caughtLocations.put(5, new PVector(1306, 406));
  caughtLocations.put(6, new PVector(1306, 465));

  caughtLocations.put(7, new PVector(1306, 525));
  caughtLocations.put(8, new PVector(1306, 584));
  caughtLocations.put(9, new PVector(1306, 643));
}

// Initializes any constants dependent on assets
void initDependantConstants() {
  BOUNDING_TEXT_BOX_WIDTH = messageBackground.width - 100;
  BOUNDING_TEXT_BOX_HEIGHT = messageBackground.height - 100;
}