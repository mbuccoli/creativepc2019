
import oscP5.*;
import netP5.*;

AgentMain am;
int NUM_NOTES=20;

float ATTACK_TIME=0.01;
float RELEASE_TIME=0.5;

int ALPHADRAW=50;
int ALPHA_BG=0;  
  
float log2(float d) {
      return (float) (log((float)d)/log(2.0));
}

void setup(){
  size(1280, 720);
  background(0);  
  am = new AgentMain();
  
}

void draw(){
  
  fill(0,ALPHADRAW);
  rect(0,0,width, height);
  am.action();
  
  fill(128);
  if(mousePressed){
     ellipse(mouseX, mouseY, 6,6);
  }
}
