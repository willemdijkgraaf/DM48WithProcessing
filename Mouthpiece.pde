class MouthPiece {
  int[] _holes = new int[12];
  int _x,_y,_w,_h;
  boolean _isBlowing;
  
  MouthPiece(int x, int y, int w, int h) {
    _x = x;
    _y = y;
    _w = w;
    _h = h;
  }
  Slide _slide = new Slide(100, 200, 30);

  void setBreathForce(int hole, int force) {
    _holes[hole] = force;
  }
  
  void setBlowOrDraw (int pitch) {
      // 0, 1 = blow
      // 2, 3 = draw
      int holePitch = pitch%4;
      _isBlowing = holePitch < 2;
  }
  
  boolean isBlowing() {
    return _isBlowing;
  }
  
  boolean isDrawing() {
    return !_isBlowing;
  }
  
  // in monophonic playing mode, this method return the hole with highest breath force
  int getCurrentHole() {
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
  
  Slide slide() {
    return _slide;
  }
  
  void update() {
    // blow or draw
    updateBlowOrDraw();
      _slide.update();
    
    // mouthpiece
    int gap = 10;
    int w = (_w - (11 * gap)) / 12;
    
    int currentHole = getCurrentHole();
    
    for (int hole = 0; hole < 12; hole = hole + 1) {
      // draw holes
      int x = _x + (hole * w) + (hole * gap);
      fill(50);
      rect(x, _y, w, _h);
      
      // draw breath force
      int breathForce = (int)(((float)_h / 128) * (float)_holes[hole]);
      if (hole == currentHole) {fill(100);} else {fill(75);} // paint selected hole brighter than others
      
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