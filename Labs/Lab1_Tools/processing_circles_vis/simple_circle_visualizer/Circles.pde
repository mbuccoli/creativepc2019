

float[] range_freq={1./20,1./3};//Hz
float pi=(float)Math.PI;
float[] range_omega={range_freq[0]*2*pi,range_freq[1]*2*pi};
float[] range_dist={RADIUS/2,2*RADIUS};
class Circle {  
  float centerX,centerY, posX, posY;
  float omegaX, omegaY, omegaDist,phiX, phiY;  
  float radius;
  float dist;
  float s;
  color c;  
  float T=0;
    
  Circle(float posX, float posY, color c) {   
    this.centerX= posX;
    this.centerY= posY;
    this.c=c;
    this.dist = random(range_dist[0],range_dist[1]);
    this.omegaX = random(range_omega[0],range_omega[1]);
    this.omegaY = random(range_omega[0],range_omega[1]);
    this.phiX=random(0,pi*2);
    this.phiY=random(0,pi*2);
    
    // t = 0
    this.posX=this.centerX + this.dist*(float)Math.cos(this.phiX);
    this.posY=this.centerY + this.dist*(float)Math.cos(this.phiY); 
    
  }
  void update(float t){
    this.posX=this.centerX + this.dist*(float)Math.cos(t*this.omegaX+this.phiX);
    this.posY=this.centerY + this.dist*(float)Math.cos(t*this.omegaX+this.phiY);     
  }
  void draw(float t) {
    this.update(t);    
    noStroke();
    colorMode(HSB);
    fill(hue(this.c), saturation(this.c), brightness(this.c),ALPHA_ELEMS);
    ellipse(this.posX, this.posY, RADIUS, RADIUS);
  }

}
