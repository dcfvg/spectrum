import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.*; 
import java.awt.image.*; 
import java.awt.event.*; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class pixel_spectrum extends PApplet {


// VARS // // // // // // //
String imageToExplode = "loading.gif";

int rEx,vEx,bEx;
float echelle = 1;
Boolean resetDw = true;
PImage img;
float rotX,rotY,rotZ;

// PARAM // // // // // // 
Boolean fromPict = true;
Boolean rec = false;
Boolean minimg = false;
Boolean isometric = true;
Boolean contBox = false;
Boolean first = true;

// // // // // // // // //
public void setup() 
{
  String imageParam = param("imageIn");
  if(imageParam != null) imageToExplode = imageParam;
  size(700,700,P3D);
  background(0);
  img = loadImage(imageToExplode);
}//////////////////////////////////

public void draw() 
{
  if(resetDw) background(0);
  if(minimg) image(img, 10, 10);
  if(isometric) ortho(-width/2, width/2, -height/2, height/2, -100, 100);
  else perspective();

  translate(width/2, height/2, 0);
  setpixels();
} //////////////////////////////////


// FUNCTION  // // // // // //
public void setpixels() {

  rotationAuto ();
  stroke(255,255,255,30);
  noFill();

  if(contBox) box(255*echelle);
  noStroke();

  rEx = PApplet.parseInt(127*echelle);
  vEx = PApplet.parseInt(127*echelle);
  bEx = PApplet.parseInt(127*echelle);
  int r,v,b;

  for(int i = 0; i < img.width*img.height; i += 1) 
  {  
    int here = img.pixels[i];
    r = PApplet.parseInt(red(here));
    v = PApplet.parseInt(green(here));
    b = PApplet.parseInt(blue(here));
    traceCube(r,v,b);
  }

}//////////////////////////////////

public void traceCube(int r,int v,int b){
  fill(r,v,b);
  translate(-rEx,-vEx,-bEx); // remise au centre
  r = PApplet.parseInt(r*echelle);
  v = PApplet.parseInt(v*echelle);
  b = PApplet.parseInt(b*echelle);

  translate(r,v,b);
  box(1);

  rEx = r;
  vEx = v;
  bEx = b;
}
public void rotationAuto (){
  rotX = (rotX + 0.8f)%360;
  rotY = (rotY + 0.5f)%360;
  rotZ = (rotZ + 0.1f)%360;
  rotateX(radians(rotX)); 
  rotateY(radians(rotY));
  rotateZ(radians(rotZ));
}

// clavier // // // // // // // // 

public void keyPressed() {
  if (key == '0') echelle = 0.5f;
  if (key == '1') echelle = 1;
  if (key == '2') echelle = 2;
  if (key == '3') echelle = 3;
  
  if (key == 'a') echelle += 0.1f;
  if (key == 'q') echelle -= 0.1f;
  if (key == 'b') resetDw = false;
  if (key == 'i'){
    if(minimg) minimg = false;
    else minimg = true;
  }
  if (key == 'h'){
    if(isometric) isometric = false;
    else isometric = true;
  }
  if (key == 'c'){
    if(contBox) contBox = false;
    else contBox = true;
  }
}
public void keyReleased() {
  if (key == 'b') resetDw = true;
}



  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "pixel_spectrum" });
  }
}
