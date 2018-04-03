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
    i=xPos+(yPos*500);
      r = red(photo.pixels[i]);
      g = green(photo.pixels[i]);
      b = blue(photo.pixels[i]);
        SommeColor=r+g+b;
    i=(xPos-1)+(yPos*500);
          r = red(photo.pixels[i]);
          g = green(photo.pixels[i]);
          b = blue(photo.pixels[i]);
        SommeColor=(SommeColor+r+g+b)/2;      
    i=(xPos-1)+((yPos-1)*500);
          r = red(photo.pixels[i]);
          g = green(photo.pixels[i]);
          b = blue(photo.pixels[i]);
        SommeColor=(SommeColor+r+g+b)/2;        
    i=(xPos)+((yPos-1)*500);
          r = red(photo.pixels[i]);
          g = green(photo.pixels[i]);
          b = blue(photo.pixels[i]);
        SommeColor=(SommeColor+r+g+b)/2;         
    i=(xPos+1)+((yPos-1)*500);
          r = red(photo.pixels[i]);
          g = green(photo.pixels[i]);
          b = blue(photo.pixels[i]);
        SommeColor=(SommeColor+r+g+b)/2;         
    i=(xPos+1)+((yPos)*500);
          r = red(photo.pixels[i]);
          g = green(photo.pixels[i]);
          b = blue(photo.pixels[i]);
        SommeColor=(SommeColor+r+g+b)/2;
    i=(xPos)+((yPos+1)*500);
          r = red(photo.pixels[i]);
          g = green(photo.pixels[i]);
          b = blue(photo.pixels[i]);
        SommeColor=(SommeColor+r+g+b)/2;  
    i=(xPos-1)+((yPos+1)*500);
          r = red(photo.pixels[i]);
          g = green(photo.pixels[i]);
          b = blue(photo.pixels[i]);
        SommeColor=(SommeColor+r+g+b)/2; 
    i=(xPos+1)+((yPos+1)*500);
          r = red(photo.pixels[i]);
          g = green(photo.pixels[i]);
          b = blue(photo.pixels[i]);
        SommeColor=(SommeColor+r+g+b)/2;  
       
        return ceil(SommeColor);        
  }
}