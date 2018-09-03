import java.io.*;
//import processing.io.*;
//import arduino_like;
import processing.serial.*;

import controlP5.*;

ControlP5 cp5;

String textValue = "";
//***************************************************************************************************
PImage photo;
String inString;
boolean fin=true;
boolean flag=false;
int i;
String line = null;
int Index=0;
int IndexRelatif=0;
int memoBoucle;
int num = 0;
int numm = 0;
//int[] cx = new int[10000];
//int[] cy = new int[10000];

// Points de soudures
//HG haut gauche; HD haut droit ; BG bas gauche ; BD bas droit
//int[] HGx = new int[100];
//int[] HGy = new int[100];
//int[] HDx = new int[100];
//int[] HDy = new int[100];
//int[] BGx = new int[100];
//int[] BGy = new int[100];
//int[] BDx = new int[100];
//int[] BDy = new int[100];
float val=0.5;
//int[] HGxD = new int[100];
//int[] HGyD = new int[100];
//int[] HDxD = new int[100];
//int[] HDyD = new int[100];
//int[] BGxD = new int[100];
//int[] BGyD = new int[100];
//int[] BDxD = new int[100];
//int[] BDyD = new int[100];

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
float increm=0.0;
int NbrPoints;
String[] cmd={"gphoto2 --capture-image"};
//Etude Date:06-04-2018
//  Tableau des coordonnées polaire de chaque pièce, valeurs constante
int[] CentrePieces_CoordX0 = new int[100];
int[] CentrePieces_CoordY0 = new int[100];
int[] CerclePieces_CoordX = new int[10000];
int[] CerclePieces_CoordY = new int[10000];
float[] ColorPixel_r = new float[10000];
float[] ColorPixel_r_int = new float[10000];
float[] ColorPixel_r_Trou = new float[10000];
float[] ColorPixel_g = new float[10000];
float[] ColorPixel_b = new float[10000];
float[] ColorPixel_a = new float[10000];
float[] Radian_t = new float[10000];
float[] Radian_Max_TBL = new float[10000];
float Radian_t_ok=0;
float Radian_deux=0;
float Trou_Gauche=0;
float Trou_Droit=0;
int PointZero=0;
float PointUn=0;
float PointDeux=0;
float PointTrois=0;
float PointQuatre=0;
float PointCinq=0;
float PointSix=0;
float PointSept=0;
int[] Trou_GaucheX= new int[100];
int[] Trou_GaucheY = new int[100];
int[] Trou_DroitX = new int[100];
int[] Trou_DroitY = new int[100];
int Rayon=90;//55 en nombre de pixels //.......................................................rayon
int x0,y0,x,y;
float Moyenne_R=0;
float Moyenne_G=0;
float Moyenne_B=0;
float Min_Color_R=10000;
float Min_Color_G=10000;
float Min_Color_B=10000;
float Max_Color_R=0;
float Max_Color_G=0;
float Max_Color_B=0;
float Min_Color_R_int=10000;
float Min_Color_G_int=10000;
float Min_Color_B_int=10000;
float Max_Color_R_int=0;
float Max_Color_G_int=0;
float Max_Color_B_int=0;
float EntreMAxEtMin_R=0;
float EntreMAxEtMin_R_int=0;
int Point1_TrouX=0,Point1_TrouY=0;
int Point2_TrouX=0,Point2_TrouY=0;
int Point3_TrouX=0,Point3_TrouY=0;
int Point4_TrouX=0,Point4_TrouY=0;
int Point5_TrouX=0,Point5_TrouY=0;
int Point6_TrouX=0,Point6_TrouY=0;
int Point7_TrouX=0,Point7_TrouY=0;
float TestInc=0;
float TestDec=0;
float Radian1_t;
float Radian2_t;
float Radian3_t;
float Radian4_t;
float Radian5_t;
float Radian6_t;
float Radian7_t;
float Radian_Max=0;
float Radian_Min=0;

  int loop=0;
  int passage=0;
int Points=0;
int boucle=0;
     color black = color(0);
     color jaune = color(255, 204, 0);
     color rouge = color(240, 28, 28);
     
     int PTS =1;
     
  boolean Calcul_Points_Colle_OK;   
  boolean Home_OK=false;

   Serial myPort;
     int octetReception;
     char caracter;
     String chainerec;
int Sequence=0;
int lf=10;
int CptPieces;
String CoordX, CoordY, CoordZ;
String CoordCTX;
String CoordCTY;
String CoordCTZ;


//float xptspixel=1.037;
//int DecalX=985;
//float yptspixel=1.007;
//int DecalY=197;
//int SequencePos=0;

String IndexCentre="1";
int PrisePos=0;

//float xptspixel=2.1640;
//int DecalX=1750;
//float yptspixel=2.0040;
//int DecalY=1066;
//float zptspixel=1;
//int DecalZ=0;

//float xptspixel=1.24;
//int DecalX=939;
//float yptspixel=1.22;
//int DecalY=728;
//float zptspixel=1;
//int DecalZ=0;

float xptspixel=0.30;
int DecalX=328;
float yptspixel=0.30;
int DecalY=233;
float zptspixel=1;
int DecalZ=0;


int SequencePos=0;
int op_mode=0;


//---------------SETUP----------------------------------------------------------------------------------------------SETUP
void setup() {
   size(6000, 4000);//size(6000, 4000);// size(3872, 2592);
      //size(700,400);
  //background(0);
printArray(Serial.list());

//photo = loadImage("Ce PC/S1/Stockage amovible/DCIM/102NC1S1/DSC_1228.jpg");
//exec("C:/Aurel/mACVALVES/Asbuilt/Coord_Points_Colle/data/test.bat"); 
myPort = new Serial(this,Serial.list()[0],115200);
myPort.bufferUntil(lf);


  PFont font = createFont("arial",20);
cp5 = new ControlP5(this);
  
  cp5.addTextfield("X")
     .setPosition(20,100)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;
     
   cp5.addTextfield("Y")
     .setPosition(20,300)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;     
     
     
    cp5.addTextfield("Z")
     .setPosition(20,500)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;   
   
     
         cp5.addTextfield("Index")
     .setPosition(20,700)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;   
  //cp5.addTextfield("textValue")
  //   .setPosition(20,170)
  //   .setSize(200,40)
  //   .setFont(createFont("arial",20))
  //   .setAutoClear(false)
  //   ;
       
  //cp5.addBang("clear")
  //   .setPosition(240,170)
  //   .setSize(80,40)
  //   .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
  //   ;    
  
  //cp5.addTextfield("default")
  //   .setPosition(20,350)
  //   .setAutoClear(false)
  //   ;
     
  textFont(font);
 //photo = loadImage("Lot_piece.jpg");
 // image(photo,0,0);
  //background(photo);
}

//----------------DRAW-----------------------------------------------------------------------------------------------DRAW
void draw() {
//image(photo,0,0);
   //background(0);
    // stroke(226, 204, 0);
  fill(153);

  
  
   // ............................................................................communication LECTURE BOUTON START SI MACHINE INITIALISEE
while (myPort.available()>0 ) {
  octetReception = myPort.read();

  if (octetReception=='='){
    // println(chainerec);
    if (chainerec.substring(0, 5).equals("START")==true){
        CptPieces=1;
        println("start.................................................");
        
  
        switch(op_mode) {
          
    case 0: 

    break;
    case 1: 
         if (Sequence==0) Sequence=1;   
    break;  
    case 2: 
          if (SequencePos==0) SequencePos=1;   
    break;    
    case 3: 
               TestPos();
    break;      
    case 4: 
         PrisePos=1;
    break;      
    
        }  
        println(op_mode);

    }
   
   
       if (chainerec.substring(0, 1).equals("M")==true){
      op_mode=int(chainerec.substring(1, 2));
        println(op_mode);
      
    } 
   
   
    if (chainerec.substring(0, 3).equals("XOK")==true){
      if (Sequence==31) Sequence=4;
      if (SequencePos==11) SequencePos=2;
      
    }  
    if (chainerec.substring(0, 3).equals("YOK")==true){
      if (Sequence==41) Sequence=5;
      if (SequencePos==21) SequencePos=22;
    }
     if (chainerec.substring(0, 3).equals("XOK")==true){
      if (Sequence==81) Sequence=9;

    }  
    if (chainerec.substring(0, 3).equals("YOK")==true){
      if (Sequence==91) Sequence=10;
    }   
      if (chainerec.substring(0, 3).equals("XOK")==true){
      if (Sequence==1031) Sequence=104;
    }  
    if (chainerec.substring(0, 3).equals("YOK")==true){
      if (Sequence==1041) Sequence=0;
    }  
        if (chainerec.substring(0, 3).equals("ZOK")==true){
      if (Sequence==51) Sequence=6;
            if (Sequence==71) Sequence=8;
      if (SequencePos==221) SequencePos=23;
            if (SequencePos==231) SequencePos=3;
             if (Sequence==191) Sequence=100;
             if (Sequence==1011) Sequence=102;
      
    }
    
      println(chainerec);
      chainerec="";
  } else {
    caracter=char(octetReception);
    chainerec=chainerec+caracter;
    } 
    } 

//......................................................................SEQUENCE
switch(Sequence) {
    case 0: 
    
    break;
	
    case 1: //Prise photo
     // Runtime.getRuntime().exec(cmd);
    //launch("Test.bat");
    //println("exec......");
 
 
 //Process p = exec("gphoto2", "--capture-image-and-download"); 
 // try {
 // int result = p.waitFor();
 // println(result);
 //   }catch(InterruptedException e)
 // {e.printStackTrace();
 //   } 
 
 //p = exec("python", "/home/pi/Mac/Coord_Points_Colle/batchCopy.py"); 
 // try {
 // int result = p.waitFor();
 // println(result);
 //   }catch(InterruptedException e)
 // {e.printStackTrace();
 //   } 
    
 
   // //(2712-984)  ->  1728*1.056=1825

   //   myPort.write("X1825....="); 
   ////(2273 - 196) -> 2077*0.75=1550

   //   myPort.write("Y1550....="); 
         Sequence=11;
          //Sequence=1000;
    break;	
    	  case 11: //Transfert photo
                  Sequence=12;
        break;
        case 12: //Traitement image
    Calcul_Points_Colle_OK=false;
    Traitement_Image();
                  Sequence=3;
                  CptPieces=1;
                  println("---------------------------------------------------");
                  println(Trou_GaucheX[4]);
                  println(Trou_GaucheY[4]);
                 println(Trou_DroitX[4]);
                  println(Trou_DroitY[4]);
        break;  
	case 3: //Positionnement en X gauche
	         // envoie coordonnée X
CoordonneeD();
	         myPort.write(CoordX);  
             Sequence=31;
 print("CoordX:");
 println(CoordX);
    break;	
    		case 31: //Positionnement en X suite
    			// attente en position X

    		break;
	
	case 4: //Positionnement en Y
	         // envoie coordonnée Y
           myPort.write(CoordY); 
             Sequence=41 ;
 print("CoordY:");
 println(CoordY);
    break;
      		case 41: //Positionnement en Y
      			// attente en position Y

      		break;
	
	case 5: //Positionnement en Z descendre
      myPort.write("ZON......="); 
  delay(300);
             Sequence=6;
             //myPort.write("Z0150....="); 
             //Sequence=51 ;
	break;
          case 51: //Positionnement en Z
            // attente en position Z

          break;
	
	case 6: //Collage
      delay(500);
			Sequence=7;
    break;
	
	case 7: //Positionnement en Z monter
      myPort.write("ZOF......="); 
  delay(300);
               Sequence=8;
            //myPort.write("Z0000....="); 
                  //delay(500);
			//Sequence=71;
	break;
          case 71: //Positionnement en Z
            // attente en position Z

          break;

  case 8: //Positionnement en X droite
           // envoie coordonnée X
CoordonneeG();
           myPort.write(CoordX);  
             Sequence=81;
 print("CoordX:");
 println(CoordX);
    break;  
        case 81: //Positionnement en X suite
          // attente en position X

        break;
  
  case 9: //Positionnement en Y
           // envoie coordonnée Y
           myPort.write(CoordY); 
             Sequence=91;
 print("CoordY:");
 println(CoordY);
    break;
          case 91: //Positionnement en Y
            // attente en position Y

          break;
   
  case 10: //Positionnement en Z descendre
      myPort.write("ZON......="); 
  delay(300);
             Sequence=100;

             //myPort.write("Z0150....="); 
             //Sequence=191 ;
  break;
          case 191: //Positionnement en Z
            // attente en position Z
          break;

  case 100: //Collage
    delay(500);
      Sequence=101;
    break;
  
  case 101: //Positionnement en Z monter
        myPort.write("ZOF......="); 
        Sequence=102;
  delay(300);
            // myPort.write("Z0000....="); 
             // delay(500);
     // Sequence=1011;

  break;
                case 1011: //Positionnement en Z
            // attente en position Z
          break; 
          
  case 102: //Test nombre de pieces
  CptPieces=CptPieces+1;
  Sequence=3;
     if (CptPieces>6) Sequence=103;        //............................ CptPieces
     
  break;
  
  
    case 103: //Test nombre de pieces
    
  //   p = exec("python", "/home/pi/Mac/Coord_Points_Colle/EssaiPush.py"); 
  //try {
  //int result = p.waitFor();
  //println(result);
  //  }catch(InterruptedException e)
  //{e.printStackTrace();
  //  } 
      CptPieces=0;
      CoordX="X0000....=";
      myPort.write(CoordX); 
      CoordY="Y0000....=";
      myPort.write(CoordY); 
      Sequence=0;

}
 print("Sequence:");
 println(Sequence); 
 
//......................................................................SEQUENCEPOS
switch(SequencePos) {
    case 1: 

CoordonneeCentre();
           myPort.write(CoordX);  
             SequencePos=11;
 print("CoordX:");
 println(CoordX);
    break;  
        case 11: //Positionnement en X suite
          // attente en position X

        break;
  
  case 2: //Positionnement en Y
           // envoie coordonnée Y
           myPort.write(CoordY); 
             SequencePos=21;
 print("CoordY:");
 println(CoordY);
    break;
  case 21: //Positionnement en Y
          break;
          
     case 22: //Positionnement en Z descendre
           myPort.write("ZON......="); 
  delay(300);
  SequencePos=23;
            //myPort.write("Z0100....="); 
      //SequencePos=221;
  break;
  
         case 221: //Positionnement en Z
            // attente en position Z

          break;
         case 23: //Positionnement en Z monter
                   myPort.write("ZOF......="); 
  delay(300);
  SequencePos=3;
         //delay(2000);
           // myPort.write("Z0000....="); 
      //SequencePos=231;
  break;
  
          case 231: //Positionnement en Z
            // attente en position Z

          break;      
  case 3: //Test nombre de pieces
  CptPieces=CptPieces+1;
  SequencePos=1;
     if (CptPieces>6) SequencePos=31; //......................................cpt piece
     
  break;  
    case 31: //Test nombre de pieces
      CptPieces=0;
      CoordX="X0000....=";
      myPort.write(CoordX); 
      CoordY="Y0000....=";
      myPort.write(CoordY); 
      SequencePos=0;
    
    break;
}
print("SequencePos:");
println(SequencePos);

// exit();

}

//..................................................................TESTPOS
void TestPos(){
      text(cp5.get(Textfield.class,"X").getText(), 360,130);
  println(CoordCTX);
      CoordX="X"+CoordCTX+"....=";
      myPort.write(CoordX);
      
      text(cp5.get(Textfield.class,"Y").getText(), 360,130);
  println(CoordCTY);           
      CoordY="Y"+CoordCTY+"....=";
      myPort.write(CoordY); 


      text(cp5.get(Textfield.class,"Z").getText(), 360,130);
  //text(textValue, 360,180);
  //println(CoordCTY);           
      CoordZ="Z"+CoordCTZ+"....=";
      myPort.write(CoordZ); 
      

}

//..................................................................CoordonneeCentre
void CoordonneeCentre() {
// COORDs CENTRE


CentrePieces_CoordX0[1]=645;CentrePieces_CoordY0[1]=722;
 CentrePieces_CoordX0[2]=1205;CentrePieces_CoordY0[2]=733;
 CentrePieces_CoordX0[3]=3231;CentrePieces_CoordY0[3]=1471;
 CentrePieces_CoordX0[4]=2219;CentrePieces_CoordY0[4]=1482;
 CentrePieces_CoordX0[5]=526;CentrePieces_CoordY0[5]=2002;
 CentrePieces_CoordX0[6]=1541;CentrePieces_CoordY0[6]=1487;
 CentrePieces_CoordX0[7]=2470;CentrePieces_CoordY0[7]=496;
 CentrePieces_CoordX0[8]=2805;CentrePieces_CoordY0[8]=500;
 CentrePieces_CoordX0[9]=3139;CentrePieces_CoordY0[9]=504;
 CentrePieces_CoordX0[10]=3471;CentrePieces_CoordY0[10]=508;
 
 
//CentrePieces_CoordX0[1]=1692;CentrePieces_CoordY0[1]=1148;
// CentrePieces_CoordX0[2]=2081;CentrePieces_CoordY0[2]=1137;
// CentrePieces_CoordX0[3]=2475;CentrePieces_CoordY0[3]=1130;
// CentrePieces_CoordX0[4]=2871;CentrePieces_CoordY0[4]=1132;
// CentrePieces_CoordX0[5]=3266;CentrePieces_CoordY0[5]=1122;
// CentrePieces_CoordX0[6]=1681;CentrePieces_CoordY0[6]=1726;
// CentrePieces_CoordX0[7]=2077;CentrePieces_CoordY0[7]=1718;
// CentrePieces_CoordX0[8]=2474;CentrePieces_CoordY0[8]=1722;
// CentrePieces_CoordX0[9]=2867;CentrePieces_CoordY0[9]=1715;
// CentrePieces_CoordX0[10]=3261;CentrePieces_CoordY0[10]=1708;

//CentrePieces_CoordX0[1]=1793;CentrePieces_CoordY0[1]=1234;
// CentrePieces_CoordX0[2]=2010;CentrePieces_CoordY0[2]=1228;
// CentrePieces_CoordX0[3]=2231;CentrePieces_CoordY0[3]=1225;
// CentrePieces_CoordX0[4]=2450;CentrePieces_CoordY0[4]=1220;
// CentrePieces_CoordX0[5]=2668;CentrePieces_CoordY0[5]=1220;
// CentrePieces_CoordX0[6]=1788;CentrePieces_CoordY0[6]=1558;
// CentrePieces_CoordX0[7]=2009;CentrePieces_CoordY0[7]=1553;
// CentrePieces_CoordX0[8]=2230;CentrePieces_CoordY0[8]=1555;
// CentrePieces_CoordX0[9]=2449;CentrePieces_CoordY0[9]=1550;
// CentrePieces_CoordX0[10]=2666;CentrePieces_CoordY0[10]=1546;


 
CentrePieces_CoordX0[11]=1062;CentrePieces_CoordY0[11]=603;
CentrePieces_CoordX0[12]=644;CentrePieces_CoordY0[12]=1027;
CentrePieces_CoordX0[13]=848;CentrePieces_CoordY0[13]=1034;
CentrePieces_CoordX0[14]=1052;CentrePieces_CoordY0[14]=1038;
CentrePieces_CoordX0[15]=1257;CentrePieces_CoordY0[15]=1046;
CentrePieces_CoordX0[16]=1462;CentrePieces_CoordY0[16]=1054;
CentrePieces_CoordX0[17]=1666;CentrePieces_CoordY0[17]=1065;
CentrePieces_CoordX0[18]=1867;CentrePieces_CoordY0[18]=1076;
CentrePieces_CoordX0[19]=2069;CentrePieces_CoordY0[19]=1088;
CentrePieces_CoordX0[20]=2269;CentrePieces_CoordY0[20]=1098;

CentrePieces_CoordX0[21]=423;CentrePieces_CoordY0 [21]=1320;
CentrePieces_CoordX0[22]=627;CentrePieces_CoordY0 [22]=1325;
CentrePieces_CoordX0[23]=829;CentrePieces_CoordY0 [23]=1332;
CentrePieces_CoordX0[24]=1036;CentrePieces_CoordY0[24]=1338;
CentrePieces_CoordX0[25]=1243;CentrePieces_CoordY0[25]=1347;
CentrePieces_CoordX0[26]=1451;CentrePieces_CoordY0[26]=1356;
CentrePieces_CoordX0[27]=1655;CentrePieces_CoordY0[27]=1364;
CentrePieces_CoordX0[28]=1861;CentrePieces_CoordY0[28]=1375;
CentrePieces_CoordX0[29]=2062;CentrePieces_CoordY0[29]=1383;
CentrePieces_CoordX0[30]=2263;CentrePieces_CoordY0[30]=1394;

CentrePieces_CoordX0[31]=411;CentrePieces_CoordY0 [31]=1622;
CentrePieces_CoordX0[32]=613;CentrePieces_CoordY0 [32]=1627;
CentrePieces_CoordX0[33]=817;CentrePieces_CoordY0 [33]=1634;
CentrePieces_CoordX0[34]=1025;CentrePieces_CoordY0[34]=1645;
CentrePieces_CoordX0[35]=1233;CentrePieces_CoordY0[35]=1652;
CentrePieces_CoordX0[36]=1439;CentrePieces_CoordY0[36]=1660;
CentrePieces_CoordX0[37]=1647;CentrePieces_CoordY0[37]=1667;
CentrePieces_CoordX0[38]=1851;CentrePieces_CoordY0[38]=1676;
CentrePieces_CoordX0[39]=2054;CentrePieces_CoordY0[39]=1685;
CentrePieces_CoordX0[40]=2254;CentrePieces_CoordY0[40]=1695;

CentrePieces_CoordX0[41]=398;CentrePieces_CoordY0 [41]=1925;
CentrePieces_CoordX0[42]=600;CentrePieces_CoordY0 [42]=1933;
CentrePieces_CoordX0[43]=805;CentrePieces_CoordY0 [43]=1942;
CentrePieces_CoordX0[44]=1010;CentrePieces_CoordY0[44]=1950;
CentrePieces_CoordX0[45]=1218;CentrePieces_CoordY0[45]=1957;
CentrePieces_CoordX0[46]=1427;CentrePieces_CoordY0[46]=1966;
CentrePieces_CoordX0[47]=1632;CentrePieces_CoordY0[47]=1973;
CentrePieces_CoordX0[48]=1839;CentrePieces_CoordY0[48]=1981;
CentrePieces_CoordX0[49]=2043;CentrePieces_CoordY0[49]=1990;
CentrePieces_CoordX0[50]=2243;CentrePieces_CoordY0[50]=1996;

CentrePieces_CoordX0[51]=383;CentrePieces_CoordY0 [51]=2229;
CentrePieces_CoordX0[52]=588;CentrePieces_CoordY0 [52]=2238;
CentrePieces_CoordX0[53]=792;CentrePieces_CoordY0 [53]=2246;
CentrePieces_CoordX0[54]=998;CentrePieces_CoordY0[54]=2256;
CentrePieces_CoordX0[55]=1205;CentrePieces_CoordY0[55]=2265;
CentrePieces_CoordX0[56]=1412;CentrePieces_CoordY0[56]=2272;
CentrePieces_CoordX0[57]=1619;CentrePieces_CoordY0[57]=2280;
CentrePieces_CoordX0[58]=1825;CentrePieces_CoordY0[58]=2289;
CentrePieces_CoordX0[59]=2029;CentrePieces_CoordY0[59]=2293;
CentrePieces_CoordX0[60]=2229;CentrePieces_CoordY0[60]=2299;

CentrePieces_CoordX0[61]=378;CentrePieces_CoordY0 [61]=2530;
CentrePieces_CoordX0[62]=580;CentrePieces_CoordY0 [62]=2541;
CentrePieces_CoordX0[63]=784;CentrePieces_CoordY0 [63]=2550;
CentrePieces_CoordX0[64]=991;CentrePieces_CoordY0 [64]=2560;
CentrePieces_CoordX0[65]=1197;CentrePieces_CoordY0[65]=2567;
CentrePieces_CoordX0[66]=1401;CentrePieces_CoordY0[66]=2576;
CentrePieces_CoordX0[67]=1607;CentrePieces_CoordY0[67]=2583;
CentrePieces_CoordX0[68]=1811;CentrePieces_CoordY0[68]=2590;
CentrePieces_CoordX0[69]=2014;CentrePieces_CoordY0[69]=2596;
CentrePieces_CoordX0[70]=2215;CentrePieces_CoordY0[70]=2597;

CentrePieces_CoordX0[71]=373;CentrePieces_CoordY0 [71]=2831;
CentrePieces_CoordX0[72]=578;CentrePieces_CoordY0 [72]=2842;
CentrePieces_CoordX0[73]=779;CentrePieces_CoordY0 [73]=2853;
CentrePieces_CoordX0[74]=983;CentrePieces_CoordY0 [74]=2862;
CentrePieces_CoordX0[75]=1188;CentrePieces_CoordY0[75]=2872;
CentrePieces_CoordX0[76]=1390;CentrePieces_CoordY0[76]=2879;
CentrePieces_CoordX0[77]=1596;CentrePieces_CoordY0[77]=2882;
CentrePieces_CoordX0[78]=1799;CentrePieces_CoordY0[78]=2891;
CentrePieces_CoordX0[79]=2773;CentrePieces_CoordY0[79]=2270;
CentrePieces_CoordX0[80]=3067;CentrePieces_CoordY0[80]=2279;

  if (CentrePieces_CoordX0[CptPieces]*xptspixel<10) {
    CoordX="X000"+str(int((CentrePieces_CoordX0[CptPieces]-DecalX)*xptspixel))+"....=";
  }
  
  if (CentrePieces_CoordX0[CptPieces]*xptspixel>10 & CentrePieces_CoordX0[CptPieces]*xptspixel<100) {
    CoordX="X00"+str(int((CentrePieces_CoordX0[CptPieces]-DecalX)*xptspixel))+"....=";
  }
  
  if (CentrePieces_CoordX0[CptPieces]*xptspixel>100 & CentrePieces_CoordX0 [CptPieces]*xptspixel<1000) {
    CoordX="X0"+str(int((CentrePieces_CoordX0[CptPieces]-DecalX)*xptspixel))+"....=";
  }
  
   if (CentrePieces_CoordX0[CptPieces]*xptspixel>1000) {
    CoordX="X"+str(int((CentrePieces_CoordX0[CptPieces]-DecalX)*xptspixel))+"....=";
  }
  

  if (CentrePieces_CoordY0[CptPieces]*yptspixel<10) {
  CoordY="Y000"+str(int((CentrePieces_CoordY0[CptPieces]-DecalY)*yptspixel))+"....=";
  }
  if (CentrePieces_CoordY0[CptPieces]*yptspixel>10 & CentrePieces_CoordY0[CptPieces]*yptspixel<100){
  CoordY="Y00"+str(int((CentrePieces_CoordY0[CptPieces]-DecalY)*yptspixel))+"....=";
  }
  if (CentrePieces_CoordY0[CptPieces]*yptspixel>100 & CentrePieces_CoordY0[CptPieces]*yptspixel<1000){
  CoordY="Y0"+str(int((CentrePieces_CoordY0[CptPieces]-DecalY)*yptspixel))+"....=";
   }       
     if (CentrePieces_CoordY0[CptPieces]*yptspixel>1000) {
    CoordY="Y"+str(int((CentrePieces_CoordY0[CptPieces]-DecalY)*yptspixel))+"....=";
  }    
  }


//++++++++++++++++++++++++++++++++
void mouseClicked() {
  text(cp5.get(Textfield.class,"Index").getText(), 360,130);
  if (PrisePos==1) {
     CentrePieces_CoordX0[int(IndexCentre)]=mouseX;
     CentrePieces_CoordY0[int(IndexCentre)]=mouseY;  
  }
}
//++++++++++++++++++++++++++++++++
void CoordonneeG() {

  if (Trou_GaucheX[CptPieces]*xptspixel<10) {
    CoordX="X000"+str(int((Trou_GaucheX[CptPieces]-DecalX)*xptspixel))+"....=";
  }
  
  if (Trou_GaucheX[CptPieces]*xptspixel>=10 & Trou_GaucheX[CptPieces]*xptspixel<=100) {
    CoordX="X00"+str(int((Trou_GaucheX[CptPieces]-DecalX)*xptspixel))+"....=";
  }
  
  if (Trou_GaucheX[CptPieces]*xptspixel>100 & Trou_GaucheX [CptPieces]*xptspixel<=1000) {
    CoordX="X0"+str(int((Trou_GaucheX[CptPieces]-DecalX)*xptspixel))+"....=";
  }
  
   if (Trou_GaucheX[CptPieces]*xptspixel>1000) {
    CoordX="X"+str(int((Trou_GaucheX[CptPieces]-DecalX)*xptspixel))+"....=";
  }
  

  if (Trou_GaucheY[CptPieces]*yptspixel<10) {
  CoordY="Y000"+str(int((Trou_GaucheY[CptPieces]-DecalY)*yptspixel))+"....=";
  }
  if (Trou_GaucheY[CptPieces]*yptspixel>=10 & Trou_GaucheY [CptPieces]*yptspixel<=100){
  CoordY="Y00"+str(int((Trou_GaucheY[CptPieces]-DecalY)*yptspixel))+"....=";
  }
  if (Trou_GaucheY[CptPieces]*yptspixel>100 & Trou_GaucheY [CptPieces]*yptspixel<=1000){
  CoordY="Y0"+str(int((Trou_GaucheY[CptPieces]-DecalY)*yptspixel))+"....=";
   }       
     if (Trou_GaucheY[CptPieces]*yptspixel>1000) {
    CoordY="Y"+str(int((Trou_GaucheY[CptPieces]-DecalY)*yptspixel))+"....=";
  }    
  }
  
  
//++++++++++++++++++++++++++++++++
void CoordonneeD() {

  if (Trou_DroitX[CptPieces]*xptspixel<10) {
    CoordX="X000"+str(int((Trou_DroitX[CptPieces]-DecalX)*xptspixel))+"....=";
  }
  
  if (Trou_DroitX[CptPieces]*xptspixel>=10 & Trou_GaucheX[CptPieces]*xptspixel<=100) {
    CoordX="X00"+str(int((Trou_DroitX[CptPieces]-DecalX)*xptspixel))+"....=";
  }
  
  if (Trou_DroitX[CptPieces]*xptspixel>100 & Trou_GaucheX [CptPieces]*xptspixel<=1000) {
    CoordX="X0"+str(int((Trou_DroitX[CptPieces]-DecalX)*xptspixel))+"....=";
  }
  
   if (Trou_DroitX[CptPieces]*xptspixel>1000) {
    CoordX="X"+str(int((Trou_DroitX[CptPieces]-DecalX)*xptspixel))+"....=";
  }
  

  if (Trou_DroitY[CptPieces]*yptspixel<10) {
  CoordY="Y000"+str(int((Trou_DroitY[CptPieces]-DecalY)*yptspixel))+"....=";
  }
  if (Trou_DroitY[CptPieces]*yptspixel>=10 & Trou_GaucheY[CptPieces]*yptspixel<=100){
  CoordY="Y00"+str(int((Trou_DroitY[CptPieces]-DecalY)*yptspixel))+"....=";
  }
  if (Trou_DroitY[CptPieces]*yptspixel>100 & Trou_GaucheY [CptPieces]*yptspixel<=1000){
  CoordY="Y0"+str(int((Trou_DroitY[CptPieces]-DecalY)*yptspixel))+"....=";
   }       
     if (Trou_DroitY[CptPieces]*yptspixel>1000) {
    CoordY="Y"+str(int((Trou_DroitY[CptPieces]-DecalY)*yptspixel))+"....=";
  }    
  }
 
//++++++++++++++++++++++++++++++++

void SerialEvent(Serial p) {
 // inString=p.readString();
 // println(inString);
}

//++++++++++++++++++++++++++++++++
void Collage() {
  //APPEL POSITIONNEMENT DES AXES
  //SERIAL.WRITE VERS MEGA POUR ENVOI DES COORDONNEES
}


//..........................................................................................Traitement image
void Traitement_Image(){ 
  photo = loadImage("Lot_piece.jpg");
//background(photo);

  tint(204, 153, 0);
      image(photo, 0, 0);
     // filter(DILATE);
      //filter(INVERT);
      //filter(GRAY);


// COORDs CENTRE



CentrePieces_CoordX0[1]=642;CentrePieces_CoordY0[1]=721;
 CentrePieces_CoordX0[2]=1203;CentrePieces_CoordY0[2]=731;
 CentrePieces_CoordX0[3]=1759;CentrePieces_CoordY0[3]=729;
 CentrePieces_CoordX0[4]=2313;CentrePieces_CoordY0[4]=724;
 CentrePieces_CoordX0[5]=2865;CentrePieces_CoordY0[5]=714;
 CentrePieces_CoordX0[6]=3415;CentrePieces_CoordY0[6]=711;
 CentrePieces_CoordX0[7]=2470;CentrePieces_CoordY0[7]=496;
 CentrePieces_CoordX0[8]=2805;CentrePieces_CoordY0[8]=500;
 CentrePieces_CoordX0[9]=3139;CentrePieces_CoordY0[9]=504;
 CentrePieces_CoordX0[10]=3471;CentrePieces_CoordY0[10]=508;
 
 
//CentrePieces_CoordX0[1]=1692;CentrePieces_CoordY0[1]=1148;
// CentrePieces_CoordX0[2]=2081;CentrePieces_CoordY0[2]=1137;
// CentrePieces_CoordX0[3]=2475;CentrePieces_CoordY0[3]=1130;
// CentrePieces_CoordX0[4]=2871;CentrePieces_CoordY0[4]=1132;
// CentrePieces_CoordX0[5]=3266;CentrePieces_CoordY0[5]=1122;
// CentrePieces_CoordX0[6]=1681;CentrePieces_CoordY0[6]=1726;
// CentrePieces_CoordX0[7]=2077;CentrePieces_CoordY0[7]=1718;
// CentrePieces_CoordX0[8]=2474;CentrePieces_CoordY0[8]=1722;
// CentrePieces_CoordX0[9]=2867;CentrePieces_CoordY0[9]=1715;
// CentrePieces_CoordX0[10]=3261;CentrePieces_CoordY0[10]=1708;


//CentrePieces_CoordX0[1]=1793;CentrePieces_CoordY0[1]=1234;
// CentrePieces_CoordX0[2]=2010;CentrePieces_CoordY0[2]=1228;
// CentrePieces_CoordX0[3]=2231;CentrePieces_CoordY0[3]=1225;
// CentrePieces_CoordX0[4]=2450;CentrePieces_CoordY0[4]=1220;
// CentrePieces_CoordX0[5]=2668;CentrePieces_CoordY0[5]=1220;
// CentrePieces_CoordX0[6]=1788;CentrePieces_CoordY0[6]=1558;
// CentrePieces_CoordX0[7]=2009;CentrePieces_CoordY0[7]=1553;
// CentrePieces_CoordX0[8]=2230;CentrePieces_CoordY0[8]=1555;
// CentrePieces_CoordX0[9]=2449;CentrePieces_CoordY0[9]=1550;
// CentrePieces_CoordX0[10]=2666;CentrePieces_CoordY0[10]=1546;



 
CentrePieces_CoordX0[11]=1060;CentrePieces_CoordY0[11]=601;
CentrePieces_CoordX0[12]=644;CentrePieces_CoordY0[12]=1027;
CentrePieces_CoordX0[13]=848;CentrePieces_CoordY0[13]=1034;
CentrePieces_CoordX0[14]=1052;CentrePieces_CoordY0[14]=1038;
CentrePieces_CoordX0[15]=1257;CentrePieces_CoordY0[15]=1046;
CentrePieces_CoordX0[16]=1462;CentrePieces_CoordY0[16]=1054;
CentrePieces_CoordX0[17]=1666;CentrePieces_CoordY0[17]=1065;
CentrePieces_CoordX0[18]=1867;CentrePieces_CoordY0[18]=1076;
CentrePieces_CoordX0[19]=2069;CentrePieces_CoordY0[19]=1088;
CentrePieces_CoordX0[20]=2269;CentrePieces_CoordY0[20]=1098;

CentrePieces_CoordX0[21]=423;CentrePieces_CoordY0 [21]=1320;
CentrePieces_CoordX0[22]=627;CentrePieces_CoordY0 [22]=1325;
CentrePieces_CoordX0[23]=829;CentrePieces_CoordY0 [23]=1332;
CentrePieces_CoordX0[24]=1036;CentrePieces_CoordY0[24]=1338;
CentrePieces_CoordX0[25]=1243;CentrePieces_CoordY0[25]=1347;
CentrePieces_CoordX0[26]=1451;CentrePieces_CoordY0[26]=1356;
CentrePieces_CoordX0[27]=1655;CentrePieces_CoordY0[27]=1364;
CentrePieces_CoordX0[28]=1861;CentrePieces_CoordY0[28]=1375;
CentrePieces_CoordX0[29]=2062;CentrePieces_CoordY0[29]=1383;
CentrePieces_CoordX0[30]=2263;CentrePieces_CoordY0[30]=1394;

CentrePieces_CoordX0[31]=411;CentrePieces_CoordY0 [31]=1622;
CentrePieces_CoordX0[32]=613;CentrePieces_CoordY0 [32]=1627;
CentrePieces_CoordX0[33]=817;CentrePieces_CoordY0 [33]=1634;
CentrePieces_CoordX0[34]=1025;CentrePieces_CoordY0[34]=1645;
CentrePieces_CoordX0[35]=1233;CentrePieces_CoordY0[35]=1652;
CentrePieces_CoordX0[36]=1439;CentrePieces_CoordY0[36]=1660;
CentrePieces_CoordX0[37]=1647;CentrePieces_CoordY0[37]=1667;
CentrePieces_CoordX0[38]=1851;CentrePieces_CoordY0[38]=1676;
CentrePieces_CoordX0[39]=2054;CentrePieces_CoordY0[39]=1685;
CentrePieces_CoordX0[40]=2254;CentrePieces_CoordY0[40]=1695;

CentrePieces_CoordX0[41]=398;CentrePieces_CoordY0 [41]=1925;
CentrePieces_CoordX0[42]=600;CentrePieces_CoordY0 [42]=1933;
CentrePieces_CoordX0[43]=805;CentrePieces_CoordY0 [43]=1942;
CentrePieces_CoordX0[44]=1010;CentrePieces_CoordY0[44]=1950;
CentrePieces_CoordX0[45]=1218;CentrePieces_CoordY0[45]=1957;
CentrePieces_CoordX0[46]=1427;CentrePieces_CoordY0[46]=1966;
CentrePieces_CoordX0[47]=1632;CentrePieces_CoordY0[47]=1973;
CentrePieces_CoordX0[48]=1839;CentrePieces_CoordY0[48]=1981;
CentrePieces_CoordX0[49]=2043;CentrePieces_CoordY0[49]=1990;
CentrePieces_CoordX0[50]=2243;CentrePieces_CoordY0[50]=1996;

CentrePieces_CoordX0[51]=383;CentrePieces_CoordY0 [51]=2229;
CentrePieces_CoordX0[52]=588;CentrePieces_CoordY0 [52]=2238;
CentrePieces_CoordX0[53]=792;CentrePieces_CoordY0 [53]=2246;
CentrePieces_CoordX0[54]=998;CentrePieces_CoordY0[54]=2256;
CentrePieces_CoordX0[55]=1205;CentrePieces_CoordY0[55]=2265;
CentrePieces_CoordX0[56]=1412;CentrePieces_CoordY0[56]=2272;
CentrePieces_CoordX0[57]=1619;CentrePieces_CoordY0[57]=2280;
CentrePieces_CoordX0[58]=1825;CentrePieces_CoordY0[58]=2289;
CentrePieces_CoordX0[59]=2029;CentrePieces_CoordY0[59]=2293;
CentrePieces_CoordX0[60]=2229;CentrePieces_CoordY0[60]=2299;

CentrePieces_CoordX0[61]=378;CentrePieces_CoordY0 [61]=2530;
CentrePieces_CoordX0[62]=580;CentrePieces_CoordY0 [62]=2541;
CentrePieces_CoordX0[63]=784;CentrePieces_CoordY0 [63]=2550;
CentrePieces_CoordX0[64]=991;CentrePieces_CoordY0 [64]=2560;
CentrePieces_CoordX0[65]=1197;CentrePieces_CoordY0[65]=2567;
CentrePieces_CoordX0[66]=1401;CentrePieces_CoordY0[66]=2576;
CentrePieces_CoordX0[67]=1607;CentrePieces_CoordY0[67]=2583;
CentrePieces_CoordX0[68]=1811;CentrePieces_CoordY0[68]=2590;
CentrePieces_CoordX0[69]=2014;CentrePieces_CoordY0[69]=2596;
CentrePieces_CoordX0[70]=2215;CentrePieces_CoordY0[70]=2597;

CentrePieces_CoordX0[71]=373;CentrePieces_CoordY0 [71]=2831;
CentrePieces_CoordX0[72]=578;CentrePieces_CoordY0 [72]=2842;
CentrePieces_CoordX0[73]=779;CentrePieces_CoordY0 [73]=2853;
CentrePieces_CoordX0[74]=983;CentrePieces_CoordY0 [74]=2862;
CentrePieces_CoordX0[75]=1188;CentrePieces_CoordY0[75]=2872;
CentrePieces_CoordX0[76]=1390;CentrePieces_CoordY0[76]=2879;
CentrePieces_CoordX0[77]=1596;CentrePieces_CoordY0[77]=2882;
CentrePieces_CoordX0[78]=1799;CentrePieces_CoordY0[78]=2891;
CentrePieces_CoordX0[79]=2773;CentrePieces_CoordY0[79]=2270;
CentrePieces_CoordX0[80]=3067;CentrePieces_CoordY0[80]=2279;

// boucle pour les pieces
while (PTS <7) {  //................................................................PTS
  println("PTS"+PTS);
  
//INIT
numm=0;
loop=0;
Max_Color_R=0;
Min_Color_R=300;
Radian_Max=-10000;
Radian_Min=10000;
//Point central pièce
x0=CentrePieces_CoordX0[PTS] ;
y0=CentrePieces_CoordY0[PTS] ;
  //println("X0:"+x0);
  //println("y0:"+y0);
int inc=0;

//Cercle Color de chaque points du cercle
for (float t =0; t < 6.2; t=t + 0.001) {
x= ceil(x0 + Rayon * cos(t));
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
if (r<=Min_Color_R) {
  Min_Color_R=r;
  Radian_Min=t;
}
if (r>=Max_Color_R) {
  Max_Color_R=r;
  Radian_Max=t;
}
set(x, y, black);
inc++;
  }


//Intégration courbe r -> r_int
for (boucle =1; boucle < 6201; boucle=boucle+1) {
ColorPixel_r_int[boucle] = ((ColorPixel_r_int[boucle-1] * 100) + ColorPixel_r[boucle] ) / (100 + 1);
if (ColorPixel_r_int[boucle]<=Min_Color_R_int) {
  Min_Color_R_int=ColorPixel_r_int[boucle];
}
if (ColorPixel_r_int[boucle]>=Max_Color_R_int) {
  Max_Color_R_int=ColorPixel_r_int[boucle];
}
}

 //********************VERIFICATION ET ATTEINDRE LE TROU**********************************
 
        x= ceil(x0 + Rayon * cos(Radian_Min));
       y = y0-(ceil( y0 + Rayon * sin(Radian_Min))-y0);
                              set(x, y, rouge);
                         // ellipse(x, y, 5, 5);
          
TestInc=0;
TestDec=0;
increm=0.0;
     for (float i=0; i<1; i=i+0.1)  {      
       x= ceil(x0 + Rayon * cos(Radian_Min+i));
       y = y0-(ceil( y0 + Rayon * sin(Radian_Min+i))-y0);
color  a = photo.get(x,y);
       r = red(a);
       g = green(a);
       b = blue(a);    

            TestInc=TestInc+r;    
  
                          set(x, y, rouge);
                          //ellipse(x, y, 5, 5);
     }
     println("TestInc :"+TestInc); 
     
     for (float i=0; i<1; i=i+0.1)  {      
       x= ceil(x0 + Rayon * cos(Radian_Min-i));
       y = y0-(ceil( y0 + Rayon * sin(Radian_Min-i))-y0);
color  a = photo.get(x,y);
       r = red(a);
       g = green(a);
       b = blue(a);    

            TestDec=TestDec+r;    

                                set(x, y, rouge);
                               // ellipse(x, y, 5, 5);         
     }
         println("TestDec: "+TestDec);   
         
 //*******************IMPRESSION DES POINTS*****************                                                                                    
  if (TestInc>TestDec){ 
       //increm=((abs(TestInc-TestDec)*0.5)/1000);
       increm=0.5;
        println("increm: "+increm); 
       x= ceil(x0 + Rayon * cos(Radian_Min-increm));
        y = y0-(ceil( y0 + Rayon * sin(Radian_Min-increm))-y0);
        Radian_deux=Radian_Min-increm;
          color  a = photo.get(x,y);
           r = red(a);
           g = green(a);
           b = blue(a); 
           
      
            Trou_DroitX[PTS]=x;
            Trou_DroitY[PTS]=y;
                           set(x, y, rouge);
                           ellipse(x, y, 5, 5); 
                           Radian_deux=Radian_deux+3.14; 
  } else {
       //increm=((abs(TestInc-TestDec)*0.5)/1000);
        increm=0.5;
        println("increm: "+increm); 
        x= ceil(x0 + Rayon * cos(Radian_Min+increm));
        y = y0-(ceil( y0 + Rayon * sin(Radian_Min+increm))-y0);
        Radian_deux=Radian_Min+increm;
          color  a = photo.get(x,y);
           r = red(a);
           g = green(a);
           b = blue(a); 
            //<>//
            Trou_DroitX[PTS]=x;
            Trou_DroitY[PTS]=y;
                           set(x, y, rouge);
                         ellipse(x, y, 5, 5); 
                            Radian_deux=Radian_deux-3.14; 
  }


 
//****************** CALCUL POINT OPPOSE*****************************     
         x= ceil(x0 + Rayon * cos(Radian_deux));
          y = y0-(ceil( y0 + Rayon * sin(Radian_deux))-y0);
          Trou_GaucheX[PTS]=x;
          Trou_GaucheY[PTS]=y;
                             set(x, y, rouge);
                           ellipse(x, y, 5, 5); 

                         
//***************FIN****************
println("Point_Un "+PointUn);println("PointDeux: "+PointDeux);
println("Radian_Min: "+Radian_Min);
println("Radian_Max: "+Radian_Max);
println("Min Color"+Min_Color_R);
println("Max Color"+Max_Color_R);
//SUITE PIECE SUIVANTE
 PTS=PTS+1;
}

save("Data2/outputImage.jpg");
//save("image");
//long maximum = Runtime.getRuntime().maxMemory();
//print("Memory:");
//println(maximum);
//photo = loadImage("Lot_piece.jpg");
 //image(photo, 0, 0);
    //background(photo);
Calcul_Points_Colle_OK=false;
}


//**********************************************************************************************************************
public void clear() {
  cp5.get(Textfield.class,"textValue").clear();
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
            if(theEvent.getName()=="X") CoordCTX=theEvent.getStringValue();
            if(theEvent.getName()=="Y") CoordCTY=theEvent.getStringValue();
            if(theEvent.getName()=="Z") CoordCTZ=theEvent.getStringValue();
            if(theEvent.getName()=="Index") IndexCentre=theEvent.getStringValue();
  }
}


public void input(String theText) {
  // automatically receives results from controller input
  println("a textfield event for controller 'input' : "+theText);
}