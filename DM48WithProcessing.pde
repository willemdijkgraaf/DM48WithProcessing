import themidibus.*; //Import the library
import javax.sound.midi.MidiMessage;

private MusicMath _mm;
private Harmonica _harmonica;
private Harmony _harmony; // todo: refactor -> maybe strange place for this variable
private Harmony[] _harmonies; // todo: refactor -> maybe strange place for this variable

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
  initHarmony();
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

void initHarmony(){
  // first harmony
  Harmony harmony1 = new Harmony();
  //harmony1.intervals = new int[] {mm.unison, - mm.octave - mm.m3rd, mm.octave - mm.aug4th};
  //harmony1.intervals = mm.pitchesToIntervals(new int[]{mm.ab2,mm.eb3,mm.ab3,mm.db4,mm.eb4,mm.ab4,mm.c5}); 
  harmony1._intervals = new int[]{0};
  // second harmony
  Harmony harmony2 = new Harmony();
  harmony2._intervals = new int[] {_mm.unison, - _mm.octave - _mm.M3rd, - _mm.octave - _mm.aug4th};
  harmony2._intervals = _mm.pitchesToIntervals(new int[]{_mm.ab2, _mm.eb3, _mm.ab3, _mm.db4, _mm.eb4, _mm.g4, _mm.c5}); 
  
  // third harmony
  Harmony harmony3 = new Harmony();
  harmony3._intervals = _mm.pitchesToIntervals(new int[]{_mm.d2, _mm.a2, _mm.fs3, _mm.a3, _mm.d4, _mm.g4}); 
  
  //harmonies = new Harmony[] {harmony1, harmony2, harmony3};
  _harmonies = new Harmony[] {harmony1};
}