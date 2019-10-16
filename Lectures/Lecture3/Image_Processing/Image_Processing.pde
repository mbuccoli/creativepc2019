
PImage img;


void setup(){
  size(800,600); 
  img = loadImage("lamp.jpg");
}



void draw(){
    background(0);
    tint(255,mouseX,mouseY);
    image(img,0,0,width,height);
    
    /*
    img.loadPixels();
    for (int x=0;x<100;x++){
      for (int y=0;y<100;y++){
        int loc = x + y*100;
        img.pixels[loc] = 0;  
      }
    }
    img.updatePixels();*/
    
    
}
