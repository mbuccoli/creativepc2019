int MAX_POINTS=100;
int RADIUS=20;
class Agent{
  float[] cX;
  float[] cY;
  color[] colors;
  int N=0;
  int[] labels;
  boolean changed=false;
  Agent(){
    this.cX=new float[MAX_POINTS];    
    this.cY=new float[MAX_POINTS];
    this.colors= new color[MAX_POINTS];
    this.labels=new int[MAX_POINTS];
    this.colors[0]=color(unhex("A0A0A0"));
    this.labels[0]=0;
    colorMode(HSB, 100);
    
    for(int i=1; i<MAX_POINTS; i++){
      this.labels[i]=0;
      this.colors[i]=color(random(0,100), random(50,100), random(50,100));      
    }
  }
  void reasoning(OscMessage msg){
    for(int i=0; i<this.N; i++){
      this.labels[i]=msg.get(i).intValue()+1;
    }
    
  }
  void planning(){
    //println(mouseButton==LEFT);
    if (mouseButton==LEFT){ // new point
       this.cX[this.N]=mouseX;
       this.cY[this.N]=mouseY;
       this.N++;
    }
    else if (mouseButton==RIGHT){ // delete 
       int imin=-1;
       float distmin=2*width+2*height;
       float dist;
       for(int i=0; i<this.N; i++){
         dist=pow(mouseX-this.cX[i],2)+pow(mouseY-this.cY[i],2);
         if (dist<RADIUS*RADIUS & dist<distmin){
           imin=i;
           distmin=dist;
         }
       }
       if(imin==-1){return;}
       this.cX[imin]=this.cX[this.N-1];
       this.cY[imin]=this.cY[this.N-1];
       this.N--;
    }
    this.changed=true;
  }
  void action(){
    color c;
    if(this.changed){ // send OSC message
      OscMessage msg = new OscMessage("/cluster");
      for (int i=0; i<this.N; i++){
        msg.add(this.cX[i]);
        msg.add(this.cY[i]);
      }
      oscP5.send(msg, location);
      this.changed=false;
    }
    //println(i, this.cX[i], this.cY[i], this.colors[this.labels[i]]);
        
     for(int i=0; i<this.N; i++){
        
        //fill(255, 255, 255);//
        c= this.colors[this.labels[i]];
        fill(hue(c), saturation(c), brightness(c));
    
        
        //fill();
        circle(this.cX[i], this.cY[i], RADIUS);
     }  
  
  }
}
