OpenSimplexNoise noise;
PImage img;
float rad=1.0,scale=.02;
int numFrames=75;
void setup(){
  img=loadImage("TenStories.jpg");
  surface.setSize(img.width,img.height);
  noise=new OpenSimplexNoise();
}
void draw(){
  set(0,0,img);
  loadPixels();
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      boolean[] vals=new boolean[3];
      for(int i=0;i<vals.length;i++){
        float t=1.0*(frameCount-10*i)/numFrames;
        vals[i]=noise.eval(scale*x,scale*y,rad*cos(t*2*(float)Math.PI),rad*sin(t*2*(float)Math.PI))>0;
      }
      color c=pixels[x+width*y];
      c=color(vals[0]?red(c):0,vals[1]?green(c):0,vals[2]?blue(c):0);
      pixels[x+width*y]=c;
    }
  }
  updatePixels();
  if(frameCount<=numFrames)
    saveFrame("###.png");
  if(frameCount==numFrames)
    stop();
}