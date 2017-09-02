import themidibus.*; //Import the library
import javax.sound.midi.MidiMessage;

String softStep = "Port 1"; // Softstep 2
String expressionPedal = "Port 2"; // expression pedal connected to Softstep 2
String DM48 = "DM48"; // midi harmonica
String osxBus1Out = "Bus 1"; // output bus on MacBookPro
String pitchBender = "Mini Pitchbend Joystick"; // pitchbender from Brendan Power used as slide

MidiBus bus1;
MidiBus bus2;
MidiBus bus3;
MidiBus bus4;

MusicMath mm = new MusicMath();
MouthPiece _mouthPiece;
Slide _slide;

final int BREATHCONTROLLERCC = 2;

ControlChange breathController;
boolean breathControllerValueChanged;

Note noteOn = new Note(0,0,0);
boolean noteOnChanged;
Note noteOnTunedPitch = new Note(0,0,0);

//Note noteOff = new Note(0,0,0);
//boolean noteOffChanged;
//Note noteOffTunedPitch = new Note(0,0,0);

Harmony harmony;
Harmony[] harmonies;

int[] channels = {0};

Tuning tuning = new Tuning();


void setup() {
  size(400, 400);
  background(0);

  _mouthPiece =new MouthPiece(0,0, width, 100);
  _slide = new Slide(100, 200, 30);
  
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  bus1 = new MidiBus(this, DM48, osxBus1Out); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  //bus2 = new MidiBus(this, softStep, osxBus1Out);
  //bus3 = new MidiBus(this, expressionPedal, osxBus1Out);
  bus4 = new MidiBus(this, pitchBender, osxBus1Out);  
  // first harmony
  Harmony harmony1 = new Harmony(channels);
  //harmony1.intervals = new int[] {mm.unison, - mm.octave - mm.m3rd, mm.octave - mm.aug4th};
  //harmony1.intervals = mm.pitchesToIntervals(new int[]{mm.ab2,mm.eb3,mm.ab3,mm.db4,mm.eb4,mm.ab4,mm.c5}); 
  harmony1.intervals = new int[]{0};
  // second harmony
  Harmony harmony2 = new Harmony(channels);
  harmony2.intervals = new int[] {mm.unison, - mm.octave - mm.M3rd, - mm.octave - mm.aug4th};
  harmony2.intervals = mm.pitchesToIntervals(new int[]{mm.ab2,mm.eb3,mm.ab3,mm.db4,mm.eb4,mm.g4,mm.c5}); 
  
  // third harmony
  Harmony harmony3 = new Harmony(channels);
  harmony3.intervals = mm.pitchesToIntervals(new int[]{mm.d2,mm.a2,mm.fs3,mm.a3,mm.d4,mm.g4}); 
  
  //harmonies = new Harmony[] {harmony1, harmony2, harmony3};
  harmonies = new Harmony[] {harmony1};
  
  breathController = new ControlChange(0,0,0);
  breathController.channel = 0;
  breathController.number = 2;
}

void draw() {
  background(0);
  _mouthPiece.update();
  _slide.update();
  
  // cc & note on/off
  int numberOfChannels = channels.length;

  if (breathController.value > 10 && noteOnChanged ) {
    if (harmony == null || harmony.root == null || harmony.root.pitch != noteOn.pitch) {
      harmony = harmonies[int(random(harmonies.length))];
    }
    _mouthPiece.setBlowOrDraw(noteOn.pitch);
    noteOnTunedPitch.pitch = tuning.getPitch(noteOn.pitch, _slide.withSlide);;
    noteOnTunedPitch.velocity = noteOn.velocity;
    harmony.root = noteOnTunedPitch;
    harmony.turnNotesOn(bus1);
  }
    
  //if (noteOffChanged) {
  //  if (harmony != null) {
  //    noteOnTunedPitch.pitch = tuning.getPitch(noteOff.pitch, _slide.withSlide);
  //    harmony.root = noteOnTunedPitch;
  //    harmony.turnNotesOff(bus1);
  //  }
  //}
  
  for (int channelIndex = 0; channelIndex < numberOfChannels; channelIndex = channelIndex+1) {
    int channel = channels[channelIndex];
    if (breathControllerValueChanged && breathController != null) {
      ControlChange cc = new ControlChange(channel, BREATHCONTROLLERCC, breathController.value);
      bus4.sendControllerChange(cc); // Send a controllerChange
    }
  }
  
  noteOnChanged = false;
  //noteOffChanged = false;
  breathControllerValueChanged = false; 
}

void noteOn(Note note) {
  // Receive a noteOn
  println("original: " + note.pitch);
  noteOn = note;
  noteOnChanged = true;
  
  printNoteOn(note);
  
}

//void noteOff(Note note) {
//  // Receive a noteOff
//  noteOff = note;
//  noteOffChanged = true;
//}

void controllerChange(ControlChange cc) {
  if (cc == null) return;
  // Receive a controllerChange
  switch (cc.number) {
    case BREATHCONTROLLERCC:
      _mouthPiece.setBreathForce(cc.channel, cc.value);
      if (breathController == null || cc.value != breathController.value) {
        breathController.value = cc.value;
        breathControllerValueChanged = true;
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
    boolean slide = _slide.withSlide;
    _slide.setPosition( (msg[2] * 128) + msg[1]);
    
    if (slide != _slide.withSlide) {
      // noteOffChanged = true;
      noteOnChanged = true;
    }
  }
}

void printNoteOn(Note note) {
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+note.channel);
  println("Pitch:"+note.pitch);
  println("Velocity:"+note.velocity);
}

void printNoteOff(Note note) {
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+note.channel);
  println("Pitch:"+note.pitch);
  println("Velocity:"+note.velocity);
}

void printCC (ControlChange cc) {
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+cc.channel);
  println("Number:"+cc.number);
  println("Value:"+cc.value);
}
void printMessage (MidiMessage message) {
  println("Status Byte/MIDI Command:"+message.getStatus());
  for (int i = 1;i < message.getMessage().length;i++) {
    println("Param "+(i+1)+": "+(int)(message.getMessage()[i] & 0xFF));
  }
}