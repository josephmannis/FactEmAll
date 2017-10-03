import java.util.Collections;
import java.util.Random;

/*
Represents the actual game of FactAMole. Moles will appear randomly, and the user may click
 on the mole to knock it. Once a mole has been successfully knocked, it will display its fact
 and become deprecated. Moles that are deprecated will be displayed on the top of the intercace,
 and may be clicked again at any time to display their fact. As the number of moles decreases, 
 the speed at which the appear and dissppear will increase. Once all the moles are deprecated, 
 the player will be presented with the option to play again, or view all of the moles. 
 */

class PokeGame implements IMode {
  // Base time for automatically updating the field
  long baseTime = System.currentTimeMillis();

  // Consistently updated time checker for comparison with base time
  long timeChecker = System.currentTimeMillis();

  public PokeGame() {
  }

  // The drawing procedure for this IMode
  public void drawMode() {
    background(backgroundImage);
    image(madeWithLove, 10, 775);
    image(factEmAllText, 10, 10);
    image(helpButton, HELP_BUTTON_X, HELP_BUTTON_Y);

    renderPokeSlots();
    image(pokeTray, 1207, (height - 651) / 2);
    renderCaughtSlots();
    renderMessage();
    updateSystemTime();
  }

  // Renders the PokeSlots
  private void renderPokeSlots() {
    for (int y = 0; y < 2; y++) {
      for (int x = 0; x < 5; x++) {
        PVector shapeLoc = slotLocations.get(new PVector(x, y));
        field[y][x].drawSlot(shapeLoc);
      }
    }
  }

  // Renders the CaughtSlots
  private void renderCaughtSlots() {
    for (int i = 0; i < 10; i++) {
      PVector caughtLoc = caughtLocations.get(i);
      caughtPokes[i].drawSlot(caughtLoc);
    }
  }

  // Renders the current message, if it is to be displayed
  private void renderMessage() {
    if (currMessage.isVisible()) {
      currMessage.displayMessage();
    }
  }

  // Plays the game
  public void updateState() {
    if (!currMessage.isVisible()) {
      Random rand = new Random();
      ArrayList<Integer> range = generateRange();

      clearField();

      // Select three random pokemon and add them to random points in the array
      for (int j = 0; j < Math.round(allPokes.size() * .5); j++) {
        int rY = rand.nextInt(2);
        int rX = rand.nextInt(5);

        field[rY][rX].setContainedPokemon(allPokes.get(range.get(j)));
      }

      // Store the last Pokemon caught, if any
      storeLast();

      redraw();
    }
  }

  // Generates an array of random numbers in the range of 0 to the number of available Pokemon
  private ArrayList<Integer> generateRange() {
    ArrayList<Integer> range = new ArrayList<Integer>();    
    // Generate available pokemon slots
    for (int i = 0; i < allPokes.size(); i++) {
      range.add(i);
    }
    // Shuffle for randomness
    Collections.shuffle(range);

    return range;
  }

  // Clears all Pokemon from the field
  private void clearField() {
    for (int y = 0; y < 2; y++) {
      for (int x = 0; x < 5; x++) {
        PokeSlot temp = field[y][x];
        if (temp.containsPokemon()) {
          temp.removeContainedPokemon();
        }
      }
    }
  }

  // Stores the last caught pokemon in the caught array
  private void storeLast() {
    while (!lastCaught.isEmpty()) {
      for (int i = 0; i < 10; i++) {
        CaughtSlot temp = caughtPokes[i];
        if (!temp.containsPokemon) {
          temp.setContainedPokemon(lastCaught.get(0));
          lastCaught.remove(0);
          break;
        }
      }
    }
  }

  // The key handling procedure for this IMode
  public void onMouseReleased() {
    if (!currMessage.isVisible()) {
      PVector lastLoc = new PVector(pmouseX, pmouseY);
      checkPokeSlots(lastLoc);
      checkCaughtSlots(lastLoc);
      checkHelpButton(lastLoc);
    } else {
      currMessage.setVisibility(false);
    }
  }

  // Determines if a PokeSlot was clicked and performs the respective action
  void checkPokeSlots(PVector lastLoc) {
    for (int y = 0; y < 2; y++) {
      for (int x = 0; x < 5; x++) {
        PokeSlot temp = field[y][x];
        if (temp.isClicked(lastLoc)) {
          temp.performAction();
          updateState();
          redraw();
          break;
        }
      }
    }
  }

  // Determines if a CaughtSlot was clicked and performs the respective action
  void checkCaughtSlots(PVector lastLoc) {
    for (int i = 0; i < 10; i++) {
      CaughtSlot temp = caughtPokes[i];
      if (temp.isClicked(lastLoc)) {
        temp.performAction();
        updateState();
        redraw();
        break;
      }
    }
  }

  // Determines if the help button has been pressed.
  void checkHelpButton(PVector lastLoc) {
    if (lastLoc.x >= HELP_BUTTON_X - 20
      && lastLoc.x <= HELP_BUTTON_X  + 20
      && lastLoc.y >= HELP_BUTTON_Y - 20
      && lastLoc.y <= HELP_BUTTON_Y + 20) {

      currMessage = new Message(helpTitle, helpBody, DEFAULT_MESSAGE_POSITION);
      currMessage.setVisibility(true);
    }
  }
  // Keeps track of when the field should be automatically updated
  void updateSystemTime() {
    timeChecker = System.currentTimeMillis();
    if (timeChecker - baseTime >= (500 * Math.round(allPokes.size() * .5))) {
      baseTime = timeChecker;
      updateState();
    }
  }

  void onKeyPressed(int key) {
    if (key == 'r' || key == 'R') {
      setup();
    }
  }
}