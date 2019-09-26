PImage img;
int smallPoint, largePoint;

void setup() {
  size(1024, 576);
  frameRate(60);
  
  img = loadImage("40704.jpg");
  
  smallPoint = 4;
  largePoint = 40;
  imageMode(CENTER);
  noStroke();
  background(255);
}

void draw() { 
  //image(img,0,0);
  float pointillize = map(mouseX, 0, width, smallPoint, largePoint);
  int x = int(random(img.width));
  int y = int(random(img.height));
  color pix = img.get(x, y);
  println(pix);
  fill(pix, 128);
  ellipse(x, y, pointillize, pointillize);
}
