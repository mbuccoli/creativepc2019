Agent a;
float t=0;
float frameRateHz=60;
int nCirlces=100;
int ALPHA_BG=20;
int ALPHA_ELEMS=20;
float RADIUS=50;

void setup(){
  size(1280,720);
  background(0);
  frameRate(frameRateHz);
  a= new Agent(nCirlces); //<>//
}

void draw(){
  t+=1/frameRateHz;
  a.action(t);
  
  
}
