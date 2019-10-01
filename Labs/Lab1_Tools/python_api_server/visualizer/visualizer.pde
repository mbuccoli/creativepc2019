import http.requests.*;

String api="http://zabucco.pythonanywhere.com/get_colors";

float refreshRate=60; // Hz
float colorSec=3;
float refresh=colorSec*refreshRate;
float radius = 50;
color c=#ffffff;
int r=0;

GetRequest req;

int ALPHADRAW=10;

void setup(){
  size(1280,720);
  background(0);
  frameRate(refreshRate);
  req = new GetRequest(api);
  fill(0,0,0,ALPHADRAW);
  rect(0,0,width,height); // all space
  
}

void updateCircles(){
  println("refreshing");
  req.send();
  //println("Response Content: " + req.getContent());
  JSONObject obj = parseJSONObject(req.getContent());
  JSONArray users = obj.getJSONArray("users");  
  
  println("found %d users", users.size());
  for(int u=0; u<users.size(); u++){
    JSONObject user=users.getJSONObject(u);
    JSONArray posJSON=user.getJSONArray("pos");
    float posX=width*(posJSON.getFloat(0)*0.8+0.1); // it ranges 10% to 90% of the screen
    float posY=height*(posJSON.getFloat(1)*0.8+0.1);
    color col = unhex(user.getString("color"));
    fill(red(col), green(col), blue(col));
    ellipse(posX, posY, radius, radius);
    println("fill", red(col), green(col), blue(col));
    print("ellipse",posX, posY, radius, radius);
  }
}

void draw(){
  r=r+1;
  fill(0,0,0,ALPHADRAW);
  //rect(0,0,width,height); // all space
  if(r>refresh){
    r=0;
    updateCircles();
  }/*
  fill(255,0,255);
  ellipse(460, 557, r, r);
    */
}
