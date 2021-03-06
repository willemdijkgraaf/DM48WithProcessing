import java.util.Observable;

public class Slide extends Observable {
  private int _x, _y, _h;
  private boolean _isSlideIn = false;
  private int _position = 8192;
  private float _slideRatio;
  private final float _minimum = 2731;
  private final float _maximum = 5461;
    
  Slide(int x, int y, int h){
    _x = x;
    _y = y;
    _h = h;
  }
  
  void setPosition (int position) {
    _position = position;
    _slideRatio = 1 - ((float)position - _minimum) / _maximum;
    if (_slideRatio < 0.5) {_isSlideIn = false;}
    if (_slideRatio > 0.5) {
      _isSlideIn = true;
      _slideRatio = Math.abs((-1 + _slideRatio));  
    }    
    setChanged();
    notifyObservers();
  }
  
  float slideRatio(){ return _slideRatio; }
  boolean isSlideIn() {return _isSlideIn;}
  
  void draw(){
    int pitchbendPerPixel = 13653/400;
    //ellipse(_position/pitchbendPerPixel, _y, _w,_w);
    
    int fill = 50;
    if (_isSlideIn) {fill = 150;}
    fill(fill);
    rect(_x,_y, _position/pitchbendPerPixel,_h);
    fill(100);
    rect(_x + (8192 - 3000)/pitchbendPerPixel, _y - 10, 5, _h + 10);
  }
}