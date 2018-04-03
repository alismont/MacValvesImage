include LectPixels
PImage photo;

boolean fin=true;
boolean flag=false;
int c,x,y,i;

LectPixels EnHautVertical=new LectPixels(250,161);

void setup() {
    size(500, 666);
  surface.setLocation(500,666); 
  surface.setTitle("Sunlight Calculator"); 
  surface.setResizable(true);  
    photo = loadImage("image2.jpg");

}

void draw() {
      image(photo, 0, 0);
  color pink = color(255, 102, 204);
  loadPixels();
  x=250;
  y=161;
  //for (int i =0; i < (500*666); i++) {
  i=x+y*500;

  println(pixels[i]);
        float r = red(photo.pixels[i]);
      float g = green(photo.pixels[i]);
      float b = blue(photo.pixels[i]);
      println (r);
            println (g);
                  println (b);
                    println(r+g+b);
//}
      print(EnHautVertical.LecturePixels());


updatePixels();

while (fin){}
}