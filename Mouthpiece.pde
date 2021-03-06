import java.util.Observable;
import java.util.Observer;

class MouthPiece extends Observable  {
  private int[] _holes = new int[12];
  private int _x,_y,_w,_h;
  private boolean _isBlowing; // true if blowing, false if drawing
  private boolean _isPlaying; // true if air pressure detected
  private int _currentHole;
  
  MouthPiece(int x, int y, int w, int h) {
    _x = x;
    _y = y;
    _w = w;
    _h = h;
  }
   
  void setBreathForce(int hole, int force) {
    boolean isPlaying = true;
    boolean isCurrentHoleChanged = false;
    
    _holes[hole] = force;
    if (_holes[0] == 0 && 
        _holes[1] == 0 && 
        _holes[2] == 0 && 
        _holes[3] == 0 && 
        _holes[4] == 0 && 
        _holes[5] == 0 && 
        _holes[6] == 0 && 
        _holes[7] == 0 && 
        _holes[8] == 0 && 
        _holes[9] == 0 && 
        _holes[10] == 0 && 
        _holes[11] == 0 ) {
      isPlaying = false;
    }
    
    if (isPlaying) { 
      int currentHole = getCurrentHole();
      isCurrentHoleChanged = currentHole != _currentHole;
      _currentHole = currentHole;
    }
    
    if (_isPlaying != isPlaying || isCurrentHoleChanged) {
      _isPlaying = isPlaying;
      
      setChanged();
      notifyObservers();
    }
  }
  
  void setBlowOrDraw (int pitch) {
    boolean oldIsBlowing = _isBlowing;
    
    // 0, 1 = blow
    // 2, 3 = draw
    int holePitch = pitch%4;
    _isBlowing = holePitch < 2;
      
    // if blow direction changed, shall trigger new note
    if (  _isBlowing != oldIsBlowing) {
      // raise note changed event
      setChanged();
      notifyObservers();
    }
  }
  
  boolean isBlowing() {
    return _isBlowing;
  }
  
  boolean isDrawing() {
    return !_isBlowing;
  }
  
  boolean isPlaying() {
    return _isPlaying;
  }
  
  public int currentHole(){
    return _currentHole;
  }
  // in monophonic playing mode, this method return the hole with highest breath force
  private int getCurrentHole() {
    int selectedHole = -1;
    int highestBreathForce = -1;
    for (int hole = 0; hole < 12; hole = hole + 1){
      int breathForce = _holes[hole];
      if ( breathForce > 0 && breathForce > highestBreathForce ) {
        selectedHole = hole;
        highestBreathForce = breathForce;
      }
    }
    return selectedHole;   
  }
  
  void draw() {
    // blow or draw
    updateBlowOrDraw();
    
    // mouthpiece
    int gap = 10;
    int w = (_w - (11 * gap)) / 12;
    
    for (int hole = 0; hole < 12; hole = hole + 1) {
      // draw holes
      int x = _x + (hole * w) + (hole * gap);
      fill(50);
      rect(x, _y, w, _h);
      
      // draw breath force
      int breathForce = (int)(((float)_h / 128) * (float)_holes[hole]);
      if (hole == _currentHole) {fill(100);} else {fill(75);} // paint selected hole brighter than others
      
      rect(x, _y + _h, w, -breathForce);
    }
  }
  
  void updateBlowOrDraw() {
    int y = _y + 150;
    int x = _x + 50;
    if (_isBlowing) {
      triangle(x, y, x + 20, y, x + 10, y - 20);
    } else {
      triangle(x, y, x + 20, y, x + 10, y + 20);
    }  
  }
}