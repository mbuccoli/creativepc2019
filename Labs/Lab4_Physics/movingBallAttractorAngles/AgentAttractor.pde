class AgentAttractor{
  float mass, radius_circle;
  PVector location;
  AgentAttractor(float mass, float x, float y){
    this.mass=mass;
    this.location = new PVector(x,y);
    this.radius_circle=sqrt(this.mass/PI)*MASS_TO_PIXEL;
  }
  void action(){
    fill(200, 0, 200, 10);
    //this.location.x=mouseX;
    //this.location.y=mouseY;
    ellipse(this.location.x, this.location.y, this.radius_circle, this.radius_circle);
  }
  void applyForce(AgentMover M){
    PVector attr_force=this.location.copy();
    attr_force.sub(M.location);
    float dist=attr_force.mag();
    dist=constrain(dist, 50,100);
    attr_force.normalize(); 
    attr_force.mult(this.mass*M.mass/(dist*dist));
    M.applyForce(attr_force);       
    // if(drag_force.x!=drag_force.x || drag_force.y!=drag_force.y){exit();}       
  }
}
