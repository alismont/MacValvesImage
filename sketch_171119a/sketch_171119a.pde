PImage img;

void setup() {
  size(3872,2592);
  // Images must be in the "data" directory to load correctly
  img = loadImage("DSC_1206.JPG");
}

void draw() {
  image(img, 0, 0);
}