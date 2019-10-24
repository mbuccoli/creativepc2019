AgentMover M;
float C_d=0.1;
float rho = 0.1;
float area;
PVector dragForce;
void setup(){
  M=new AgentMover();
  area = 0.001*RADIUS_CIRCLE*PI;
  size(1280, 720);
  background(0);
}

void draw(){
  background(0);
  dragForce = M.velocity.copy();
  float mag2 = M.velocity.mag();
  mag2=mag2*mag2;
  dragForce.normalize();
  dragForce.mult(-0.5*C_d*rho*area*mag2);
  M.applyForce(dragForce);
  M.action();

}
