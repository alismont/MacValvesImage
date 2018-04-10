
PImage photo;
PrintWriter outputA,outputR,outputG,outputB,outputT;
PrintWriter outputX,outputY;
boolean fin=true;
boolean flag=false;
int i;
String line = null;
int Index=0;
int IndexRelatif=0;
int memoBoucle;

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

int[] HGxD = new int[100];
int[] HGyD = new int[100];
int[] HDxD = new int[100];
int[] HDyD = new int[100];
int[] BGxD = new int[100];
int[] BGyD = new int[100];
int[] BDxD = new int[100];
int[] BDyD = new int[100];

int PasAPas = 1;
int PasAPasD = 1;

float r;
float g;
float b;
float Tot;
float rMax,rMin;
float gMax,gMin;
float bMax,bMin;
float rMoy,gMoy,bMoy;
float MoyTot;
int NbrPoints;

//Etude Date:06-04-2018
//  Tableau des coordonnées polaire de chaque pièce, valeurs constante
int[] CentrePieces_CoordX0 = new int[100];
int[] CentrePieces_CoordY0 = new int[100];
int[] CerclePieces_CoordX = new int[30000];
int[] CerclePieces_CoordY = new int[30000];
float[] ColorPixel_r = new float[30000];
float[] ColorPixel_g = new float[30000];
float[] ColorPixel_b = new float[30000];
float[] ColorPixel_a = new float[30000];
int Rayon=32;// rayon en nombre de pixels
int x0,y0,x,y;
float Moyenne_R=0;
float Moyenne_G=0;
float Moyenne_B=0;
float Min_Color_R=10000;
float Min_Color_G=10000;
float Min_Color_B=10000;
float Max_Color_R=-10000;
float Max_Color_G=-10000;
float Max_Color_B=-10000;

int Point1_TrouX=0,Point1_TrouY=0;
int Point2_TrouX=0,Point2_TrouY=0;
int Points=0;
int boucle=0;
     color black = color(0);
//---------------SETUP-----------------------------
void setup() {
    size(2592, 3872);

 //Etude Date:06-04-2018
 
 photo = loadImage("Lot_pieces.jpg");

 CentrePieces_CoordX0[1]=1064;CentrePieces_CoordY0[1]=742;
   outputA = createWriter("data/PointsColor_a_Pixels.txt");
  outputR = createWriter("data/PointsColor_r_Pixels.txt");
  outputG = createWriter("data/PointsColor_g_Pixels.txt");
  outputB = createWriter("data/PointsColor_b_Pixels.txt");
    outputT = createWriter("data/PointsRADIAN_t_Pixels.txt");
    outputX = createWriter("data/Points_x_Pixels.txt");
     outputY = createWriter("data/Points_y_Pixels.txt");
     


}

//----------------DRAW----------------------------
void draw() {
      image(photo, 0, 0);
      //filter(GRAY);
      filter(INVERT);
      //filter(POSTERIZE, 5);
      //filter(ERODE);
      //filter(DILATE);
//background(photo);
//set(0, 0, photo);


//Calcul des points pixels du cercle pour le radian "t" demandé
//  Formules: 
//    x = x0 + r*cos(t)
//    y = y0 + r*sin(t) 
// Boucle des 50 pièces A FAIRE.....

x0=CentrePieces_CoordX0[1] ;
y0=CentrePieces_CoordY0[1] ;
int inc=0;
for (float t =0; t < 6.2; t=t + 0.001) {
x= ceil(x0 + Rayon * cos(t));
//y= ceil(y0 + Rayon * sin(t));
y = y0-(ceil( y0 + Rayon * sin(t))-y0);
CerclePieces_CoordX[inc]=x;CerclePieces_CoordY[inc]=y;
//Lecture code couleur de chaque point du cercle
color a = photo.get(x,y);
       r = red(a);
       g = green(a);
       b = blue(a);
Moyenne_R=(r+Moyenne_R)/2;
ColorPixel_r[inc]=r;ColorPixel_g[inc]=g;ColorPixel_b[inc]=b;
if (r<=Min_Color_R) Min_Color_R=r;
if (r>=Max_Color_R) Max_Color_R=r;
set(x, y, black);
inc++;

outputA.println(a);
outputR.println(r);
outputG.println(g); 
outputB.println(b); 
outputT.println(t); 
outputX.println(x);
outputY.println(y);
  }
  


 //Faire une boucle pour enregistrer les radian -> valeurs min ppas à pas 
int num = 0;

switch(num) {
  case 0: 
  println("case 0");
         for (boucle =0; boucle < 6201; boucle++) {
           if (ColorPixel_r[boucle] <= Min_Color_R+5){
               Point1_TrouX=CerclePieces_CoordX[boucle];
                Point1_TrouY=CerclePieces_CoordY[boucle];
               num=1;
               memoBoucle=boucle;
                   break;
           }
         }

  case 1: 
    println("case 1");
         for (boucle =memoBoucle; boucle < 6201; boucle++) {
           if (ColorPixel_r[boucle] > Moyenne_R){
               num=2;
               memoBoucle=boucle;
                   break;
           }
           }

      case 2: 
        println("case 2");
         for (boucle =memoBoucle; boucle <= 6201; boucle++) {
           if (ColorPixel_r[boucle] <= Min_Color_R+5){
               Point2_TrouX=CerclePieces_CoordX[boucle];
                Point2_TrouY=CerclePieces_CoordY[boucle];
               num=0;
               boucle=0;
                   break;
           }
         }

}
 
  println("Moyenne R: "+Moyenne_R);
 println("Minimum R: "+Min_Color_R); 
 println("Maximum R: "+Max_Color_R); 
 
  println("Point1_TrouX: "+Point1_TrouX);
 println("Point1_TrouY: "+Point1_TrouY); 
  println("Point2_TrouX: "+Point2_TrouX);
 println("Point2_TrouY: "+Point2_TrouY); 
 
   outputA.flush(); // Writes the remaining data to the file
 outputA.close(); // Finishes the file
 outputR.flush(); // Writes the remaining data to the file
 outputR.close(); // Finishes the file
  outputG.flush(); // Writes the remaining data to the file
 outputG.close(); // Finishes the file
  outputB.flush(); // Writes the remaining data to the file
 outputB.close(); // Finishes the file
  outputT.flush(); // Writes the remaining data to the file
 outputT.close(); // Finishes the file
   outputX.flush(); // Writes the remaining data to the file
 outputX.close(); // Finishes the file
   outputY.flush(); // Writes the remaining data to the file
 outputY.close(); // Finishes the file
 
 

exit();

}

//******************************************************************************************************************************************************************************************************
//void parseFile() {
//  BufferedReader reader = createReader("data/pos.txt");
//  String line = null;
//  Index=0;
//  try {
//    while ((line = reader.readLine()) != null) {
//      String[] pieces = split(line, TAB);
//                  println(Index);
//      cx[Index] = int(pieces[0]);
//      cy[Index] = int(pieces[1]);

//                  Index=Index+1;
//    }
//    reader.close();
//    NbrPoints=Index;
//  } catch (IOException e) {
//    e.printStackTrace();
//  }
//} 



////***********************************

//class LectPixels {
//  int xPos, yPos;
//  int i;
//  float SommeColor,r,g,b;
//  LectPixels(int x,int y){
//    xPos=x;
//    yPos=y;
//  }
  
//  float LecturePixels() { 
//      color a = photo.get(xPos,yPos);
//       r = red(a);
//       g = green(a);
//       b = blue(a);
//        SommeColor=r+g+b;
//       a = photo.get(xPos-1,yPos);
//       r = red(a);
//       g = green(a);
//       b = blue(a);
//        SommeColor=(SommeColor+r+g+b)/2;      
//       a = photo.get(xPos-1,yPos+1);
//       r = red(a);
//       g = green(a);
//       b = blue(a);
//        SommeColor=(SommeColor+r+g+b)/2;        
//       a = photo.get(xPos,yPos-1);
//       r = red(a);
//       g = green(a);
//       b = blue(a);
//        SommeColor=(SommeColor+r+g+b)/2;         
//       a = photo.get(xPos+1,yPos-1);
//       r = red(a);
//       g = green(a);
//       b = blue(a);
//        SommeColor=(SommeColor+r+g+b)/2;         
//       a = photo.get(xPos+1,yPos);
//       r = red(a);
//       g = green(a);
//       b = blue(a);
//        SommeColor=(SommeColor+r+g+b)/2;
//       a = photo.get(xPos,yPos+1);
//       r = red(a);
//       g = green(a);
//       b = blue(a);
//        SommeColor=(SommeColor+r+g+b)/2;  
//       a = photo.get(xPos-1,yPos+1);
//       r = red(a);
//       g = green(a);
//       b = blue(a);
//        SommeColor=(SommeColor+r+g+b)/2; 
//       a = photo.get(xPos+1,yPos+1);
//       r = red(a);
//       g = green(a);
//       b = blue(a);
//        SommeColor=(SommeColor+r+g+b)/2;  
       
//        return ceil(SommeColor);        
//  }
//}

////******************************************************
//void keyPressed() { // Press a key to save the data

//}