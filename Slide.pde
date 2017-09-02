import java.util.Observable;

public class Slide extends Observable {
  private int _x, _y, _h;
  private boolean _withSlide = false;
  private int _position = 8192;
  private final int _offset = 3000;
    
  Slide(int x, int y, int h){
    _x = x;
    _y = y;
    _h = h;
  }
  
  void setPosition (int position) {
    boolean oldWithSlide = _withSlide;
    
    _position = position;
    _withSlide = (_position < (8192 - _offset));
    
    if (oldWithSlide != _withSlide) {
      setChanged();
      notifyObservers();
    }
  }
  
  boolean withSlide(){return _withSlide;}
  
  void update(){
    int pitchbendPerPixel = 13653/400;
    //ellipse(_position/pitchbendPerPixel, _y, _w,_w);
    
    int fill = 50;
    if (_withSlide) {fill = 150;}
    fill(fill);
    rect(_x,_y, _position/pitchbendPerPixel,_h);
    fill(100);
    rect(_x + (8192 - _offset)/pitchbendPerPixel, _y - 10, 5, _h + 10);
  }
}