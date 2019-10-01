Agent a;
import oscP5.*;
import netP5.*;


OscP5 oscP5;
NetAddress location;


void setup(){
  size(1280, 720);
  a = new Agent();
  oscP5 = new OscP5(this,57121);
  location = new NetAddress("127.0.0.1",57120);
      
}

void draw(){
  fill(0);
  rect(0,0,width, height);
  a.action();
}

void mouseClicked(){
  a.planning();
}

void oscEvent(OscMessage msg) {
  /* print the address pattern and the typetag of the received OscMessage */
  a.reasoning(msg);
}
