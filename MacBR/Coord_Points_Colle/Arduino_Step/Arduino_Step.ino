/*
  Macvalves machine  collage
*/

// librairies
//#include "VirtuinoBluetooth.h" 
  
#include <Arduino.h>
#include "BasicStepperDriver.h"
#include <Wire.h>
#include <SoftwareSerial.h>

// Motor steps per revolution. Most steppers are 200 steps or 1.8 degrees/step
#define MOTOR_STEPSX 200
#define MOTOR_STEPSY 200
// All the wires needed for full functionality
#define DIRX 5
#define DIRY 6

#define STEPX 2
#define STEPY 3
//Uncomment line to use enable/disable functionality
#define ENBL 8


// Since microstepping is set externally, make sure this matches the selected mode
// 1=full step, 2=half step etc.
#define MICROSTEPSX 1
#define MICROSTEPSY 1

// 2-wire basic config, microstepping is hardwired on the driver
//BasicStepperDriver stepperX(MOTOR_STEPSX, DIRX, STEPX);

//Uncomment line to use enable/disable functionality
BasicStepperDriver stepperX(MOTOR_STEPSX, DIRX, STEPX, ENBL);
BasicStepperDriver stepperY(MOTOR_STEPSY, DIRY, STEPY, ENBL);
int Pos_En_Pixel_X=200;
float Pos_RL_X = 0;
float Pos_DM_X = 0;
float Erreur_Pos_X;
bool X_En_Pos=1;

int Pos_En_Pixel_Y=200;
float Pos_RL_Y = 0;
float Pos_DM_Y = 0;
float Erreur_Pos_Y;
bool Y_En_Pos=1;

int x;
char val;
boolean HomeX_OK=false;
boolean HomeY_OK=false;
int BpHoming = 52; 
int BpStart = 49; 
int FcXHoming = 53; 
int FcYHoming = 51;
int enableX=48;

int Seq=0;

char octetReception;
char caractereReception;
char octetReceptionProc;
char caractereReceptionProc;
String chaineReception, Tram;
String chaineReceptionProc, TramProc;
bool ons1=0;

SoftwareSerial bluetoothSerial =  SoftwareSerial(15,14);   // arduino RX pin=2  arduino TX pin=3    connect the arduino RX pin to bluetooth module TX pin   -  connect the arduino TX pin to bluetooth module RX pin.  Disable this line if you want to use hardware serial 
//VirtuinoBluetooth virtuino(bluetoothSerial); 
//************************************************************************************
void setup() {

//   virtuino.DEBUG=true; 
  /*
     Set target motor RPM.
     These motors can do up to about 200rpm.
     Too high will result in a high pitched whine and the motor does not move.
  */
  Serial.begin(115200);
  //Serial3.begin(9600);
  while (Serial.available() > 0){
  Serial.read() ;   
  }

  pinMode(BpHoming, INPUT);           // set pin to input
digitalWrite(BpHoming, HIGH);       // turn on pullup resistors
  pinMode(FcXHoming, INPUT);           // set pin to input
digitalWrite(FcXHoming, HIGH);       // turn on pullup resistors
  pinMode(FcYHoming, INPUT);           // set pin to input
digitalWrite(FcYHoming, HIGH);       // turn on pullup resistors
  pinMode(BpStart, INPUT);           // set pin to input
digitalWrite(BpStart, HIGH);       // turn on pullup resistors

  pinMode(enableX, INPUT);           // set pin to input
digitalWrite(enableX, HIGH);       // turn on pullup resistors





      stepperX.setRPM(200);
      stepperY.setRPM(200);
  
       stepperX.setMicrostep(MICROSTEPSX);
            stepperX.enable();
       stepperY.setMicrostep(MICROSTEPSX);
            stepperY.enable();





}



//************************************************************************************
void loop() {
//    virtuino.run();    
//Serial3.write("test");

//  void vMemoryWrite(int analogMemoryIndex, float value)         write a value to Virtuino float memory       (memoryIndex=0..31, value range as float value)
//  float vMemoryRead(int analogMemoryIndex)                      read the value of  Virtuino analog memory    (analogMemoryIndex=0..31, returned value range = 0..1023)
 

//GESTION DE LA COMMANDE START
if (!digitalRead(enableX)) {  // 
   stepperX.disable();
   stepperY.disable(); 
}else {
  stepperX.enable();
  stepperY.enable(); 
}
  
  
  
  
  
  



//GESTION DE LA COMMANDE START
if (!digitalRead(BpStart)& HomeX_OK & HomeY_OK) {  //
    if (!ons1) {  //---bit ons
      ons1 = 1; 
        Serial.write("START....=");
    }
  }
  else {
    ons1 = 0;//---bit ons
  }



  

// CHOIX SEQUENCE HOMING OU POSITIONNEMENT X Y AVEC Z ON OFF
 if (!digitalRead(BpHoming)) {
  // SEQUENCE HOME
        stepperX.setRPM(200);
      stepperY.setRPM(200);
      Seq=1;
  }     
//SEQUENCE
switch (Seq) {

    case 0:
    break;
    
    case 1:
Pos_En_Pixel_X=Pos_En_Pixel_X-10;
if (!digitalRead(FcXHoming)){
      Pos_RL_X=0;Pos_DM_X=0;Pos_En_Pixel_X=0;
      HomeX_OK=true;
      Seq=2;
}
    break;

    case 2:
Pos_En_Pixel_Y=Pos_En_Pixel_Y-10;
if (!digitalRead(FcYHoming)){
      Pos_RL_Y=0;Pos_DM_Y=0;Pos_En_Pixel_Y=0;
      HomeY_OK=true;
            Seq=3;
}
    break;

        case 3:
Pos_En_Pixel_X=0;
        stepperX.setRPM(200);
            Seq=4;
    break;

        case 4:
Pos_En_Pixel_Y=0;
        stepperY.setRPM(200);
            Seq=0;
    break;    
}


  Pos_DM_X = float(Pos_En_Pixel_X);
  Erreur_Pos_X = Pos_DM_X - Pos_RL_X;
  stepperX.move(Erreur_Pos_X);
    Pos_RL_X = Pos_DM_X;
      if (X_En_Pos==0){
          Serial.write("XOK......=");
          X_En_Pos=1;
      }

  
  Pos_DM_Y=float(Pos_En_Pixel_Y);
  Erreur_Pos_Y=Pos_DM_Y-Pos_RL_Y;
  stepperY.move(Erreur_Pos_Y);
    Pos_RL_Y=Pos_DM_Y;
                if (Y_En_Pos==0){
          Serial.write("YOK......=");
            Y_En_Pos=1;
      }          



}

//*********************************FIN********************************************
void serialEvent() {
  while (Serial.available() > 0) { // si un caractère en réception

    octetReceptionProc = Serial.read(); // lit le 1er octet de la file d'attente

    if (octetReceptionProc == '=') 
    {
      if (chaineReceptionProc.substring(0, 1).equals("X") == true) 
      {
        String InStringProc;
        InStringProc = chaineReceptionProc.substring(1,5);
        Pos_En_Pixel_X = InStringProc.toFloat();
        X_En_Pos=0;

      }
      if (chaineReceptionProc.substring(0, 1).equals("Y") == true) 
      {
        String InStringProc;
        InStringProc = chaineReceptionProc.substring(1,5);
        Pos_En_Pixel_Y = InStringProc.toFloat();

        Y_En_Pos=0;
      }
      chaineReceptionProc = "";
      break; 
    }
else {
      caractereReceptionProc = char(octetReceptionProc);
      chaineReceptionProc = chaineReceptionProc + caractereReceptionProc;
    } 
  }
}
