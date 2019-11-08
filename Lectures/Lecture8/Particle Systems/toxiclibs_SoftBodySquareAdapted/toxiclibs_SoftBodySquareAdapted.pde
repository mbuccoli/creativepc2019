
import toxi.physics2d.behaviors.*;
import toxi.physics2d.*;

import toxi.geom.*;
import toxi.math.*;

VerletPhysics2D physics;

Blanket b;


void setup() {
  size(800,240);
  smooth();
  physics=new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior(new Vec2D(0,0.1)));

  b = new Blanket();
}

void draw() {

  background(255);

  physics.update();

  b.display();
}
