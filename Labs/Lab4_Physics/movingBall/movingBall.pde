AgentMover M;

void setup(){
  M=new AgentMover();
  size(1280, 720);
  background(0);
}

void draw(){
  background(0);
  M.action();

}
