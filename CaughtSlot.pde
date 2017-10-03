// 

class CaughtSlot {
  // Determines whether this PokeSlot contains a Pokemon
  private boolean containsPokemon;

  // The Mole within this PokeSlot
  private Pokemon containedPokemon;

  // This CaughtSlot's location in the array
  private int arrayLoc;

  public CaughtSlot(int arrayLoc) {
    if (arrayLoc < 0 || arrayLoc > 9) {
      throw new IllegalArgumentException("Invalid array location.");
    }
    this.arrayLoc = arrayLoc;
    this.containsPokemon = false;
    this.containedPokemon = null;
  }

  // sets the given Pokemon to this PokeSlot
  public void setContainedPokemon(Pokemon poke) {
    this.containedPokemon = poke;
    this.containsPokemon = true;
  }

  // Returns the pokemon associated with this PokeSlot, if there is one
  public Pokemon getContainedPokemon() {
    if (this.containsPokemon()) {
      return this.containedPokemon;
    }
    throw new IllegalStateException("This Pokeslot contains no Pokemon.");
  }

  public int getArrayLocation() {
    return arrayLoc;
  }

  // Draws the correct image for this PokeSlot
  public void drawSlot(PVector loc) {
    if (containsPokemon()) {
      int pokeoffsetx = 20;
      int pokeoffsety = 0;

      PImage poke = loadImage(smallSpritePath + getContainedPokemon().getImgName());
      image(poke, loc.x - pokeoffsetx, loc.y + pokeoffsety);
    }
  }

  public void performAction() {
    if (containsPokemon) {
      Message curr = containedPokemon.getContent();
      curr.setTitle("");
      currMessage = containedPokemon.getContent();
      currMessage.setVisibility(true);
    }
  }

  public boolean isClicked(PVector mouseLoc) {
    int mX = (int) mouseLoc.x;
    int mY = (int) mouseLoc.y;
    int sX = (int) caughtLocations.get(this.arrayLoc).x;
    int sY = (int) caughtLocations.get(this.arrayLoc).y;
    int offsetx = 20;
    int offsety = 40;

    return (mX >= sX - offsetx && mX <= sX + offsetx) 
      && (mY >= sY - 20 && mY <= sY + offsety);
  }

  // Determines if this PokeSlot contains a pokemon
  public boolean containsPokemon() {
    return containsPokemon;
  }
}