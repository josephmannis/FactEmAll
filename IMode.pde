/*
Represents a mode of the interface. Each mode will have a unique
 drawing method,
 */
interface IMode {  
  // The drawing procedure for this IMode
  void drawMode();
  
  // Updates the state of play for this IMode
  void updateState();

  // The GUI action handling procedure for this IMode
  void onMouseReleased();
  
  // The key procedure for this IMode
  void onKeyPressed(int key);
}