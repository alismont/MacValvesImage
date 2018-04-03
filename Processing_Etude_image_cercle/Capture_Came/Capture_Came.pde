import processing.video.*;
Capture webcam;
int camW = 1280;
int camH = 720;
int stageW = 1280;
int stageH = 720;
void setup()
{
  size(1080,720);
  smooth();
  println(Capture.list());//prints out available cameras
  webcam = new Capture(this, camW, camH, "FaceTime HD Camera (Built-in)", 30);
  webcam.start();
   
}
void draw(){
   
  background(255);
  image(webcam,0,0);
}
void captureEvent(Capture webcam)
{
  webcam.read();
}