class Slide {
  int _x, _y, _h;
  boolean withSlide = false;
  int _position = 8192;
  final int _offset = 3000;
    
  Slide(int x, int y, int h){
    _x = x;
    _y = y;
    _h = h;
  }
  
  void setPosition (int position) {
    _position = position;
    withSlide = (_position < (8192 - _offset));
  }
  
  void update(){
    int pitchbendPerPixel = 13653/400;
    //ellipse(_position/pitchbendPerPixel, _y, _w,_w);
    
    int fill = 50;
    if (withSlide) {fill = 150;}
    fill(fill);
    rect(_x,_y, _position/pitchbendPerPixel,_h);
    fill(100);
    rect(_x + (8192 - _offset)/pitchbendPerPixel, _y - 10, 5, _h + 10);
  }
}