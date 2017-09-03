import java.util.Observer;
import java.util.Observable;

public class Harmonica implements Observer {
  private MouthPiece _mouthPiece;
  private Tuning _tuning;
  private int _pitch;
  private boolean _pitchChanged;
  private int _key = _mm.c4;
  
  Harmonica() {
     _tuning = new Tuning();
     _mouthPiece = new MouthPiece(0,0,width, 100);
     _mouthPiece.addObserver(this);
   }
   
   public void update(Observable obs, Object obj)
   {
      if (obs == _mouthPiece) {
         int newPitch = determinePitch();
         if (newPitch != _pitch) {
           _pitch = newPitch;
           _pitchChanged = true;
         }
      }
   }
   
   public boolean isPitchChanged() {
     if (_pitchChanged) {
       _pitchChanged = false;
       return true;
     } else {
       return false;
     }
   }
   
   public int pitch() {
     return _pitch;
   }
   
   private int determinePitch() {
     int drawing = 0; 
     int hole = _mouthPiece.getCurrentHole();
     int slide = 0;
     
     if (!_mouthPiece.isBlowing()) {
       drawing = 2;
     }
     
     if (_mouthPiece.slide().withSlide()) {
       slide = 1;
     }
     
     int wholeToneBasedPitch = _key + (hole * 4) + drawing + slide;
     return _tuning.getPitch(wholeToneBasedPitch); 
   }
   
   public void update() {
     _mouthPiece.update();
   }
   
   public Tuning tuning() {
     return _tuning;
   }
   
   public MouthPiece mouthPiece() {
     return _mouthPiece;
   }
}