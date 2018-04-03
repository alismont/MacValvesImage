
PImage photo;
PrintWriter output;
boolean fin=true;
boolean flag=false;
int i;
String line = null;
int Index=0;
int[] cx = new int[10000];
int[] cy = new int[10000];

// Points de soudures
//HG haut gauche; HD haut droit ; BG bas gauche ; BD bas droit
int[] HGx = new int[100];
int[] HGy = new int[100];
int[] HDx = new int[100];
int[] HDy = new int[100];
int[] BGx = new int[100];
int[] BGy = new int[100];
int[] BDx = new int[100];
int[] BDy = new int[100];

int PasAPas = 1;

float r;
float g;
float b;
float Tot;
//---------------SETUP-----------------------------
void setup() {
    size(3872, 2592);
  surface.setLocation(3872,2592); 
  surface.setTitle("Sunlight Calculator"); 
  surface.setResizable(true);  
    photo = loadImage("Lot_pieces.jpg");
 output = createWriter("data/positions.txt");
}

//----------------DRAW----------------------------
void draw() {
      image(photo, 0, 0);
  //color pink = color(255, 102, 204);
  //loadPixels();


//Gestion des 50 pièces

  // Lecture fichier-> coordonnées pixels sur cercle
   parseFile(); 
  

  
// Lecture des pixels pour écriture -> fichier (r,g,b,tot)
// Du haut vers la gauche contraire mouvement horloge
  for (int ii =0; ii < Index; ii++) {
    color a = photo.get(cx[ii],cy[ii]);
       r = red(a);
       g = green(a);
       b = blue(a);
     println (r);
           println (g);
                println (b);
                  println(r+g+b);
                  Tot=r+g+b;
                    output.println(r + " " + g+" "+ b +" "+ Tot); // ici on a légèrement modifié
  }
 output.flush(); // Writes the remaining data to the file
 output.close(); // Finishes the file
 
 // Traitement tableau positions; trouver les 4 points de colle
 

// Séquence trouver points de colles
//reset valeurs
HGx[1]=0;HGy[1]=0;
BGx[1]=0;BGy[1]=0;
HDx[1]=0;HDy[1]=0;
BDx[1]=0;BDy[1]=0;


while ((BGx[1]==0 || BDx[1]==0 || HDx[1]==0 || HGx[1]==0  )) {   
switch(PasAPas) {
  case 1: 
  println("PAS 1");
       color a = photo.get(cx[0],cy[0]);
       r = red(a);
       g = green(a);
       b = blue(a);
         if (r>150 & g>150 & b>150) { // sur la pièce
          //excécution sous-séquence 10 recherche point HG tourner vers la gauche
          PasAPas=10;
         }
       // confirmation
       a = photo.get(cx[5],cy[5]);
       r = red(a);
       g = green(a);
       b = blue(a);
         if (r>150 & g>150 & b>150) { // sur la pièce
          //excécution sous-séquence 10 recherche point HG tourner vers la gauche
          PasAPas=10;
                    println("VERS PAS 10"); 
         }
          PasAPas=20;         
                    println("VERS PAS 20"); 
    break;
  case 10: 
    println("PAS 10");
          HGx[1] = 0;HGy[1]=0;Index=0;
          while (HGx[1]==0 & HGy[1]==0) {
            Index=Index+1;
             a = photo.get(cx[Index],cy[Index]);
             r = red(a);
             g = green(a);
             b = blue(a);
                if (r<100 & g<100 & b<100) {
                  HGx[1]=cx[Index];HGy[1]=cy[Index];
                }
          }
          PasAPas=11;
                    println("VERS PAS 11"); 
    break;
case 11:
    println("PAS 11");
          //BGx[1] = 0;BGy[1]=0;Index=0;
          while (BGx[1]==0 & BGy[1]==0) {
            Index=Index+1;
             a = photo.get(cx[Index],cy[Index]);
             r = red(a);
             g = green(a);
             b = blue(a);
                if (r>100 & g>100 & b>100) {
                  BGx[1]=cx[Index];BGy[1]=cy[Index];
                }
          }
           // Suite sous programme 20 recherche point BD dans le même sens
          PasAPas=12;
              println("VERS PAS 12");
    break;  
  case 12: 
    println("PAS 12");
          //BDx[1] = 0;BDy[1]=0;//Index=0;
          while (BDx[1]==0 & BDy[1]==0) {
            Index=Index+1;
             a = photo.get(cx[Index],cy[Index]);
             r = red(a);
             g = green(a);
             b = blue(a);
                if (r<100 & g<100 & b<100) {
                  BDx[1]=cx[Index];BDy[1]=cy[Index];
                }
          }
          PasAPas=13;
          println("VERS PAS 13");  
case 13:
    println("PAS 13");
          //BGx[1] = 0;BGy[1]=0;Index=0;
          while (HDx[1]==0 & HDy[1]==0) {
            Index=Index+1;
             a = photo.get(cx[Index],cy[Index]);
             r = red(a);
             g = green(a);
             b = blue(a);
                if (r>100 & g>100 & b>100) {
                  HDx[1]=cx[Index];HDy[1]=cy[Index];
                }
          }
    break;           
  case 20: 
    println("PAS 20");
          BGx[1] = 0;BGy[1]=0;Index=0;
          while (BGx[1]==0 & BGy[1]==0) {
            Index=Index+1;
             a = photo.get(cx[Index],cy[Index]);
             r = red(a);
             g = green(a);
             b = blue(a);
                if (r>100 & g>100 & b>100) {
                  BGx[1]=cx[Index];BGy[1]=cy[Index];
                }
          }
           // Suite sous programme 20 recherche point BD dans le même sens
          PasAPas=21;
              println("VERS PAS 21");
    break;
    
  case 21: 
    println("PAS 21");
          BDx[1] = 0;BDy[1]=0;//Index=0;
          while (BDx[1]==0 & BDy[1]==0) {
            Index=Index+1;
             a = photo.get(cx[Index],cy[Index]);
             r = red(a);
             g = green(a);
             b = blue(a);
                if (r<100 & g<100 & b<100) {
                  BDx[1]=cx[Index];BDy[1]=cy[Index];
                }
          }
           // Suite sous programme 20 recherche point BD dans le même sens
          PasAPas=22;
          println("VERS PAS 22");
    break;  
    
  case 22: 
    println("PAS 22");
          HDx[1] = 0;HDy[1]=0;//Index=0;
          while (HDx[1]==0 & HDy[1]==0) {
            Index=Index+1;
             a = photo.get(cx[Index],cy[Index]);
             r = red(a);
             g = green(a);
             b = blue(a);
                if (r>100 & g>100 & b>100) {
                  HDx[1]=cx[Index];HDy[1]=cy[Index];
                }
          }
           // Suite sous programme 20 recherche point BD dans le même sens
          PasAPas=23;
          println("VERS PAS 23");
    break; 
    
  case 23: 
    println("PAS 23");
          HGx[1] = 0;HGy[1]=0;//Index=0;
          while (HGx[1]==0 & HGy[1]==0) {
            Index=Index+1;
             a = photo.get(cx[Index],cy[Index]);
             r = red(a);
             g = green(a);
             b = blue(a);
                if (r<100 & g<100 & b<100) {
                  HGx[1]=cx[Index];HGy[1]=cy[Index];
                }
          }
    break;      
    }

  }
 println("Point BG pièce 1");
 print(BGx[1] +" ");
 println(BGy[1]);
 
 println("Point BD pièce 1");
 print(BDx[1] +" ");
 println(BDy[1]);
 
 println("Point HD pièce 1");
 print(HDx[1] +" ");
 println(HDy[1]);
 
 println("Point HG pièce 1");
 print(HGx[1] +" ");
 println(HGy[1]);
 
exit();
}

//----------------------------------
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
      color a = photo.get(xPos,yPos);
       r = red(a);
       g = green(a);
       b = blue(a);
        SommeColor=r+g+b;
       a = photo.get(xPos-1,yPos);
       r = red(a);
       g = green(a);
       b = blue(a);
        SommeColor=(SommeColor+r+g+b)/2;      
       a = photo.get(xPos-1,yPos+1);
       r = red(a);
       g = green(a);
       b = blue(a);
        SommeColor=(SommeColor+r+g+b)/2;        
       a = photo.get(xPos,yPos-1);
       r = red(a);
       g = green(a);
       b = blue(a);
        SommeColor=(SommeColor+r+g+b)/2;         
       a = photo.get(xPos+1,yPos-1);
       r = red(a);
       g = green(a);
       b = blue(a);
        SommeColor=(SommeColor+r+g+b)/2;         
       a = photo.get(xPos+1,yPos);
       r = red(a);
       g = green(a);
       b = blue(a);
        SommeColor=(SommeColor+r+g+b)/2;
       a = photo.get(xPos,yPos+1);
       r = red(a);
       g = green(a);
       b = blue(a);
        SommeColor=(SommeColor+r+g+b)/2;  
       a = photo.get(xPos-1,yPos+1);
       r = red(a);
       g = green(a);
       b = blue(a);
        SommeColor=(SommeColor+r+g+b)/2; 
       a = photo.get(xPos+1,yPos+1);
       r = red(a);
       g = green(a);
       b = blue(a);
        SommeColor=(SommeColor+r+g+b)/2;  
       
        return ceil(SommeColor);        
  }
}

//******************************************************
void keyPressed() { // Press a key to save the data

}