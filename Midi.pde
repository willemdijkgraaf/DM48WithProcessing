

class Midi {
  MidiBus[] _busses;
  
  final int BREATHCONTROLLERCC = 2;

  ControlChange _breathController;
  boolean _breathControllerValueChanged;
  
  // NoteOn is only used as a work arround for knowing if player blows or draws
  Note _noteOn = new Note(0,0,0);
  boolean _noteOnChanged;
  Note _noteOnTunedPitch = new Note(0,0,0);
  
  int[] _channels = {0};
  
  Midi(MidiBus[] busses, int[] channels){
    _channels = channels;
    _breathController = new ControlChange(0,0,0);
    _breathController.channel = 0;
    _breathController.number = 2; 
    MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  
    _busses = busses;
  }
  
  void update(){
    // cc & note on/off
    int numberOfChannels = _channels.length;
  
    if (_breathController.value > 10 && _noteOnChanged ) {
      if (_harmony == null || _harmony.root() == null || _harmony.root().pitch != _noteOn.pitch) {
        _harmony = _harmonies[int(random(_harmonies.length))];
      }
      
      _noteOnTunedPitch.pitch = _tuning.getPitch(_noteOn.pitch, _mouthPiece.slide().withSlide());;
      _noteOnTunedPitch.velocity = _noteOn.velocity;
      _harmony.setRoot(_noteOnTunedPitch);
      _harmony.turnNotesOn(_busses[0]);
    }
    
    for (int channelIndex = 0; channelIndex < numberOfChannels; channelIndex = channelIndex+1) {
      int channel = _channels[channelIndex];
      if (_breathControllerValueChanged && _breathController != null) {
        ControlChange cc = new ControlChange(channel, BREATHCONTROLLERCC, _breathController.value);
        _busses[1].sendControllerChange(cc); // Send a controllerChange
      }
    }
    
    _noteOnChanged = false;
    _breathControllerValueChanged = false; 
  }
  
  public void noteOn(Note note) {
    // Receive a noteOn
    _noteOn = note;
    _noteOnChanged = true;
    _mouthPiece.setBlowOrDraw(note.pitch);
  }
  
  public void controllerChange(ControlChange cc) {
    if (cc == null) return;
    // Receive a controllerChange
    switch (cc.number) {
      case BREATHCONTROLLERCC:
        _mouthPiece.setBreathForce(cc.channel, cc.value);
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
      boolean slide = _mouthPiece.slide().withSlide();
      _mouthPiece.slide().setPosition( (msg[2] * 128) + msg[1]);
      
      if (slide != _mouthPiece.slide().withSlide()) {
        // noteOffChanged = true;
        _noteOnChanged = true;
      }
    }
  }
}