int PORT = 57120;
float[] range_freq={220, 880}; // two octaves


float[] freqs={130.81, 138.59, 146.83, 155.56, 164.81, 174.61,
            185, 196, 207.65, 220, 233.08, 246.94, 261.63,
             277.18, 293.66, 311.13, 329.63, 349.23,  369.99, 
           392, 415.3, 440, 466.16, 493.88, 523.25};


float Y_RATIO = 5;           
boolean[] isWhiteNote={true, false, true, false, true, true, false, true, false, true, false, true,true, false, true, false, true, true, false, true, false, true, false, true, true};


void drawKeyboard(float yFactor, float widthNotes){
  // first slide
  stroke(128);
  strokeWeight(3);
  fill(50);
  rect(0, 0, width, yFactor);
  rect(0, height-yFactor, width, yFactor);
  
  float wn=0;
 
  for (int i=0; i<NUM_NOTES; i++){
    if(isWhiteNote[i]){
       fill(0);
       rect(wn*widthNotes, yFactor, widthNotes, height-2*yFactor);
       wn++;
       
    }
  }
  wn=-1;
  for (int i=0; i<NUM_NOTES; i++){
    if(!isWhiteNote[i]){
       fill(20);
       rect((wn+0.5+0.15)*widthNotes, yFactor, 0.7*widthNotes, height-3*yFactor);
       
    }
    else{wn++;}
  } 
  
  
  
  
}


class AgentSlide{
  
  float logLeftNote;
  float logRightNote;
  float[] pix2notes;
  float freq;
  AgentSlide(int numWhiteNotes){
    this.pix2notes=new float[width];    
    this.logLeftNote = log2(freqs[0]);
    this.logRightNote = log2(freqs[NUM_NOTES]);
    this.freq=0;
    float widthNotes = (1.0*width)/numWhiteNotes;    
    int pix_so_far=0;
    float P=widthNotes/2;
    for(int p=0; p<P; p++)
    {
      this.pix2notes[p]=pow(2,map(p, -widthNotes*0.5, widthNotes*0.5, log2(246.94/2), this.logLeftNote));    
    }
    pix_so_far=int(P);
    for (int j=0; j<NUM_NOTES; j++){
      if(isWhiteNote[j] && isWhiteNote[j+1]){ // B-C; E-F
        P= pix_so_far+widthNotes;
      }
      else{
        P= pix_so_far+widthNotes/2;
      }  
      for (int p=pix_so_far; p<P && p<width; p++){
         this.pix2notes[p]=pow(2,map(p, pix_so_far, P, log2(freqs[j]), log2(freqs[j+1])));         
      }
      pix_so_far=(int)P;
    }
    
  }  
  void reasoning(){ ;
    this.freq= this.pix2notes[mouseX];
  }  
  void planning(){;
  }  
  void action(){
  }
}

class AgentKeyboard{
  float[] lX;
  float[] rX;
  float[] uY;
  float[] bY;
  
  float[] cX;
  int oldMouseX;
  int heightWhiteNote;
  int heightBlackNote;
  float widthWhiteNote;
  float widthBlackNote;
  float freq=0;
  float vibr=0;
  float cutoff=0.5;
  AgentKeyboard(float yFactor, float widthNotes){
    this.lX= new float[NUM_NOTES];
    this.rX= new float[NUM_NOTES];
    this.cX= new float[NUM_NOTES];
    
    this.uY= new float[NUM_NOTES];
    this.bY= new float[NUM_NOTES];
    this.oldMouseX=0;
    this.freq=0;
    int wn=0;
    println(yFactor);
    
    for (int i=0; i<NUM_NOTES; i++){
      if(isWhiteNote[i]){
        this.lX[i]=wn*widthNotes;
        this.uY[i]=yFactor;
        this.rX[i]=wn*widthNotes+widthNotes;
        this.bY[i]= height-yFactor;
        /*fill(128,0,0);
        ellipse(this.lX[i],this.uY[i], 10,10);
        ellipse(this.lX[i],this.bY[i], 10,10);
        ellipse(this.rX[i],this.uY[i], 10,10);
        ellipse(this.rX[i],this.bY[i], 10,10);*/
        wn++;       
      }
      else{
        this.lX[i]=(wn-0.5+0.15)*widthNotes;
        this.uY[i]=yFactor;
        this.rX[i] = this.lX[i]+0.7*widthNotes;
        this.bY[i] = height-2*yFactor;      
        /*fill(128,0,0);
        ellipse(this.lX[i],this.uY[i], 10,10);
        ellipse(this.lX[i],this.bY[i], 10,10);
        ellipse(this.rX[i],this.uY[i], 10,10);
        ellipse(this.rX[i],this.bY[i], 10,10);*/
      }
      this.cX[i]=(this.lX[i]+this.rX[i])/2;
    
    }
    this.vibr=0;
    this.cutoff=0.5;
    
    this.heightWhiteNote=(int)(height-2*yFactor);
    this.heightBlackNote=(int)(height-3*yFactor);
    this.widthWhiteNote=widthNotes;
    this.widthBlackNote=0.7*widthNotes;
    this.oldMouseX=-1;
  }  
  void reasoning(){
    int j=-1;
    boolean found=false;
    for(int i=0; i<NUM_NOTES; i++){
        if(isWhiteNote[i]){continue;}      
        if(mouseX>=this.lX[i] &&
           mouseX<=this.rX[i] &&
           mouseY>=this.uY[i] &&
           mouseY<=this.bY[i]){
            j=i; 
            found=true;
            break;
        }    
    }
    if(!found){
      for(int i=0; i<NUM_NOTES; i++){
          if(!isWhiteNote[i]){continue;}      
          if(mouseX>=this.lX[i] &&
             mouseX<=this.rX[i] &&
             mouseY>=this.uY[i] &&
             mouseY<=this.bY[i]){
              j=i; 
              break;
          }    
      }
    
    }
    
    int heightNote = isWhiteNote[j]? this.heightWhiteNote: this.heightBlackNote;
    
    int widthNoteHalf=int(0.5* (isWhiteNote[j]? this.widthWhiteNote: this.widthBlackNote));
    
    this.cutoff = map(mouseY-this.uY[j], 0, heightNote, 10, 0); 
    
    this.vibr = map(mouseX-this.cX[j], -widthNoteHalf, widthNoteHalf, -3, 3); 
    this.freq = freqs[j];
    this.oldMouseX=mouseX;
    
  }  
  void planning(){;
  }  
  void action(){
  }
}

class AgentMain{
  float leftPixel;
  float rightPixel;
  int numWhiteNotes=0;
  AgentSlide as;
  AgentKeyboard ak;
  
  float logLeftNote, logRightNote;
  float widthNotes, yFactor;
  
  int oldTime=0;  
  float ampAttack, ampRelease;
  
  float freq, amp, vibr, cutoff;
  OscP5 oscP5;
  NetAddress location;
  AgentMain(){      
    if (!isWhiteNote[NUM_NOTES-1]){
      NUM_NOTES++;}
     
    for(int i=0; i<NUM_NOTES; i++){
      if(isWhiteNote[i]){
         this.numWhiteNotes++;}
    }
    
    this.widthNotes = width/numWhiteNotes;
    this.yFactor = height/Y_RATIO;
    this.as= new AgentSlide(numWhiteNotes);
    this.ak=new AgentKeyboard(yFactor, this.widthNotes);
    
    this.freq=0;
    this.amp=0;  
    this.vibr=0;
    this.cutoff=0.5;
    
    this.ampAttack = ATTACK_TIME*1000.;
    this.ampRelease= RELEASE_TIME*1000.;
    this.oscP5 = new OscP5(this,55000);
    this.location = new NetAddress("127.0.0.1",PORT);
    this.oldTime=millis();
  }  
  void reasoning(){ 
  }  
  void planning(){;
  }  
  void action(){
    drawKeyboard(this.yFactor, this.widthNotes); //<>//
    if(mousePressed){ 
        this.amp = min(1, this.amp+(millis()-this.oldTime)/this.ampAttack);                        
    }      
   else{ 
        this.amp = max(0, this.amp-(millis()-this.oldTime)/this.ampRelease);                        
    }   
    if(mouseY<this.yFactor || mouseY>height-this.yFactor){
      this.as.reasoning();
      this.freq=as.freq;
      this.vibr=0;
      this.cutoff=0.5;
    }
    else{
      this.ak.reasoning();
      this.freq=this.ak.freq;
      this.vibr=this.ak.vibr;
      this.cutoff=this.ak.cutoff;
    }
    this.reasoning();
    //if(this.amp==0){ return;}
    OscMessage msg = new OscMessage("/seabord");
    msg.add(this.freq);
    msg.add(this.amp);
    msg.add(this.vibr);
    msg.add(this.cutoff);
    println(this.freq, this.amp, this.vibr, this.cutoff);
    this.oldTime=millis();
    this.oscP5.send(msg, this.location);
  }
}
