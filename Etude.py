
from PIL import Image
import numpy as np
import matplotlib.pyplot as plt
import time
import csv, codecs, cStringIO

import pyautogui

Loop = True

#Lecture de l'image compl�te et visualisation
img = Image.open("image2.jpg")
rgb_im = img.convert('RGB')
img.show()

#Initialisation du pas � pas
PAS_A_PAS = 0

#Table des points � la vertical
Lx = [1970, 1975, 1974, 1985, 1986]
Ly = [510, 508, 510, 509, 511]

#Table du cercle de 90� � 0�
GVx = [1959, 1927, 1897, 1889, 1885,1880,1870,1860,1850,1840,1830,1820]
GVy = [511, 511, 516, 525, 529,526,526,526,526,526,526,526]

#Table du cercle de 90� � 180�
DVx = [1981, 2005, 2026, 2054, 2060,2061,2062,2064,2070,2080,2090,2100]
DVy = [509, 510, 510, 511, 511,512,512,512,512,512,512,512]

Lx110 =[1970,1975]
Ly110 =[500,500]


#********************************************************
#Lecture de deux pixels bien choisi faire la moyenne    
def Step10(a):
        #print ("Step10")
        #pixel = pixelMap[Lx[0],Ly[0]] 
        r, g, b = rgb_im.getpixel((Lx[0],Ly[0]))
        ColorSupVertical1=r+g+b        
        #pixel = pixelMap[Lx[1],Ly[1]]
        r, g, b = rgb_im.getpixel((Lx[1],Ly[1]))
        ColorSupVertical1=ColorSupVertical1+r+g+b
        r, g, b = rgb_im.getpixel((Lx[2],Ly[2]))
        ColorSupVertical1=ColorSupVertical1+r+g+b
        r, g, b = rgb_im.getpixel((Lx[3],Ly[3]))
        ColorSupVertical1=ColorSupVertical1+r+g+b
        r, g, b = rgb_im.getpixel((Lx[4],Ly[4]))
        ColorSupVertical1=ColorSupVertical1+r+g+b     
        ColorSupVertical=ColorSupVertical1/5
        print "ColorSupVertical"
        print ColorSupVertical
        return ColorSupVertical;

#Recherche � gauche en haut du point pour coller
def Step110(a,b):
    print ("Step110")
    index=0
    ColorSupVertical=0
    while ColorSupVertical<50 :
        index=index+1
        #pixel = pixelMap[GVx[index],GVy[index]] 
        #print(pixel)
        r, g, b = rgb_im.getpixel((GVx[index],GVy[index]))
        ColorSupVertical=r+g+b
        print ColorSupVertical

        
    print GVx[index]
    print GVy[index]
    return GVx[index],GVy[index];

#Recherche � droite en haut du point pour coller
def Step120(a,b):
    #print ("Step120")
    index=0
    ColorSupVertical=0
    while ColorSupVertical<50 :
        index=index+1            
        #pixel = pixelMap[DVx[index],DVy[index]] 
        #print(pixel)
        r, g, b = rgb_im.getpixel((DVx[index],DVy[index]))
        ColorSupVertical=r+g+b

        
    print DVx[index]
    print DVy[index]
    return DVx[index],DVy[index];

#Recherche � gauche en bas du point pour coller
def Step130(a,b):
    index=0
    #print Lx[index]
    #print Ly[index]
    return Lx[index],Ly[index];

#Recherche � droite en bas du point pour coller
def Step140(a,b):
    index=0
    #print[index]
    #print Ly[index]
    return Lx[index],Ly[index];

#dans le sens inverse des aiguilles d une montre
#Recherche � gauche du point de colle sup�rieur
#puis recherche tjrs sur le cercle du point de colle gauche inf�rieur
def Step210(a,b):
    index=0
    #print[index]
    #print Ly[index]
    return Lx[index],Ly[index];

#dans le sens des aiguilles d une montre
#Recherche � droite du point de colle sup�rieur
#puis recherche tjrs sur le cercle du point de colle droit inf�rieur
def Step210(a,b):
    index=0
    #print[index]
    #print Ly[index]
    return Lx[index],Ly[index];

#*******************************************************
#Cr�ation du pixel map
pixelMap = img.load() #create the pixel map

#********************************* PROGRAMME *******************************************************
#                                     MAIN                                                         *
#***************************************************************************************************
while Loop:

#PREMIERE PIECE
#Au pas 0 lecture du pixel en haut vertical
    if PAS_A_PAS == 0 :
        #print(PAS_A_PAS)
        #pixel = pixelMap[1970,510] 
        #print(pixel)
        #Si le r+g+b est compris [30-50] on est sur la pi�ce � coller
        r, g, b = rgb_im.getpixel((1970, 510))
        ColorCentre=r+g+b
        print("ColorCentre ")        
        print(ColorCentre)
        #Sous routine Step10() fait la moyenne sur un ensemble de point � la vertical
        #Test si piece est +- verticale si oui vers pas 110 pour la recherche des 4 points
        Diff=Step10(0)-ColorCentre
        print ("abs(Diff)")        
        print abs(Diff)
        if  0 <= abs(Diff) <= 10:
                PAS_A_PAS = 110
                print(PAS_A_PAS)
                 
        else :
                PAS_A_PAS = 20  #sinon la pi�ce est positionn�e autrement
                print(PAS_A_PAS)                                                        
    Loop=False                                                             
#--------------------------------------------
#Recherche � gauche en haut du point pour coller 
    if  PAS_A_PAS == 110:
        PosSupGaucheX=0
        PosSupGaucheY=0
        #print(PAS_A_PAS)
        PosSupGaucheX,PosSupGaucheY=Step110(0,0)
        #print "PosSupGaucheX,PosSupGaucheY",PosSupGaucheX,PosSupGaucheY
        PAS_A_PAS = 120

#Recherche � droite en haut du point pour coller
    if  PAS_A_PAS == 120:
        PosSupDroiteX=0
        PosSupDroiteY=0
        #print(PAS_A_PAS)
        PosSupDroiteX,PosSupDroiteY=Step120(0,0)
        #print "PosSupDroiteX,PosSupDroiteY",PosSupDroiteX,PosSupDroiteY       
        PAS_A_PAS = 130

#Recherche � gauche en bas du point pour coller
    if  PAS_A_PAS == 130: 
        #print(PAS_A_PAS)
        PosSupGaucheX,PosSupGaucheY=Step130(0,0)
        PAS_A_PAS = 140
        
#Recherche � droite en bas du point pour coller        
    if  PAS_A_PAS == 140: 
        #print(PAS_A_PAS)
        PosSupGaucheX,PosSupGaucheY=Step140(0,0)
        PAS_A_PAS = 99

#--------------------------------------------
#Cas ou la pi�ce  est inclin�e vers la gauche
    if PAS_A_PAS == 20 :
       print(PAS_A_PAS)
       #Lecture des pixels verticals et r�sultat pas la pi�ce � coller
       #si ok -> Lecture des pixels vers la gauche avant les pixels situ�s � 180�
       #Recherche � gauche Step210()
       #sinon
       # > 180� donc pi�ce inclin�e vers la droite
       PAS_A_PAS = 30 #vers traitement pi�ce inclin�e vers la droite


#--------------------------------------------
#Cas ou la pi�ce  est inclin�e vers la droite
    if PAS_A_PAS == 30 :
       print(PAS_A_PAS)
       #Recherche � droite Step310()
       #Lecture des pixels vers la droite point haut & bas
       #D�termination des points miroirs
