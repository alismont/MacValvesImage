import shutil
import os
import glob
fiche=[]
fiche=glob.glob('/home/pi/processing-3.3.7/*.jpg')
print fiche[0]
shutil.copy(fiche[0],'/home/pi/Mac/Coord_Points_Colle/data/Lot_piece.jpg')
os.remove(fiche[0])
