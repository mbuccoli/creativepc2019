
float[] range_freq={220, 880}; // two octaves
class Agent{
  float freq, amp;
  OscP5 oscP5;
  NetAddress location;
  Agent(){
    this.freq=0;
    this.amp=0;
    
    this.oscP5 = new OscP5(this,55000);
    this.location = new NetAddress("127.0.0.1",57120);
  }  
  void reasoning(){ 
    this.freq=map(mouseX, 0, width, range_freq[0], range_freq[1]);
    this.amp=map(mouseY, 0, height, 1, 0);    
  }  
  void planning(){;
  }  
  void action(){
    this.reasoning();
    OscMessage freq_amp = new OscMessage("/dummytheremin");
    freq_amp.add(this.freq);
    freq_amp.add(this.amp);
    this.oscP5.send(freq_amp, this.location);
}

  
}
