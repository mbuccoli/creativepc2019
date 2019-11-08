
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

// Reference to physics "world" (2D)
VerletPhysics2D physics;

// Our "Chain" object
Chain chain;

void setup() {
  size(800, 200);
  smooth();

  // Initialize the physics world
  physics=new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.1)));
  physics.setWorldBounds(new Rect(0, 0, width, height));

  // Initialize the chain
  chain = new Chain(180, 20, 16, 0.2);
}

void draw() {
  background(255);

  // Update physics
  physics.update();
  // Update chain's tail according to mouse location 
  chain.updateTail(mouseX, mouseY);
  // Display chain
  chain.display();
}

void mousePressed() {
  // Check to see if we're grabbing the chain
  chain.contains(mouseX, mouseY);
}

void mouseReleased() {
  // Release the chain
  chain.release();
}
