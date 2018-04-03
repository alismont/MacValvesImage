
//
#include "VirtuinoBluetooth.h"                      

//Variables
String chaineReceptionProc, TramProc;

char octetReception;
char caractereReception;
char octetReceptionProc;
char caractereReceptionProc;
String chaineReception, Tram;

bool Processing=true;
int B3[10];
char charVal[10];
int LU=0;
int incomingByte = 0;
int cpt=0;

//Objets
VirtuinoBluetooth virtuino(Serial3);

//------------SEUP---------------------------------

void setup() 
{
 //  
   Serial.begin(9600);
 //
  virtuino.DEBUG=false;              
                
 //
  Serial3.begin(9600);             
}

//----------LOOP--------------------------
void loop(){
  

//Ecriture vers tablette démarrage 
   virtuino.run(); 
   
//Exemple écriture vers tablette      
   virtuino.vMemoryWrite(1,cpt);
   
//Prise photo   
   B3[0]=virtuino.vDigitalMemoryRead(0); 


//Ons sur B3[0]
 if (B3[0]==1) {//-cond ons
    if (!B3[1]) {  //---bit ons
      B3[1] = 1;
      B3[2] = 1;
      cpt=cpt+1;
    }
    else {
      B3[2] = 0; //------erase action au scan suivant
    }
  }
  else {
    B3[1] = 0;//---plus la condition
    B3[2] = 0;
  }
      
//Ecriture vers PC Processing
  if (LU==0 & B3[2]==1) {
    LU=1;
    dtostrf( B3[2], 1, 0, charVal);
    TramProc = charVal;
    TramProc = TramProc + "/";
     Serial.print(TramProc);
      Serial.println();
 }

 //Réponse de processing
  while (Serial.available() > 0) { 
    octetReceptionProc = Serial.read(); 

      if (octetReceptionProc == '/') {
        if (chaineReceptionProc.substring(0, 2) == "LU")  {
          String InStringProc;
          InStringProc = chaineReceptionProc.substring(2);
          LU=0;
        }
      }
          else {
      caractereReceptionProc = char(octetReceptionProc);
      chaineReceptionProc = chaineReceptionProc + caractereReceptionProc;
      //delay(1);
    }  
   
  }
}  
