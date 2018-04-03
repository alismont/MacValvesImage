PrintWriter output;
PImage photo;
PrintWriter output;
boolean fin=true;
boolean flag=false;
int c,x,y,i;

void setup() {
      size(3872, 2592);
  surface.setLocation(3872,2592); 
  surface.setTitle("Sunlight Calculator"); 
  surface.setResizable(true);  
    photo = loadImage("Lot_pieces.jpg");
 output = createWriter("data/pointsCercle.txt");
  
}

void draw() {
 point(mouseX, mouseY);
 output.println(mouseX + " " + mouseY); // ici on a légèrement modifié
}

void keyPressed() {
 output.flush(); // Writes the remaining data to the file
 output.close(); // Finishes the file
 exit(); // Stops the program
}