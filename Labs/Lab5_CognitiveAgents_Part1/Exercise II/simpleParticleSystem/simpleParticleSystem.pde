import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
OscMessage msg;

int port = 12000;

float x ;
float y;


ParticleSystem ps;
int Nparticles=10000;
void setup(){
  size(1280,720);
  ps=new ParticleSystem();
  
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, port);
  
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
  message.print();
  if(message.checkAddrPattern("/coords")==true) {
    /* check if the typetag is the right one. -> expecting float (pitch),float (roll), float (yaw)*/
    //if(message.checkTypetag("ff")) {
      x = message.get(0).floatValue();
      y  = message.get(1).floatValue();
    //}
  }
}
