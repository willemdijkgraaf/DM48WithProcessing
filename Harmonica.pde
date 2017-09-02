import java.util.Observer;
import java.util.Observable;

public class Harmonica implements Observer {
  private MouthPiece _mouthPiece;
  private Tuning _tuning;
  
   Harmonica() {
     _tuning = new Tuning();
     _mouthPiece = new MouthPiece(0,0,width, 100, _tuning);
     _mouthPiece.addObserver(this);
   }
   
   public void update(Observable obs, Object obj)
   {
      if (obs == _mouthPiece) {
        println("Note changed");
      }
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