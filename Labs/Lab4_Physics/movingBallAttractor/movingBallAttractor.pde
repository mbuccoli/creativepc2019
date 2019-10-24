AgentMover[] movers;
AgentAttractor A;
int MASS_TO_PIXEL=10;
int Nmovers=10;
float area;
PVector dragForce;
void setup(){
  movers=new AgentMover[Nmovers];
  for (int m=0; m<Nmovers; m++){
    movers[m]=new AgentMover(random(100, 200));
  }
  A=new AgentAttractor(random(800, 1200), width/2., height/2.);  
  size(1280, 720);
  background(0);  
}

void draw(){
  rectMode(CORNER);
  fill(0,10);
  rect(0,0,width, height);
  A.action();
  for (int m=0; m<Nmovers; m++){
    A.applyForce(movers[m]);    
    movers[m].action();
  }
}
