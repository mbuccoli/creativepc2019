import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
OscMessage msg;

int port = 12000;

float x = 1270.0;
float y = 720.0;


ParticleSystem ps;
int Nparticles=10000;
void setup(){
  size(1280,720);
  ps=new ParticleSystem();
  
  /* start oscP5, listening for incoming messages at port 12000 */
  //...
  
  for(int p=0; p<Nparticles; p++){
    ps.addParticle();
  }
  background(0);
}

void draw(){
  background(0);
  
  ps.origin=new PVector(x, y);
  ps.action();
}


        
    
    /* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage message) {
  //...
  
}
