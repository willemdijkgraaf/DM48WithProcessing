import themidibus.*; //Import the library

class Harmony {
  Note root;
  int[] intervals;
  int[] channels;
  
  Harmony ( int[] outputChannels) {
      channels = outputChannels;
  }

  void turnNotesOn(MidiBus midiBus){
    //print("harmony " + root.pitch + ",");
    if (root == null) return;
    int channel;
    int numberOfChannels = channels.length;
    int numberOfIntervals = intervals.length;
    int pitch = root.pitch;
    for (int channelIndex = 0; channelIndex < numberOfChannels; channelIndex = channelIndex+1) {
       channel = channels[channelIndex] - 1;
       for (int intervalIndex = 0; intervalIndex < numberOfIntervals; intervalIndex = intervalIndex+1) {
         pitch = pitch + intervals[intervalIndex];
         midiBus.sendNoteOn(channel, pitch, root.velocity);
         //print(pitch + ",");
       }
    }
    //println();
  }
  
  void turnNotesOff(MidiBus midiBus){
    //print("harmony " + root.pitch + ",");
    if (root == null) return;
    int channel;
    int numberOfChannels = channels.length;
    int numberOfIntervals = intervals.length;
    int pitch = root.pitch;
    for (int channelIndex = 0; channelIndex < numberOfChannels; channelIndex = channelIndex+1) {
       channel = channels[channelIndex] - 1;
       for (int intervalIndex = 0; intervalIndex < numberOfIntervals; intervalIndex = intervalIndex+1) {
         pitch = pitch + intervals[intervalIndex];
         midiBus.sendNoteOff(channel, pitch, root.velocity);
         //print(pitch + ",");
       }
    }
    //println();
  }
}