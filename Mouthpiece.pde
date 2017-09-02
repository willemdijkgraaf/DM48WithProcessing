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
  
  void update() {
    // blow or draw
    updateBlowOrDraw();
    
    
    // mouthpiece
    int gap = 10;
    int w = (_w - (11 * gap)) / 12;
    
    for (int hole = 0; hole < 12; hole = hole + 1) {
      int x = _x + (hole * w) + (hole * gap);
      fill(50);
      rect(x, _y, w, _h);
      
      int breathForce = (int)(((float)_h / 128) * (float)_holes[hole]);
      fill(100);
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