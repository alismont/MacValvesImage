//Chargement de la librairie vidéo...............
import processing.video.*;
//Chargement de la librairie serial...............
import processing.serial.*; // importe la librairie s�rie processing


//Création de l'objet capture....................
Capture cam;

//Création objet com serial
Serial  myPort; 

//Variables
boolean BpLectureCam=false;
String inString;  
int lf = 10;       
String t=":";
String[] tag = new String[110];
int LU=1;
//--------- SETUP -------------------------------
void setup() {
  
//Initialisation com serial
  println(Serial.list()); 
  myPort = new Serial(this, Serial.list()[0], 9600); 
  myPort.bufferUntil('\n');
  myPort.clear();

  
//Dimentionnement fenêtre de capture.............  
  size(640, 480);
//Liste des caméras disponibles
  String[] cameras = Capture.list();
//Si cette liste est nulle.......................
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
//Sinon si caméras disponible....................
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      //println(cameras[i]);
    }
    
//Initialisation de la caméra choisie
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }      
}
//---------------FIN SETUP--------------------------

//---------------LOOP-------------------------------
void draw() {
  
//Lecture 
  if (inString != null) {
    String[] q = splitTokens(inString, "/");
    tag[0]=q[0]; 
    inString=null;
      myPort.write("LU=1/");    
      //De ARDUINO attente ordre de lecture de la caméra BpLectureCam
        if (int(tag[0])>0){
         BpLectureCam=true;
  }
  }
//
  //AffichageTags(tag);
 
//Test pour lecture image venant de l'arduino  
  if (BpLectureCam){
 
      //Lecture de la caméra choisie si celle-ci est disponible.................  
        if (cam.available() == true) {
            cam.read();
            BpLectureCam=false;
            tag[0]="0";
          }
       //Affichage  de l'image
          image(cam, 0, 0);
          //Sauvegarde image dans le fichier  
            saveFrame("data/Lot_pieces.jpg");   
            
            //Calcul des positions x,y de collage
            
  } 

}

//-------------FONCTIONS------------------------------------------------------

//Com serie event
void serialEvent(Serial p) { 
  inString = p.readString();
} 

//Affichage tags sur écran PC
void AffichageTags(String[] tags) { 
  background(0);
  if (tags[0] != null) {
    textSize(20);
    text("tag0:"+tags[0], 26, 35);
    
  }
}