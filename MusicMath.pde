class MusicMath {
  // pitch classes
  final int pc0 = 0;
  final int pc1 = 1;
  final int pc2 = 2;
  final int pc3 = 3;
  final int pc4 = 4;
  final int pc5 = 5;
  final int pc6 = 6;
  final int pc7 = 7;
  final int pc8 = 8;
  final int pc9 = 9;
  final int pc10 = 10;
  final int pc11 = 11;
  
  // intervals
  final int unison = 0;
  final int m2nd = 1;
  final int M2nd = 2;
  final int m3rd = 3;
  final int M3rd = 4;
  final int P4th = 5;
  final int aug4th = 6;
  final int P5th = 7;
  final int aug5th = 8;
  final int m6th = 8;
  final int M6th = 9;
  final int m7th = 10;
  final int M7th = 11;
  final int P8th = 12;
  final int octave = 12;
  final int m9th = P8th + m2nd;
  final int M9th = P8th + M2nd;
  final int S9th = P8th + m3rd;
  
  // pitches
  final int c_1 = unison + 0 * octave; // midi pitch 0
  final int cs_1 = m2nd + 0 * octave;
  final int db_1 = m2nd + 0 * octave;
  final int d_1 = M2nd + 0 * octave;
  final int ds_1 = m3rd + 0 * octave;
  final int eb_1 = m3rd + 0 * octave;
  final int e_1 = M3rd + 0 * octave;
  final int es_1 = P4th + 0 * octave;
  final int f_1 = P4th + 0 * octave;
  final int fs_1 = aug4th + 0 * octave;
  final int gb_1 = aug4th + 0 * octave;
  final int g_1 = P5th + 0 * octave;
  final int gs_1 = aug5th + 0 * octave;
  final int ab_1 = m6th + 0 * octave;
  final int a_1 = M6th + 0 * octave;
  final int as_1 = m7th + 0 * octave;
  final int bb_1 = m7th + 0 * octave;
  final int b_1 = M7th + 0 * octave;
  
  final int c0 = unison + 1 * octave;
  final int cs0 = m2nd + 1 * octave;
  final int db0 = m2nd + 1 * octave;
  final int d0 = M2nd + 1 * octave;
  final int ds0 = m3rd + 1 * octave;
  final int eb0 = m3rd + 1 * octave;
  final int e0 = M3rd + 1 * octave;
  final int es0 = P4th + 1 * octave;
  final int f0 = P4th + 1 * octave;
  final int fs0 = aug4th + 1 * octave;
  final int gb0 = aug4th + 1 * octave;
  final int g0 = P5th + 1 * octave;
  final int gs0 = aug5th + 1 * octave;
  final int ab0 = m6th + 1 * octave;
  final int a0 = M6th + 1 * octave;
  final int as0 = m7th + 1 * octave;
  final int bb0 = m7th + 1 * octave;
  final int b0 = M7th + 1 * octave;
  
  final int c1 = c0 + 1 * octave; // 
  final int cs1 = cs0 + 1 * octave;
  final int db1 = cs0 + 1 * octave;
  final int d1 = d0 + 1 * octave;
  final int ds1 = ds0 + 1 * octave;
  final int eb1 = ds0 + 1 * octave;
  final int e1 = e0 + 1 * octave;
  final int es1 = f0 + 1 * octave;
  final int f1 = f0 + 1 * octave;
  final int fs1 = fs0 + 1 * octave;
  final int gb1 = fs0 + 1 * octave;
  final int g1 = g0 + 1 * octave;
  final int gs1 = gs0 + 1 * octave;
  final int ab1 = ab0 + 1 * octave;
  final int a1 = a0 + 1 * octave;
  final int as1 = as0 + 1 * octave;
  final int bb1 = as0 + 1 * octave;
  final int b1 = b0 + 1 * octave;
  
  final int c2 = c0 + 2 * octave;
  final int cs2 = cs0 + 2 * octave;
  final int db2 = cs0 + 2 * octave;
  final int d2 = d0 + 2 * octave;
  final int ds2 = ds0 + 2 * octave;
  final int eb2 = ds0 + 2 * octave;
  final int e2 = e0 + 2 * octave;
  final int es2 = f0 + 2 * octave;
  final int f2 = f0 + 2 * octave;
  final int fs2 = fs0 + 2 * octave;
  final int gb2 = fs0 + 2 * octave;
  final int g2 = g0 + 2 * octave;
  final int gs2 = gs0 + 2 * octave;
  final int ab2 = ab0 + 2 * octave;
  final int a2 = a0 + 2 * octave;
  final int as2 = as0 + 2 * octave;
  final int bb2 = as0 + 2 * octave;
  final int b2 = b0 + 2 * octave;
  
  final int c3 = c0 + 3 * octave;
  final int cs3 = cs0 + 3 * octave;
  final int db3 = cs0 + 3 * octave;
  final int d3 = d0 + 3 * octave;
  final int ds3 = ds0 + 3 * octave;
  final int eb3 = ds0 + 3 * octave;
  final int e3 = e0 + 3 * octave;
  final int es3 = f0 + 3 * octave;
  final int f3 = f0 + 3 * octave;
  final int fs3 = fs0 + 3 * octave;
  final int gb3 = fs0 + 3 * octave;
  final int g3 = g0 + 3 * octave;
  final int gs3 = gs0 + 3 * octave;
  final int ab3 = ab0 + 3 * octave;
  final int a3 = a0 + 3 * octave;
  final int as3 = as0 + 3 * octave;
  final int bb3 = as0 + 3 * octave;
  final int b3 = b0 + 3 * octave;
  
  final int c4 = c0 + 4 * octave;
  final int cs4 = cs0 + 4 * octave;
  final int db4 = cs0 + 4 * octave;
  final int d4 = d0 + 4 * octave;
  final int ds4 = ds0 + 4 * octave;
  final int eb4 = ds0 + 4 * octave;
  final int e4 = e0 + 4 * octave;
  final int es4 = f0 + 4 * octave;
  final int f4 = f0 + 4 * octave;
  final int fs4 = fs0 + 4 * octave;
  final int gb4 = fs0 + 4 * octave;
  final int g4 = g0 + 4 * octave;
  final int gs4 = gs0 + 4 * octave;
  final int ab4 = ab0 + 4 * octave;
  final int a4 = a0 + 4 * octave;
  final int as4 = as0 + 4 * octave;
  final int bb4 = as0 + 4 * octave;
  final int b4 = b0 + 4 * octave;
  
  final int c5 = c0 + 5 * octave;
  final int cs5 = cs0 + 5 * octave;
  final int db5 = cs0 + 5 * octave;
  final int d5 = d0 + 5 * octave;
  final int ds5 = ds0 + 5 * octave;
  final int eb5 = ds0 + 5 * octave;
  final int e5 = e0 + 5 * octave;
  final int es5 = f0 + 5 * octave;
  final int f5 = f0 + 5 * octave;
  final int fs5 = fs0 + 5 * octave;
  final int gb5 = fs0 + 5 * octave;
  final int g5 = g0 + 5 * octave;
  final int gs5 = gs0 + 5 * octave;
  final int ab5 = ab0 + 5 * octave;
  final int a5 = a0 + 5 * octave;
  final int as5 = as0 + 5 * octave;
  final int bb5 = as0 + 5 * octave;
  final int b5 = b0 + 5 * octave;
  
  final int c6 = c0 + 6 * octave;
  final int cs6 = cs0 + 6 * octave;
  final int db6 = cs0 + 6 * octave;
  final int d6 = d0 + 6 * octave;
  final int ds6 = ds0 + 6 * octave;
  final int eb6 = ds0 + 6 * octave;
  final int e6 = e0 + 6 * octave;
  final int es6 = f0 + 6 * octave;
  final int f6 = f0 + 6 * octave;
  final int fs6 = fs0 + 6 * octave;
  final int gb6 = fs0 + 6 * octave;
  final int g6 = g0 + 6 * octave;
  final int gs6 = gs0 + 6 * octave;
  final int ab6 = ab0 + 6 * octave;
  final int a6 = a0 + 6 * octave;
  final int as6 = as0 + 6 * octave;
  final int bb6 = as0 + 6 * octave;
  final int b6 = b0 + 6 * octave;

  final int c7 = c0 + 7 * octave;
  final int cs7 = cs0 + 7 * octave;
  final int db7 = cs0 + 7 * octave;
  final int d7 = d0 + 7 * octave;
  final int ds7 = ds0 + 7 * octave;
  final int eb7 = ds0 + 7 * octave;
  final int e7 = e0 + 7 * octave;
  final int es7 = f0 + 7 * octave;
  final int f7 = f0 + 7 * octave;
  final int fs7 = fs0 + 7 * octave;
  final int gb7 = fs0 + 7 * octave;
  final int g7 = g0 + 7 * octave;
  final int gs7 = gs0 + 7 * octave;
  final int ab7 = ab0 + 7 * octave;
  final int a7 = a0 + 7 * octave;
  final int as7 = as0 + 7 * octave;
  final int bb7 = as0 + 7 * octave;
  final int b7 = b0 + 7 * octave;
  
  final int c8 = c0 + 8 * octave;
  final int cs8 = cs0 + 8 * octave;
  final int db8 = cs0 + 8 * octave;
  final int d8 = d0 + 8 * octave;
  final int ds8 = ds0 + 8 * octave;
  final int eb8 = ds0 + 8 * octave;
  final int e8 = e0 + 8 * octave;
  final int es8 = f0 + 8 * octave;
  final int f8 = f0 + 8 * octave;
  final int fs8 = fs0 + 8 * octave;
  final int gb8 = fs0 + 8 * octave;
  final int g8 = g0 + 8 * octave;
  final int gs8 = gs0 + 8 * octave;
  final int ab8 = ab0 + 8 * octave;
  final int a8 = a0 + 8 * octave;
  final int as8 = as0 + 8 * octave;
  final int bb8 = as0 + 8 * octave;
  final int b8 = b0 + 8 * octave;

  final int c9 = c0 + 8 * octave;
  final int cs9 = cs0 + 8 * octave;
  final int db9 = cs0 + 8 * octave;
  final int d9 = d0 + 8 * octave;
  final int ds9 = ds0 + 8 * octave;
  final int eb9 = ds0 + 8 * octave;
  final int e9 = e0 + 8 * octave;
  final int es9 = f0 + 8 * octave;
  final int f9 = f0 + 8 * octave;
  final int fs9 = fs0 + 8 * octave;
  final int gb9 = fs0 + 8 * octave;
  final int g9 = g0 + 8 * octave; // midi pitch 127

  int midiToPitchClass (int midiPitch) {
    return midiPitch % 12;
  }
  
  int[] pitchesToIntervals (int[] pitches) {
    int[] intervals = new int[pitches.length-1];
    int previousPitch = pitches[0];
    
    for (int i = 1; i < pitches.length; i=i+1) {
      intervals[i-1] = pitches[i] - previousPitch;
      previousPitch = pitches[i];
    }
    return intervals;
  }
  
}