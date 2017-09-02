class Debugger {
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
}