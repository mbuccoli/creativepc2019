
import oscP5.*;
import netP5.*;
  

Agent a; 
void setup(){
  size(1280, 720);
  background(0);  
  a = new Agent();
}

void draw(){
  fill(0,2);
  rect(0,0,width, height);
  fill(255);
  ellipse(mouseX, mouseY, 3,3);
  a.action();
}
