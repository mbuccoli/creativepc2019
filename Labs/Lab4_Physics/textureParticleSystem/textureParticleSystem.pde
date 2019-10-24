ParticleSystem ps;
int Nparticles=10000;
PImage img;
void setup(){
  size(1280,720, P2D);
  ps=new ParticleSystem();
  for(int p=0; p<Nparticles; p++){
    ps.addParticle();
  }
  img=loadImage("../data/texture.png");
  background(0);
}

void draw(){
    blendMode(ADD);

  background(0);
  ps.action();
}
