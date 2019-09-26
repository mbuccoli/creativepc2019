

boolean blocked = false; 
float x=0;
float y=0;

void setup(){
  size(400,400);
  println(width);
  background(255,255,255);
  frameRate(10);
}


void draw(){  
  fill(255,20,0, 200);
  circle(x,y,10);
  fill(0,255,0,100);
  rect(x+10,y+10,30,50);
  
  x=randomVal();
  y=random(0,height);
}

float randomVal()
{
  float val = random(0,width);
  return val;
}

void mousePressed(){
  
  if (blocked==true){
    blocked = false;
    loop();
  }
  else if (blocked==false){
    blocked = true;
    noLoop();
  }
}
