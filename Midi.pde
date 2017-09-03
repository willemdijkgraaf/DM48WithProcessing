

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
    boolean isPitchChanged = _harmonica.isPitchChanged();
    
    // not playing -> send note off
    if (!_harmonica.isPlaying() && _noteOffPitch != -1) {
      outputBus.sendNoteOff(0, _noteOffPitch, 0);
      _noteOffPitch = -1;
    }
    
    if (isPitchChanged) {
      // turn off previous note
      if (_noteOffPitch != -1) {
        outputBus.sendNoteOff(0, _noteOffPitch, 0);
        _noteOffPitch = -1;
      }
      
      int pitch = _harmonica.pitch();
      
      outputBus.sendNoteOn(0, pitch, 100);
      _noteOffPitch = pitch;
      
      //if (_harmony == null || _harmony.root() == null || _harmony.root().pitch != pitch) {
      //  _harmony = _harmonies[int(random(_harmonies.length))];
      //}
      
      //_noteOnTunedPitch.pitch = pitch;
      //_noteOnTunedPitch.velocity = _noteOn.velocity;
      //_harmony.setRoot(_noteOnTunedPitch);
      //_harmony.turnNotesOn(outputBus);
    }
    
    // CC2
    for (int channelIndex = 0; channelIndex < numberOfChannels; channelIndex = channelIndex+1) {
      int channel = _channels[channelIndex];
      if (_breathControllerValueChanged) {
        ControlChange cc = new ControlChange(channel, BREATHCONTROLLERCC, _breathController.value);
        outputBus.sendControllerChange(cc); // Send a controllerChange
      }
    }
    
    //_noteOnChanged = false;
    _breathControllerValueChanged = false; 
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
        if (_breathController == null || cc.value != _breathController.value) {
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
      _harmonica.mouthPiece().slide().setPosition( (msg[2] * 128) + msg[1]);
      
      //if (slide != _harmonica.mouthPiece().slide().withSlide()) {
      //  // noteOffChanged = true;
      //  _noteOnChanged = true;
      //}
    }
  }
}