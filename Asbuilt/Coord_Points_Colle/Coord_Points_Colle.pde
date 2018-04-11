
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
int num = 0;
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
float[] Radian_t = new float[30000];
float Radian_t_ok=0;
float Trou_Gauche=0;
float Trou_Droit=0;
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
float EntreMAxEtMin_R=0;
int Point1_TrouX=0,Point1_TrouY=0;
int Point2_TrouX=0,Point2_TrouY=0;
int Point3_TrouX=0,Point3_TrouY=0;
int Point4_TrouX=0,Point4_TrouY=0;
int Point5_TrouX=0,Point5_TrouY=0;
int Point6_TrouX=0,Point6_TrouY=0;
int Point7_TrouX=0,Point7_TrouY=0;
float Radian1_t;
float Radian2_t;
float Radian3_t;
float Radian4_t;
float Radian5_t;
float Radian6_t;
float Radian7_t;
int Points=0;
int boucle=0;
     color black = color(0);
     color jaune = color(255, 204, 0);
//---------------SETUP-----------------------------
void setup() {
    size(2592, 3872);

 //Etude Date:06-04-2018
 
 photo = loadImage("Lot_pieces.jpg");
 
// COORDs CENTRE
// Piece 3 = 859,736
// Piece 4 = 1063,741
 CentrePieces_CoordX0[1]=1063;CentrePieces_CoordY0[1]=741;
 
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
Radian_t[inc]=t;

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
  
//Calcul niveau entre Max & Min  
 EntreMAxEtMin_R= (Max_Color_R-Min_Color_R)-40;


 //Faire une boucle pour enregistrer les radian -> valeurs min ppas à pas 

//************************************************************************************
//CAS 1: INCLINE VERS GAUCHE TIROIR A O°
if (ColorPixel_r[1] > EntreMAxEtMin_R){
switch(num) {
  case 0: 
  println("case 0");
         for (boucle =1; boucle < 6201; boucle++) {
           if (ColorPixel_r[boucle] > EntreMAxEtMin_R){
               Radian1_t=Radian_t[boucle];
               num=1;
               memoBoucle=boucle+100;
                   break;
           }
         }

  case 1: 
    println("case 1");
         for (boucle =memoBoucle; boucle < 6201; boucle++) {
           if (ColorPixel_r[boucle] < EntreMAxEtMin_R){
                Radian2_t=Radian_t[boucle];
               num=2;
               memoBoucle=boucle+100;
                break;
           }
           }
  case 2: 
    println("case 2");
         for (boucle =memoBoucle; boucle < 6201; boucle++) {
           if (ColorPixel_r[boucle] > EntreMAxEtMin_R){
               Radian3_t=Radian_t[boucle];
               num=3;
               memoBoucle=boucle+100;
                break;
           }
           }
           
             case 3: 
    println("case 3");
         for (boucle =memoBoucle; boucle < 6201; boucle++) {
           if (ColorPixel_r[boucle] < EntreMAxEtMin_R){
               Radian4_t=Radian_t[boucle];
               num=4;
               memoBoucle=boucle+100;
               Radian_t_ok=((Radian4_t-Radian3_t)/2)+Radian3_t;
               Trou_Droit=Radian_t_ok-1.57;
               Trou_Gauche=Radian_t_ok+1.57;
                break;
           }
           }
             case 4: 
    println("case 4");
         for (boucle =memoBoucle; boucle < 6201; boucle++) {
           if (ColorPixel_r[boucle] > EntreMAxEtMin_R){
               Radian5_t=Radian_t[boucle+100];
               num=5;
               boucle=0;
                break;
           }
           }
              case 5: 
    println("case 5");  
                   boucle=0;
                break;
           
}
}
//************************************************************************************
//CAS 1: INCLINE VERS GAUCHE TROU A O°
if (ColorPixel_r[1] < EntreMAxEtMin_R){
switch(num) {
  case 0: 
  println("case 0");
         for (boucle =1; boucle < 6201; boucle++) {
           if (ColorPixel_r[boucle] > EntreMAxEtMin_R){
               Radian1_t=Radian_t[boucle];
               num=1;
               memoBoucle=boucle+100;
                   break;
           }
         }

  case 1: 
    println("case 1");
         for (boucle =memoBoucle; boucle < 6201; boucle++) {
           if (ColorPixel_r[boucle] > EntreMAxEtMin_R){
                Radian2_t=Radian_t[boucle];
               num=2;
               memoBoucle=boucle+100;
                break;
           }
           }
  case 2: 
    println("case 2");
         for (boucle =memoBoucle; boucle < 6201; boucle++) {
           if (ColorPixel_r[boucle] < EntreMAxEtMin_R){
               Radian3_t=Radian_t[boucle];
               num=3;
               memoBoucle=boucle+100;
               Radian_t_ok=((Radian3_t-Radian2_t)/2)+Radian2_t;
               Trou_Droit=Radian_t_ok-1.57;
               Trou_Gauche=Radian_t_ok+1.57;
                break;
           }
           }
           
             case 3: 
    println("case 3");
         for (boucle =memoBoucle; boucle < 6201; boucle++) {
           if (ColorPixel_r[boucle] > EntreMAxEtMin_R){
               Radian4_t=Radian_t[boucle];
               num=4;
               memoBoucle=boucle+100;

                break;
           }
           }
             case 4: 
    println("case 4");
         for (boucle =memoBoucle; boucle < 6201; boucle++) {
           if (ColorPixel_r[boucle] < EntreMAxEtMin_R){
               Radian5_t=Radian_t[boucle+100];
               num=5;
               boucle=0;
                break;
           }
           }
              case 5: 
    println("case 5");  
                   boucle=0;
                break;
           
}
}
//============================================================================
  println("Moyenne R: "+Moyenne_R);
 println("Minimum R: "+Min_Color_R); 
 println("Maximum R: "+Max_Color_R); 
  println("MaxMin R: "+EntreMAxEtMin_R); 
  
 // println("Point1_TrouX: "+Point1_TrouX);
 //println("Point1_TrouY: "+Point1_TrouY); 
 // println("Point2_TrouX: "+Point2_TrouX);
 //println("Point2_TrouY: "+Point2_TrouY); 
 //  println("Point3_TrouX: "+Point3_TrouX);
 //println("Point3_TrouY: "+Point3_TrouY); 
 //  println("Point4_TrouX: "+Point4_TrouX);
 //println("Point4_TrouY: "+Point4_TrouY); 
 //  println("Point5_TrouX: "+Point5_TrouX);
 //println("Point5_TrouY: "+Point5_TrouY); 
 //  println("Point6_TrouX: "+Point6_TrouX);
 //println("Point6_TrouY: "+Point6_TrouY); 
 
 println("Point1_Radian: "+Radian1_t);
  println("Point2_Radian: "+Radian2_t);
   println("Point3_Radian: "+Radian3_t);
    println("Point4_Radian: "+Radian4_t);
     println("Point5_Radian: "+Radian5_t);
     println("Radian: "+Radian_t_ok);
          println("Trou Droit: "+Trou_Droit);
                    println("Trou Gauche: "+Trou_Gauche);
                    
// AFFICHAGE COORD TROUs  DROIT                  
x= ceil(x0 + Rayon * cos(Trou_Droit));
y = y0-(ceil( y0 + Rayon * sin(Trou_Droit))-y0);
set(x, y, jaune);
ellipse(x, y, 5, 5);
// AFFICHAGE COORD TROUs  GAUCHE                  
x= ceil(x0 + Rayon * cos(Trou_Gauche));
y = y0-(ceil( y0 + Rayon * sin(Trou_Gauche))-y0);
set(x, y, jaune);
ellipse(x, y, 5, 5);
//TRAITEMENT DES FICHIERS
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
 
 

//exit();

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