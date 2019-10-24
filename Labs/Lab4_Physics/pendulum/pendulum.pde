AgentPendulum pendulum;
float G=10;
int MASS_TO_PIXEL=10;
void setup(){
  pendulum=new AgentPendulum(width/2, height/4, height/2, 100);
  size(1280, 720);
  background(0);  
}

void draw(){
  rectMode(CORNER);
  fill(0,50);
  rect(0,0,width, height);
  pendulum.applyForce(-1*G*sin(pendulum.angle)/pendulum.armLength);
  pendulum.action();
  
}
