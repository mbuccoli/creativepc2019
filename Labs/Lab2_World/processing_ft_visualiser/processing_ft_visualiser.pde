import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
boolean song_mic=true;
AudioPlayer song;
AudioInput mic;
// Frame length
int frameLength = 1024; //--> when this is low, it may take more to compute

AgentFeature feat;
AgentDrawer drawer;

void setup()
{
  size(1280, 720);
  background(0);
  smooth();
  //frameRate(refresh*60);
  minim = new Minim(this);
  if(song_mic){   
    song = minim.loadFile("../data/mashup.mp3",frameLength);  
    feat = new AgentFeature(song.bufferSize(), song.sampleRate());
    song.play();     
  }
  else{
    // Mic input    
    mic = minim.getLineIn(Minim.MONO, frameLength);
    feat = new AgentFeature(mic.bufferSize(), mic.sampleRate());
  }
  drawer=new AgentDrawer(feat, 6);
}


void draw(){
  fill(0);
  rect(0,0,width, height);
    if(song_mic){
    feat.reasoning(song.mix);
  }
  else{
    feat.reasoning(mic.mix);
  }
  drawer.action();
}


 
