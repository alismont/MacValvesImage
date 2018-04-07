
PImage photo;
PrintWriter outputR,outputG,outputB,outputT;
PrintWriter outputX,outputY;
boolean fin=true;
boolean flag=false;
int i;
String line = null;
int Index=0;
int IndexRelatif=0;

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
int[] CerclePieces_CoordX = new int[10000];
int[] CerclePieces_CoordY = new int[10000];
float[] ColorPixel_r = new float[10000];
float[] ColorPixel_g = new float[10000];
float[] ColorPixel_b = new float[10000];
int Rayon=30;// rayon en nombre de pixels
int x0,y0,x,y;


//---------------SETUP-----------------------------
void setup() {
    size(3872, 2592);
  surface.setLocation(3872,2592); 
  surface.setTitle("Sunlight Calculator"); 
  surface.setResizable(true); 
   
 //Etude Date:06-04-2018
 
 photo = loadImage("Lot_pieces.jpg");
 CentrePieces_CoordX0[1]=458;CentrePieces_CoordY0[1]=729;
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

//Calcul des points pixels du cercle pour le radian "t" demandé
//  Formules: 
//    x = x0 + r*cos(t)
//    y = y0 + r*sin(t) 

// Boucle des 50 pièces A FAIRE.....

x0=CentrePieces_CoordX0[1] ;
y0=CentrePieces_CoordY0[1] ;
int inc=0;
for (float t =0; t < 6.2; t=t + 0.1) {
x= ceil(x0 + Rayon * cos(t));
y = ceil( y0 + Rayon * sin(t));
CerclePieces_CoordX[inc]=x;CerclePieces_CoordY[inc]=y;
//Lecture code couleur de chaque point du cercle
color a = photo.get(x,y);
       r = red(a);
       g = green(a);
       b = blue(a);
ColorPixel_r[inc]=r;ColorPixel_g[inc]=g;ColorPixel_b[inc]=b;

inc++;

outputR.println(r);
outputG.println(g); 
outputB.println(b); 
outputT.println(t); 
outputX.println(x);
outputY.println(y);
  }
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
void parseFile() {
  BufferedReader reader = createReader("data/pos.txt");
  String line = null;
  Index=0;
  try {
    while ((line = reader.readLine()) != null) {
      String[] pieces = split(line, TAB);
                  println(Index);
      cx[Index] = int(pieces[0]);
      cy[Index] = int(pieces[1]);

                  Index=Index+1;
    }
    reader.close();
    NbrPoints=Index;
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