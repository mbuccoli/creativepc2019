int RADIUS_CIRCLE=50;
int LIMIT_VELOCITY=10;
int sign(float x){
  if(x>0){return 1;}
  if(x<0){return -1;}
  return 0;
}

class AgentMover{
  PVector location, velocity, acceleration;
  
  AgentMover(){
    this.location= new PVector(random(0, width), random(0, height));
    this.velocity = new PVector(random(-2, 2), random(-2, 2));
    this.acceleration = new PVector(random(2), random(2));
  }
  void planning(){    
    println(this.velocity);
    this.velocity.add(this.acceleration);
    this.velocity.limit(LIMIT_VELOCITY);
    this.location.add(this.velocity);
    
    if(this.location.x<0 || this.location.x>width){      
      this.velocity.x=-0.5*abs(this.velocity.x)*sign(this.location.x);
      this.acceleration.x*=-1;
      println("bouncing",this.velocity);
    }
    if(this.location.y<0 || this.location.y>height){      
      this.velocity.y=-0.5*abs(this.velocity.y)*sign(this.location.y);
      this.acceleration.y*=-1;
      println("bouncing",this.velocity);
    }
    
  }
  void action(){
    this.planning();
    fill(200);
    ellipse(this.location.x, this.location.y, RADIUS_CIRCLE, RADIUS_CIRCLE);
    
  
  }

}
