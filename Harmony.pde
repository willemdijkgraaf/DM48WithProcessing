import themidibus.*; //Import the library

class Harmony {
  private Note _root;
  private int[] _intervals;
  private int[] _channels;
  
  Harmony ( int[] outputChannels) {
    _channels = outputChannels;
  }

  void turnNotesOn(MidiBus midiBus){
    //print("harmony " + root.pitch + ",");
    if (_root == null) return;
    int channel;
    int numberOfChannels = _channels.length;
    int numberOfIntervals = _intervals.length;
    int pitch = _root.pitch;
    for (int channelIndex = 0; channelIndex < numberOfChannels; channelIndex = channelIndex+1) {
       channel = _channels[channelIndex] - 1;
       for (int intervalIndex = 0; intervalIndex < numberOfIntervals; intervalIndex = intervalIndex+1) {
         pitch = pitch + _intervals[intervalIndex];
         midiBus.sendNoteOn(channel, pitch, _root.velocity);
         //print(pitch + ",");
       }
    }
    //println();
  }
  
  Note root() {
    return _root;
  }
  
  void setRoot(Note root){_root = root;}
  
  void turnNotesOff(MidiBus midiBus){
    if (_root == null) return;
    int channel;
    int numberOfChannels = _channels.length;
    int numberOfIntervals = _intervals.length;
    int pitch = _root.pitch;
    for (int channelIndex = 0; channelIndex < numberOfChannels; channelIndex = channelIndex+1) {
       channel = _channels[channelIndex] - 1;
       for (int intervalIndex = 0; intervalIndex < numberOfIntervals; intervalIndex = intervalIndex+1) {
         pitch = pitch + _intervals[intervalIndex];
         midiBus.sendNoteOff(channel, pitch, _root.velocity);
       }
    }
  }
}