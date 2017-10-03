/* * * * * * * * * * * * * * * * *  * 
* Programming Basics                *
* Joseph Annis                      *
* josephmackenzie.annis@gmail.com   *
* Click the pokeballs to catch the  *
* pokemon, and they'll tell you     *
* their secrets! (about me).        *
* * * * * * * * * * * * * * * * * * */

void setup() {
  size(1400, 800); 

  init();
  currMode.updateState();
}

void draw() {
  currMode.drawMode();
}

void mouseReleased() {
  currMode.onMouseReleased();
}

void keyPressed() {
  currMode.onKeyPressed(key);
}