
import oscP5.*;
import netP5.*;

Agent a; 

float[] freqs={130.81, 138.59, 146.83, 155.56, 164.81, 174.61,
            185, 196, 207.65, 220, 233.08, 246.94, 261.63,
             277.18, 293.66, 311.13, 329.63, 349.23,  369.99, 
           392, 415.3, 440, 466.16, 493.88, 523.25};
boolean[] isWhiteNote={true, false, true, false, true, true, 
                      false, true, false, true, false, true,
                      true, false, true, false, true, true, 
                      false, true, false, true, false, true, true};

float log2(float d) {
      return (float) (log((float)d)/log(2.0));
}

float logLeftFreq=log2(246.94/2);
float logRightFreq=log2(138.59*4);
float[] freqLinePosX;
float[] freqStrokeWeight;
float[] freqLinePosY;


void setup(){
  size(1280, 720);
  background(0);  
  a = new Agent();
  freqLinePosX= new float[freqs.length];
  freqStrokeWeight= new float[freqs.length];
  freqLinePosY= new float[freqs.length];
  for(int i=0; i<freqs.length; i++){
    freqLinePosX[i] = map(log2(freqs[i]), logLeftFreq, logRightFreq, 0, width);
    if (isWhiteNote[i]){
      freqStrokeWeight[i]=6;      
      freqLinePosY[i]=0;
    }
    else{
      freqStrokeWeight[i]=1;
      freqLinePosY[i]=height/2;}
  }
}

void draw(){
  fill(0,2);
  rect(0,0,width, height);
  stroke(128);
  for(int i=0; i<freqs.length; i++){
    strokeWeight(freqStrokeWeight[i]);
    line(freqLinePosX[i], freqLinePosY[i], freqLinePosX[i], height);
  }
  
  fill(255);
  ellipse(mouseX, mouseY, 3,3);
  a.action();
}
