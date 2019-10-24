AgentMover M;
Liquid[] liquids;
color[] colors={color(100,0,0), color(0,100,0), color(0,0,100), color(100,0,100)};
float area;
PVector dragForce;
void setup(){
  M=new AgentMover();
  area = 0.001*RADIUS_CIRCLE*PI; // half perimeter
  size(1280, 720);
  background(0);
  liquids=new Liquid[4];
  float x, y;
  for(int l=0; l<liquids.length; l++){
    if(l%2==0){x=0;}
    else{x=width/2;}
    if(l<2){y=0;}
    else{y=height/2;}
    
    liquids[l]=new Liquid(random(0.001,10), random(0.001,10),
                          x, y, width/2., height/2.); 
    }
}

void draw(){
  background(0);
  for(int l=0; l<liquids.length; l++){
    liquids[l].applyForce(M);
    fill(colors[l]);
    rect(liquids[l].x, liquids[l].y, liquids[l].w, liquids[l].h);
  }
  M.action();
  
}
