

Vehicle v,v1,v2;


void setup() {
  size(800, 200);
  v = new Vehicle(width/2, height/2);
  v1 = new Vehicle(0, 0);
  v2 = new Vehicle(200, 200);
  smooth();
}

void draw() {
  if (mousePressed) {
    background(255);

    PVector mouse = new PVector(mouseX, mouseY);

    // Draw an ellipse at the mouse location
    fill(200);
    stroke(0);
    strokeWeight(2);
    ellipse(mouse.x, mouse.y, 48, 48);

    // Call the appropriate steering behaviors for our agents
    v.arrive(mouse);
    v.update();
    v.display();
    v1.arrive(mouse);
    v1.update();
    v1.display();
    v2.arrive(mouse);
    v2.update();
    v2.display();
    
  }
}
