int RADIUS_CIRCLE=50;
int LIMIT_VELOCITY=50;
int CONSTANT_ACC=2;

class AgentMover{
  PVector location, velocity, acceleration;
  float mass;
  AgentMover(){
    this.location= new PVector(random(0, width), random(0, height));
    this.velocity = new PVector(random(-2, 2), random(-2, 2));
    this.acceleration = new PVector(random(2), random(2));
    this.mass=1;
  }
  void planning(){    
    PVector delta = new PVector(mouseX, mouseY);
    delta.sub(this.location);
    delta.normalize();
    delta.mult(CONSTANT_ACC);
    this.acceleration.add(delta);
    
    this.velocity.add(this.acceleration);
    this.velocity.limit(LIMIT_VELOCITY);
    this.location.add(this.velocity);
    this.acceleration.mult(0);
  }
  
  void applyForce(PVector force){
    this.acceleration.add(PVector.div(force, mass));
  }
  void action(){
    this.planning();
    fill(200);
    ellipse(this.location.x, this.location.y, RADIUS_CIRCLE, RADIUS_CIRCLE);
    
  
  }

}
