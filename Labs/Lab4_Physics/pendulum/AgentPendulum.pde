
class AgentPendulum{
  PVector pivotLocation, massLocation;
  float angle, aVelocity, aAcceleration;
  float armLength, mass, radius_circle;
  
  AgentPendulum(float x, float y, float armLength, float mass){
    this.pivotLocation = new PVector(x, y);
    this.angle=random( -PI/2, -PI/4);
    println(angle);
    this.armLength=armLength;
    this.mass=mass;
    this.aVelocity=0;
    this.aAcceleration=0;
    this.massLocation = new PVector(0, 0);
    this.radius_circle=sqrt(this.mass/PI)*MASS_TO_PIXEL;    
  }
  void planning(){    
    this.aVelocity+=this.aAcceleration;
    this.angle+=this.aVelocity;
    this.aAcceleration=0;
    this.massLocation.set(this.armLength*sin(this.angle), this.armLength*cos(this.angle));
    this.massLocation.add(this.pivotLocation);
  }
  
  void applyForce(float force){    
    this.aAcceleration+=force/this.mass;    
  }
  void action(){
    
    this.planning();    
    fill(200);
    ellipse(this.pivotLocation.x, this.pivotLocation.y, 5,5);
    stroke(255);
    strokeWeight(5);
    line(this.pivotLocation.x, this.pivotLocation.y, 
         this.massLocation.x, this.massLocation.y);       
    noStroke();
    ellipse(this.massLocation.x, this.massLocation.y, 
              this.radius_circle, this.radius_circle);
    
  }
}
