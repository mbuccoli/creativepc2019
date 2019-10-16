
class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  // The Mover's maximum speed
  float topspeed;

  Mover() {
    // Start in the center
    location = new PVector(random(width),random(height));
    velocity = new PVector(0,0);
    topspeed = 5;
  }

  void update() {
    
    // Compute a vector that points from location to mouse
    PVector mouse = new PVector(mouseX,mouseY);
    PVector acceleration = PVector.sub(mouse,location);    //Direction of the acceleration vector

    acceleration.normalize();    //Magnitude of the acceleration
    acceleration.mult(0.2);
    
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127,200);
    ellipse(location.x,location.y,48,48);
  }

}
