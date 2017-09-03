import themidibus.*; //Import the library
import javax.sound.midi.MidiMessage;

private MusicMath _mm;
private Harmonica _harmonica;
private int[] _channels;
private Midi _midi;
public MidiBus[] _busses;

public Debugger _debugger = new Debugger();

void setup() {
  size(400, 400);
  background(0);
  
  _mm = new MusicMath();
  _channels = new int[] {0};
  _harmonica = new Harmonica(_mm.c4);
  initMidi();
}

void draw() {
  background(0);
  _harmonica.draw();
  _midi.update(_busses[0]);
}

void noteOn(Note note) {
  _midi.noteOn(note);
}
  
void controllerChange(ControlChange cc) {
  _midi.controllerChange(cc);
}
  
void midiMessage(MidiMessage message) { // You can also use midiMessage(MidiMessage message, long timestamp, String bus_name)
  _midi.midiMessage(message);
}

void initMidi(){
  final String softStep = "Port 1"; // Softstep 2
  final String expressionPedal = "Port 2"; // expression pedal connected to Softstep 2
  final String DM48 = "DM48"; // midi harmonica
  //final String busOut = "Bus 1"; // output bus on MacBookPro dev machine
  final String busOut = "loopMIDI Port 1"; // output bus on Windows 10 dev machine
  final String pitchBender = "Mini Pitchbend Joystick"; // pitchbender from Brendan Power used as slide
  
  MidiBus bus1 = new MidiBus(this, DM48, busOut);
  //bus2 = new MidiBus(this, softStep, osxBus1Out);
  //bus3 = new MidiBus(this, expressionPedal, osxBus1Out);
  MidiBus bus4 = new MidiBus(this, pitchBender, busOut);
  _busses = new MidiBus[] {bus1, bus4};
  _midi = new Midi(_channels);
}