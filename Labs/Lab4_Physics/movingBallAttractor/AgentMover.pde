
class AgentMover{
  PVector location, velocity, acceleration;
  float mass, radius_circle;
  AgentMover(float mass){
    this.location= new PVector(random(0, width), random(0, height));
    this.velocity = new PVector(random(-2, 2), random(-2, 2));
    this.acceleration = new PVector(random(2), random(2));
    this.mass=mass;
    this.radius_circle=sqrt(this.mass/PI)*MASS_TO_PIXEL;
  }
  void planning(){    
    this.velocity.add(this.acceleration);
    this.location.add(this.velocity);
    this.acceleration.mult(0);
  }
  
  void applyForce(PVector force){    
    this.acceleration.add(PVector.div(force, this.mass));
    
  }
  void action(){
    this.planning();    
    fill(200);
    noStroke();
    ellipse(this.location.x, this.location.y, this.radius_circle, this.radius_circle);
    
  }
}
