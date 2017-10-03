import java.util.Arrays;

int WIDTH = 1400;
int HEIGHT = 800;

// The list of facts contained my each mole
static ArrayList<String> facts = new ArrayList<String>(
  Arrays.asList(
  "Spinach quiche is one of my favorite foods.",
  "Yankee candles are my passion.",
  "I believe Purell feeds on fear.",
  "I hate eggplant.",
  "I like to skateboard.",
  "I'm making this at 11:13 PM.",
  "I think Jose is a pretty cool guy.",
  "I really hope I get all my homework done.",
  "I like apples.",
  "I'm tired a lot."));

static ArrayList<String> sprites = new ArrayList<String>(
  Arrays.asList("pikachu.png", "charmander.png", "chikorita.png", "jigglypuff.png", 
  "jolteon.png", "riolu.png", "snorlax.png", "spinda.png", "squirtle.png", "totodile.png"));

// All moles within the game
ArrayList<Pokemon> allPokes;

// Moles that have been previously clicked
ArrayList<Pokemon> hitPokes = new ArrayList<Pokemon>();

// The field
PokeSlot[][] field = new PokeSlot[2][5];

// The array of collected pokemon
CaughtSlot[] caughtPokes = new CaughtSlot[10];

// The controller for the GUI
GUIController controller; 

// The current IMode
IMode currMode;

// The path to the Large sprite directory
static String largeSpritePath = "./assets/wholesprites/";

// The path to the icons
static String smallSpritePath = "./assets/minisprites/";

// The path to the UI Assets
static String uiPath = "./assets/ui/";

// Contains instructions for drawing PokeSLots based on their location in the field
HashMap<PVector, PVector> slotLocations = new HashMap<PVector, PVector>();

// Contains instructions for drawing CaughtSlots based on their position in the array
HashMap<Integer, PVector> caughtLocations = new HashMap<Integer, PVector>();

// The last caught Pokemon
ArrayList<Pokemon> lastCaught = new ArrayList<Pokemon>();

// The message currently being displayed
Message currMessage = new Message();

PVector DEFAULT_MESSAGE_POSITION = new PVector(WIDTH/2, HEIGHT/2);
String DEFAULT_MESSAGE_TITLE = "You've caught a ";

int HELP_BUTTON_X = 1285;
int HELP_BUTTON_Y = 725;
int BOUNDING_TEXT_BOX_WIDTH;
int BOUNDING_TEXT_BOX_HEIGHT;


String helpTitle = "How to play: ";
String helpBody = "Catch the Pokemon when they're available by clicking on them!"
+ "\nThey'll let you know a fact. Click any Pokemon you've previously caught to review the fact.\n"
+ "Click anywhere to close a dialogue box, and press 'r' to reset at any time.";