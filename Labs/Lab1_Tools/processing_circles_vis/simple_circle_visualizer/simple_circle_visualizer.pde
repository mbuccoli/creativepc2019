Agent[] agents;
float t=0;
float frameRateHz=60;
int nAgents=50;
int ALPHA_BG=100;
int ALPHA_ELEMS=90;
float RADIUS=50;

void setup(){
  size(1280,720);
  background(0);
  frameRate(frameRateHz);
  agents = new Agent[nAgents];
  for (int a=0; a<nAgents; a++){
       agents[a]= new Agent(); //<>//
  }
}

void draw(){
  t+=1/frameRateHz;
  
  fill(0,0,0,ALPHA_BG);
  rect(0,0,width,height);
  for (int a=0; a<nAgents; a++){
      agents[a].action(t);          
  }
}
