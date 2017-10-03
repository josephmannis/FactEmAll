/* Represents a slot for a PokeBall. Each slot contains either contains
 a Pokemon, or it doesn't. When a Pokemon is contained during play,
 it may be clicked and the Pokemon may be caught.*/
class PokeSlot {
  // Determines whether this PokeSlot contains a Pokemon
  private boolean containsPokemon;

  // The location in the main array of PokeSlots for use with the field
  private PVector arrayLocation;

  // The Mole within this PokeSlot
  private Pokemon containedPokemon;

  public PokeSlot(int xLoc, int yLoc) {

    if (xLoc < 0 || xLoc > 5) {
      throw new IllegalArgumentException("The X coordinate of this Slot in the 2D array must be within the range 0 -> 5");
    }

    if (yLoc < 0 || yLoc > 2) {
      throw new IllegalArgumentException("The Y coordinate of this Slot in the 2D array must be within the range 0 -> 2");
    }

    this.containedPokemon = null;
    this.containsPokemon = false;
    this.arrayLocation = new PVector(xLoc, yLoc);
  }

  // sets the given Pokemon to this PokeSlot
  public void setContainedPokemon(Pokemon poke) {
    this.containedPokemon = poke;
    this.containsPokemon = true;
  }

  // Removes the containedPokemon from this PokeSlot. If there is no contained Pokemon, throws an error.
  public void removeContainedPokemon() {
    if (!containsPokemon()) {
      throw new IllegalArgumentException("There is no Pokemon to remove");
    }
    this.containedPokemon = null;
    this.containsPokemon = false;
  }

  // Returns the pokemon associated with this PokeSlot, if there is one
  public Pokemon getContainedPokemon() {
    if (this.containsPokemon()) {
      return this.containedPokemon;
    }
    throw new IllegalStateException("This Pokeslot contains no Pokemon.");
  }

  // Returns the arrayLocation of this PokeSlot
  public PVector getArrayLocation() {
    return arrayLocation;
  }

  // Draws the correct image for this PokeSlot
  public void drawSlot(PVector loc) {
    if (containsPokemon) {
      int pokeoffsetx = 40;
      int pokeoffsety = 10;
      int balloffsetx = 137 /2;
      int balloffsety = 209 / 2;
      PImage poke = loadImage(largeSpritePath + containedPokemon.getImgName());

      image(openPokeball, loc.x - balloffsetx, loc.y - balloffsety);
      image(poke, loc.x - pokeoffsetx, loc.y - pokeoffsety);
    } else {
      int balloffset = 137 / 2;

      image(pokeball, loc.x - balloffset, loc.y - balloffset);
    }
  }

  // Determines if this PokeSlot contains a pokemon
  public boolean containsPokemon() {
    return containsPokemon;
  }

  public String toString() {
    return "Contains Pokemon: " + containsPokemon + arrayLocation.toString();
  }

  public void performAction() {
    if (this.containsPokemon()) {
      Pokemon poke = this.getContainedPokemon();
      this.removeContainedPokemon();
      lastCaught.add(poke);
      currMessage = poke.getContent();
      currMessage.setVisibility(true);
      allPokes.remove(poke);
    }
  }

  public boolean isClicked(PVector mouseLoc) {
    int mX = (int) mouseLoc.x;
    int mY = (int) mouseLoc.y;
    int sX = (int) slotLocations.get(this.arrayLocation).x;
    int sY = (int) slotLocations.get(this.arrayLocation).y;

    return (mX >= sX - 137 && mX <= sX + 137) 
      && (mY >= sY - 137 && mY <= sY + 137);
  }

  public PVector getLoc() {
    return slotLocations.get(this.arrayLocation);
  }
}