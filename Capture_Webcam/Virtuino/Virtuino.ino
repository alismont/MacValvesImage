/******************************************************************
 Created with PROGRAMINO IDE for Arduino - 07.10.2017 16:17:14
 Project     :
 Libraries   :
 Author      :
 Description :
******************************************************************/
/* Virtuino example No1 (Bluetooth)
 * Example name = "Hello Virtuino World"
 * Created by Ilias Lamprou
 * Updated Jul 01 2016
 * This is the code you need to run on your arduino board to cummunicate whith VirtUino app via bluetooth
 * Before  running this code config the settings below as the instructions on the right
 * 
 * 
 * Download latest Virtuino android app from the link: https://play.google.com/store/apps/details?id=com.virtuino_automations.virtuino
 * Getting starting link:
 * Video tutorial link: https://www.youtube.com/watch?v=CYR_jigRkgk
 * Contact address for questions or comments: iliaslampr@gmail.com
 */

/*========= VirtuinoBluetooth Class methods  
*  vPinMode(int pin, int state)                                  set pin as digital OUTPUT or digital INPUT.  (Insteed default pinMode method
*
*========= Virtuino General methods  
*  void vDigitalMemoryWrite(int digitalMemoryIndex, int value)   write a value to a Virtuino digital memory   (digitalMemoryIndex=0..31, value range = 0 or 1)
*  int  vDigitalMemoryRead(int digitalMemoryIndex)               read  the value of a Virtuino digital memory (digitalMemoryIndex=0..31, returned value range = 0 or 1)
*  void vMemoryWrite(int analogMemoryIndex, float value)         write a value to Virtuino float memory       (memoryIndex=0..31, value range as float value)
*  float vMemoryRead(int analogMemoryIndex)                      read the value of  Virtuino analog memory    (analogMemoryIndex=0..31, returned value range = 0..1023)
*  run()                                                         neccesary command to communicate with Virtuino android app  (on start of void loop)
*  void vDelay(long milliseconds);                               Pauses the program (without block communication) for the amount of time (in miliseconds) specified as parameter
*  int getPinValue(int pin)                                      read the value of a Pin. Usefull for PWM pins
*/

/* 
 * 
 * Auteur: Alain Lismont
 * 
 * 
 */
 
#include "VirtuinoBluetooth.h" 
;  
SoftwareSerial bluetoothSerial =  SoftwareSerial(4,5);   // arduino RX pin=2  arduino TX pin=3    connect the arduino RX pin to bluetooth module TX pin   -  connect the arduino TX pin to bluetooth module RX pin.  Disable this line if you want to use hardware serial 
VirtuinoBluetooth virtuino(bluetoothSerial);

int Out=0; // de 0-100%
float TempSimuNint=0.0; // 0-1000 C°
float TempMesusureInt=0.0; // 0-1000 C°
float FacteurInt=2000.0; // facteur d integration
float TempMesureInmV=0.0;// PV in mV Thermocouple
int valOutFromPLC=0;// Entree analogique from PLC 0-1023 pour 0-5V 0-100% output plc

int PV = 13;      // PV to PLC in mV
int OutFromPLC = 100;   // Output from PLC

int val = 0;
int analogPin=A0;



void setup()
{

pinMode(PV, OUTPUT);

  Serial3.begin(9600);  

TempSimuNint=0;

}

void loop()
{

  virtuino.run();
        // send data only when you receive data:
        if (Serial.available() > 0) {
               //  read the incoming byte:
               Out = Serial.read();
               valOutFromPLC=Out;
              //   say what you got:
                Serial.print("I received: ");
                Serial.println(valOutFromPLC);
       }

  // 1023 = 100%
// y = 0,9775x
 //valOutFromPLC = analogRead(analogPin);
 valOutFromPLC=1023; // 0-100% 0-1023
TempSimuNint=0.93*valOutFromPLC;
//Serial.println(TempSimuNint);

// Fonction de transfert
TempMesusureInt = ((TempMesusureInt * FacteurInt) + TempSimuNint ) / (FacteurInt + 1);
//Serial.println(TempMesusureInt);
 

// 1000 °C tension 10.506 mV  0°C 0mV
// y = 0,0105x - 0,2607
TempMesureInmV=(0.0115*TempMesusureInt) - 0.2607;

if (TempMesureInmV<0)
{

 analogWrite(0, TempMesureInmV);
  Serial3.println("0");
  virtuino.vMemoryWrite(0, 0);
} else {
    analogWrite(PV, TempMesureInmV);
    Serial3.println(TempMesureInmV);
    virtuino.vMemoryWrite(0, TempMesureInmV);
}

}



