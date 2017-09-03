

class Midi {
  private final int BREATHCONTROLLERCC = 2;

  private ControlChange _breathController;
  private boolean _breathControllerValueChanged;
  
  // NoteOn is only used as a work arround for knowing if player blows or draws
  //private Note _noteOn = new Note(0,0,0);
  //private boolean _noteOnChanged;
  //private Note _noteOnTunedPitch = new Note(0,0,0);
  private int _noteOffPitch = -1; // -1 = no note to turn off
  
  private int[] _channels = {0};
  private HarmonicaState _previousState = new HarmonicaState();
  
  Midi(int[] channels){
    _channels = channels;
    _breathController = new ControlChange(0,0,0);
    _breathController.channel = 0;
    _breathController.number = 2; 
    MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  }
  
  void update(MidiBus outputBus){
    // note on/off
    int numberOfChannels = _channels.length;
    HarmonicaState state = _harmonica.getState();
    if (state != null) {
      // not playing -> send note off
      if (!state.isPlaying) {
        outputBus.sendNoteOff(0, _noteOffPitch, 0);
        _noteOffPitch = -1;
      }
      
      if (hasPitchChanged(state)) {
        // turn off previous note
        if (_noteOffPitch != -1) {
          outputBus.sendNoteOff(0, _noteOffPitch, 0);
          _noteOffPitch = -1;
        }
        
        if (state.isPlaying) {
          int pitch = _harmonica.getPitch(state);
          outputBus.sendNoteOn(0, pitch, 100);
          _noteOffPitch = pitch;
        }
      }
      _previousState.isSlideIn = state.isSlideIn;
      _previousState.isBlowing = state.isBlowing;
      _previousState.hole = state.hole;
      _previousState.isPlaying = state.isPlaying;
    }
    // CC2
    for (int channelIndex = 0; channelIndex < numberOfChannels; channelIndex = channelIndex+1) {
      int channel = _channels[channelIndex];
      if (_breathControllerValueChanged) {
        ControlChange cc = new ControlChange(channel, BREATHCONTROLLERCC, _breathController.value);
        outputBus.sendControllerChange(cc);
      }
    }
    
    _breathControllerValueChanged = false; 
    

  }
  
  private boolean hasPitchChanged(HarmonicaState state) {
    return 
      state.isSlideIn != _previousState.isSlideIn ||
      state.isBlowing != _previousState.isBlowing ||
      state.hole != _previousState.hole ||
      state.isPlaying != _previousState.isPlaying;
  }
  
  public void noteOn(Note note) {
    // Receive a noteOn
    //_noteOn = note;
    //_noteOnChanged = true;
    _harmonica.mouthPiece().setBlowOrDraw(note.pitch);
  }
  
  public void controllerChange(ControlChange cc) {
    if (cc == null) return;
    // Receive a controllerChange
    switch (cc.number) {
      case BREATHCONTROLLERCC:
        _harmonica.mouthPiece().setBreathForce(cc.channel, cc.value);
        if (Math.abs(cc.value - _breathController.value) > 1) {
          _breathController.value = cc.value;
          _breathControllerValueChanged = true;
        }
        break;
    }
  }
  
  public void midiMessage(MidiMessage message) { // You can also use midiMessage(MidiMessage message, long timestamp, String bus_name)
    // Receive a MidiMessage
    // MidiMessage is an abstract class, the actual passed object will be either javax.sound.midi.MetaMessage, javax.sound.midi.ShortMessage, javax.sound.midi.SysexMessage.
    // Check it out here http://java.sun.com/j2se/1.5.0/docs/api/javax/sound/midi/package-summary.html
    
    if (message.getStatus() == 224) // pitch bend
    {
      byte[]msg = message.getMessage();
      //boolean slide = _harmonica.mouthPiece().slide().withSlide();
      _harmonica.slide().setPosition( (msg[2] * 128) + msg[1]);
      
      //if (slide != _harmonica.mouthPiece().slide().withSlide()) {
      //  // noteOffChanged = true;
      //  _noteOnChanged = true;
      //}
    }
  }
}