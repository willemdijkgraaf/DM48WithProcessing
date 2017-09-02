import themidibus.*; //Import the library
import javax.sound.midi.MidiMessage;

final String softStep = "Port 1"; // Softstep 2
final String expressionPedal = "Port 2"; // expression pedal connected to Softstep 2
final String DM48 = "DM48"; // midi harmonica
final String osxBus1Out = "Bus 1"; // output bus on MacBookPro
final String pitchBender = "Mini Pitchbend Joystick"; // pitchbender from Brendan Power used as slide

MidiBus _bus1;
MidiBus _bus2;
MidiBus _bus3;
MidiBus _bus4;

MusicMath _mm = new MusicMath();
MouthPiece _mouthPiece;

final int BREATHCONTROLLERCC = 2;

ControlChange _breathController;
boolean _breathControllerValueChanged;

// NoteOn is only used as a work arround for knowing if player blows or draws
Note _noteOn = new Note(0,0,0);
boolean _noteOnChanged;
Note _noteOnTunedPitch = new Note(0,0,0);

Harmony _harmony;
Harmony[] _harmonies;

int[] _channels = {0};

Tuning _tuning = new Tuning();

Debugger _debugger = new Debugger();

void setup() {
  size(400, 400);
  background(0);

  _mouthPiece =new MouthPiece(0,0, width, 100);
  
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  _bus1 = new MidiBus(this, DM48, osxBus1Out); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  //bus2 = new MidiBus(this, softStep, osxBus1Out);
  //bus3 = new MidiBus(this, expressionPedal, osxBus1Out);
  _bus4 = new MidiBus(this, pitchBender, osxBus1Out);  
  // first harmony
  Harmony harmony1 = new Harmony(_channels);
  //harmony1.intervals = new int[] {mm.unison, - mm.octave - mm.m3rd, mm.octave - mm.aug4th};
  //harmony1.intervals = mm.pitchesToIntervals(new int[]{mm.ab2,mm.eb3,mm.ab3,mm.db4,mm.eb4,mm.ab4,mm.c5}); 
  harmony1.intervals = new int[]{0};
  // second harmony
  Harmony harmony2 = new Harmony(_channels);
  harmony2.intervals = new int[] {_mm.unison, - _mm.octave - _mm.M3rd, - _mm.octave - _mm.aug4th};
  harmony2.intervals = _mm.pitchesToIntervals(new int[]{_mm.ab2, _mm.eb3, _mm.ab3, _mm.db4, _mm.eb4, _mm.g4, _mm.c5}); 
  
  // third harmony
  Harmony harmony3 = new Harmony(_channels);
  harmony3.intervals = _mm.pitchesToIntervals(new int[]{_mm.d2, _mm.a2, _mm.fs3, _mm.a3, _mm.d4, _mm.g4}); 
  
  //harmonies = new Harmony[] {harmony1, harmony2, harmony3};
  _harmonies = new Harmony[] {harmony1};
  
  _breathController = new ControlChange(0,0,0);
  _breathController.channel = 0;
  _breathController.number = 2;
}

void draw() {
  background(0);
  _mouthPiece.update();
  
  // cc & note on/off
  int numberOfChannels = _channels.length;

  if (_breathController.value > 10 && _noteOnChanged ) {
    if (_harmony == null || _harmony.root == null || _harmony.root.pitch != _noteOn.pitch) {
      _harmony = _harmonies[int(random(_harmonies.length))];
    }
    
    _noteOnTunedPitch.pitch = _tuning.getPitch(_noteOn.pitch, _mouthPiece.slide().withSlide);;
    _noteOnTunedPitch.velocity = _noteOn.velocity;
    _harmony.root = _noteOnTunedPitch;
    _harmony.turnNotesOn(_bus1);
  }
  
  for (int channelIndex = 0; channelIndex < numberOfChannels; channelIndex = channelIndex+1) {
    int channel = _channels[channelIndex];
    if (_breathControllerValueChanged && _breathController != null) {
      ControlChange cc = new ControlChange(channel, BREATHCONTROLLERCC, _breathController.value);
      _bus4.sendControllerChange(cc); // Send a controllerChange
    }
  }
  
  _noteOnChanged = false;
  _breathControllerValueChanged = false; 
}

void noteOn(Note note) {
  // Receive a noteOn
  _noteOn = note;
  _noteOnChanged = true;
  _mouthPiece.setBlowOrDraw(note.pitch);
  
}

void controllerChange(ControlChange cc) {
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

void midiMessage(MidiMessage message) { // You can also use midiMessage(MidiMessage message, long timestamp, String bus_name)
  // Receive a MidiMessage
  // MidiMessage is an abstract class, the actual passed object will be either javax.sound.midi.MetaMessage, javax.sound.midi.ShortMessage, javax.sound.midi.SysexMessage.
  // Check it out here http://java.sun.com/j2se/1.5.0/docs/api/javax/sound/midi/package-summary.html
  
  if (message.getStatus() == 224) // pitch bend
  {
    byte[]msg = message.getMessage();
    boolean slide = _mouthPiece.slide().withSlide;
    _mouthPiece.slide().setPosition( (msg[2] * 128) + msg[1]);
    
    if (slide != _mouthPiece.slide().withSlide) {
      // noteOffChanged = true;
      _noteOnChanged = true;
    }
  }
}