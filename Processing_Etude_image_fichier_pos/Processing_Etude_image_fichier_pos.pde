
PImage a;
PrintWriter output;
boolean fin=true;
boolean flag=false;
int i;
String line = null;
int Index=0;
int[] cx = new int[10000];
int[] cy = new int[10000];
float r;
float g;
float b;
float Tot;
//--------------------------------------------

void mouseClicked() {
  output.println(mouseX +" " + mouseY);
}
//--------------------------------------------
void setup() {
    size(3872, 2592); 
    a = loadImage("Lot_piecesCercle.jpg");
     image(a, 0, 0);
          //image(photo,100, 100, width, height);
 output = createWriter("data/pos.txt");
   

}

void draw() {
//a.resize(width, height);
     //background(a);
      //stroke(226, 204, 0);
  //loadPixels();
////Lecture fichier séquentiel coordonnées des pixels  
//   parseFile(); 
  

  
////Obtenir les pixels
//  for (int ii =0; ii < Index; ii++) {
//    color a = photo.get(cx[ii],cy[ii]);
// //println(pixels[i]);
//       r = red(a);
//       g = green(a);
//       b = blue(a);
//     println (r);
//           println (g);
//                println (b);
//                  println(r+g+b);
//                  Tot=r+g+b;
                  
// // Ecriture dans le fichier positions.txt                 
// output.println(r + " " + g+" "+ b +" "+ Tot); // ici on a légèrement modifié
//  }

     

}

//----------------------------------------------------------------------------------
// Extraction des points à lire du fichier pos.txt
void parseFile() {
  
  // Open the file from the createWriter() example
  BufferedReader reader = createReader("pos.txt");
  String line = null;
  Index=0;
  try {
    while ((line = reader.readLine()) != null) {
      String[] pieces = split(line, TAB);
      cx[Index] = int(pieces[0]);
      cy[Index] = int(pieces[1]);
            //println(cx[Index], cy[Index]);
                  Index=Index+1;
    }
    reader.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
} 



//***********************************

class LectPixels {
  int xPos, yPos;
  int i;
  float SommeColor,r,g,b;
  LectPixels(int x,int y){
    xPos=x;
    yPos=y;
  }
  
  float LecturePixels() { 
    i=xPos+(yPos*500);
      r = red(a.pixels[i]);
      g = green(a.pixels[i]);
      b = blue(a.pixels[i]);
        SommeColor=r+g+b;
    i=(xPos-1)+(yPos*500);
          r = red(a.pixels[i]);
          g = green(a.pixels[i]);
          b = blue(a.pixels[i]);
        SommeColor=(SommeColor+r+g+b)/2;      
    i=(xPos-1)+((yPos-1)*500);
          r = red(a.pixels[i]);
          g = green(a.pixels[i]);
          b = blue(a.pixels[i]);
        SommeColor=(SommeColor+r+g+b)/2;        
    i=(xPos)+((yPos-1)*500);
          r = red(a.pixels[i]);
          g = green(a.pixels[i]);
          b = blue(a.pixels[i]);
        SommeColor=(SommeColor+r+g+b)/2;         
    i=(xPos+1)+((yPos-1)*500);
          r = red(a.pixels[i]);
          g = green(a.pixels[i]);
          b = blue(a.pixels[i]);
        SommeColor=(SommeColor+r+g+b)/2;         
    i=(xPos+1)+((yPos)*500);
          r = red(a.pixels[i]);
          g = green(a.pixels[i]);
          b = blue(a.pixels[i]);
        SommeColor=(SommeColor+r+g+b)/2;
    i=(xPos)+((yPos+1)*500);
          r = red(a.pixels[i]);
          g = green(a.pixels[i]);
          b = blue(a.pixels[i]);
        SommeColor=(SommeColor+r+g+b)/2;  
    i=(xPos-1)+((yPos+1)*500);
          r = red(a.pixels[i]);
          g = green(a.pixels[i]);
          b = blue(a.pixels[i]);
        SommeColor=(SommeColor+r+g+b)/2; 
    i=(xPos+1)+((yPos+1)*500);
          r = red(a.pixels[i]);
          g = green(a.pixels[i]);
          b = blue(a.pixels[i]);
        SommeColor=(SommeColor+r+g+b)/2;  
       
        return ceil(SommeColor);        
  }
}

//******************************************************
void keyPressed() { // Press a key to save the data
 output.flush(); // Writes the remaining data to the file
 output.close(); // Finishes the file
 exit(); // Stops the program
}