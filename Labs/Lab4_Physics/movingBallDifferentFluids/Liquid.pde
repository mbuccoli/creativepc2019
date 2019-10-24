class Liquid{
  float rho, C_d, x, y, w, h;
  Liquid(float rho, float C_d, float x, float y, float w, float h){
    this.rho=rho;
    this.C_d=C_d;
    this.x=x; this.y=y;
    this.w=w; this.h=h;
    println("Created liquid with rho ", this.rho, " and Cd ", this.C_d);
  }
  boolean isInside(AgentMover M){
    if(M.location.x<this.x){return false;}    
    if(M.location.x>this.x+this.w){return false;}    
    if(M.location.y<this.y){return false;}    
    if(M.location.y<this.y+this.h){return false;}
    return true;
  }
  void applyForce(AgentMover M){
    if(!this.isInside(M)){return;}
       PVector drag_force=M.velocity.copy();
       float mag=drag_force.mag();
       drag_force.normalize();       
       drag_force.mult(-0.5*area*this.C_d*this.rho*mag);       
       M.applyForce(drag_force);       
       // if(drag_force.x!=drag_force.x || drag_force.y!=drag_force.y){exit();}       
  }
}
