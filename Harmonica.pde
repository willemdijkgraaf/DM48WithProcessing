import java.util.Observer;
import java.util.Observable;

public class Harmonica implements Observer {
  private MouthPiece _mouthPiece;
  private Slide _slide;
  private Tuning _tuning;
  private int _key;
  
  private HarmonicaState[] _buffer;
  private int _bufferLastWriteIndex = 1;
  private int _bufferLastReadIndex = 1;
  
  Harmonica(int pitch) {
     initBuffer();
     _key = pitch;
     _tuning = new Tuning();
     _mouthPiece = new MouthPiece(0,0,width, 100);
     _mouthPiece.addObserver(this);
    _slide = new Slide(100, 200, 30);
    _slide.addObserver(this);
   }
   
   private void initBuffer() {
     int bufferSize = 1024;
     _buffer = new HarmonicaState[bufferSize];
     for (int i = 0; i < bufferSize; i = i + 1) {
       _buffer[i] = new HarmonicaState();
     }
   }
   
   public void update(Observable obs, Object obj)
   {
     int index = _bufferLastWriteIndex + 1;
     if (index > 1023) {index = 0;}
     HarmonicaState state = _buffer[index];
     HarmonicaState previousState = _buffer[_bufferLastWriteIndex];
     
      if (obs == _mouthPiece) {
        // previous values
        state.slideInRatio = previousState.slideInRatio;
        // new values
        state.isPlaying = _mouthPiece.isPlaying();
        state.isBlowing = _mouthPiece.isBlowing();
        state.hole = _mouthPiece.currentHole();
        _bufferLastWriteIndex = index;
      }
      
      if (obs == _slide && _mouthPiece.isPlaying()) {
        // previous values
        state.isPlaying = previousState.isPlaying;
        state.isBlowing = previousState.isBlowing;
        state.hole = previousState.hole;
        // new values
        state.slideInRatio = _slide.slideInRatio();
        state.isSlideIn = _slide.isSlideIn();
        _bufferLastWriteIndex = index;
      }
   }
   
   public HarmonicaState getState() {
     if (_bufferLastWriteIndex == _bufferLastReadIndex) {return null;}
     _bufferLastReadIndex = _bufferLastWriteIndex;
     return _buffer[_bufferLastReadIndex];
   }
   
   public int getPitch(HarmonicaState state) {
     int blowing = 0;
     int slide = 0;
     
     if (!state.isBlowing) {
       blowing = 2;
     }
     
     if (state.slideInRatio > 0.5) {
       slide = 1;
     }
     println("hole: " + state.hole);
     int wholeToneBasedPitch = _key + (state.hole * 4) + blowing + slide;
     println("WT pitch: " + wholeToneBasedPitch);
     return _tuning.getPitch(wholeToneBasedPitch); 
   }
   
   public void draw() {
     _mouthPiece.draw();
     _slide.draw();
   }
   
   public MouthPiece mouthPiece() {
     return _mouthPiece;
   }
   
  public Slide slide() {
    return _slide;
  }
}