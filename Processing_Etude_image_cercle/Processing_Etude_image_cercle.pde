import processing.video.*;
PImage img;
PrintWriter output;




void setup() {
   size(3872, 2592);
   //  smooth(); 
    img = loadImage("data/Lot_piecesCercle.JPG");
 output = createWriter("data/positions.txt");
   //loadPixels();
}

void draw() {
    //background(255);
      image(img, 0, 0);
  point(mouseX, mouseY);
 output.println(mouseX + " " + mouseY); // ici on a légèrement modifié

}
//***********************************

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
 output.flush(); // Writes the remaining data to the file
 output.close(); // Finishes the file
 exit(); // Stops the program
    } 
  }
}