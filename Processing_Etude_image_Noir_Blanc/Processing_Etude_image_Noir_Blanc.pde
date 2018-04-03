
PImage photo,newImage;
PrintWriter output;
boolean fin=true;
boolean flag=false;
int ix,iy;
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
color aa;
int PasAPas = 1;

float r;
float g;
float b;
float Tot;
//---------------SETUP-----------------------------
void setup() {
    size(3872, 2592);
 
    photo = loadImage("data/Lot_pieces.jpg");
    newImage = createImage(3872, 2592, RGB);
}

//----------------DRAW----------------------------
void draw() {
      image(photo, 0, 0);

  for (int iy =0; iy < 2592; iy++) {
    for (int ix =0; ix < 3872; ix++) {
    color a = photo.get(ix,iy);
       r = red(a);
       g = green(a);
       b = blue(a);
  if (iy>235 & iy<439  & ix>149 & ix<329 ){
       if (r>150 & g>150 & b>150){
           aa = color(255,0,0);
           newImage.set(ix,iy,aa);
       } else {
        float Moy=(r+g+b)/3;
         aa = color(int(Moy),int(Moy),int(Moy));              
        newImage.set(ix,iy,aa);
       }
  } else {
            float Moy=(r+g+b)/3;
         aa = color(int(Moy),int(Moy),int(Moy));              
        newImage.set(ix,iy,aa);
  }

  }
  }
newImage.save("data/Lot_pieces2.jpg");
//image(newImage, 0, 0);;

 
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