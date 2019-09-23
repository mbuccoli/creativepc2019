


class Agent{
  int nCircles;
  Circle[] elems;
  Agent(int nCircles){
    this.nCircles=nCircles;
    this.elems = new Circle[nCircles];
    
    float posX;
    float posY;
    color c;
    for (int i=0; i<nCircles; i++){
      posX = random(0.1*width, 0.9*width);
      posY = random(0.1*height, 0.9*height);
      colorMode(HSB, 100); 
      /* we keep high the brightness and saturation and play with hue
         100 means that values are assigned between 0 and 100
      */
      c = color(random(0,100), random(50,100), random(50,100));
      this.elems[i]=new Circle(posX, posY, c);          
    }
  }
  
  void perception(){
  }
  
  void reasoning(){
  }
  
  void planning(){
  }
  
  void action(float t){
    fill(0,0,0,ALPHA_BG);
    rect(0,0,width,height);
    for (int i=0; i<nCircles; i++){
      this.elems[i].draw(t);          
    }
  }

}
