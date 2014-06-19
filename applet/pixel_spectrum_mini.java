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

public class pixel_spectrum_mini extends PApplet {

// VARS // // // // // // //
String imageToExplode = "loading.gif";
int rEx,vEx,bEx;
float echelle = 0.25f;
PImage img;
String data;
// // // // // // // // //
public void setup() 
{
  String imageParam = param("imageIn");
  if(imageParam != null) imageToExplode = imageParam;
  size(100,100,P3D);
  background(0);
  img = loadImage(imageToExplode);
  data = "name="+imageToExplode+"&data=";
  noLoop();  
}//////////////////////////////////



public void draw() 
{
  ortho(-width/2, width/2, -height/2, height/2, -100, 100);
  translate(width/2, width/2, 0);
  rotateX(-PI/6); 
  rotateY(PI/3);
  setpixels();
  chargerData();
  sendString ();
} //////////////////////////////////

// FUNCTION  // // // // // //
public void setpixels() {
  stroke(255,255,255,25);
  noFill();
  box(255*echelle);
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
  translate(-rEx,-vEx,-bEx);
  r = PApplet.parseInt(r*echelle);
  v = PApplet.parseInt(v*echelle);
  b = PApplet.parseInt(b*echelle);
  translate(r,v,b);
  box(1);
  rEx = r;
  vEx = v;
  bEx = b;
}

///////////////////////////////////

public void sendString () {
  try {
    URL url = new URL("http://spectrum.dcfvg.com/saveSpectre.php");
    URLConnection conn = url.openConnection();
    conn.setDoOutput(true);
    PrintWriter output = createWriter(conn.getOutputStream());
    output.write(data);
    output.flush();
    StringBuffer answer = new StringBuffer();

    BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    String lines;
    while ((lines = reader.readLine()) != null) {
      answer.append(lines);
    }
    output.close();
    println(answer.toString());
  } 
  catch(Exception e) {
    println("An error has occured");
  }
}
public void chargerData(){
  PImage srcimg = get();
  for(int i = 0; i < srcimg.width; i++)
    for(int j = 0; j < srcimg.height; j++){
      String toadd = comp(hex(srcimg.pixels[i*width+j], 6));
      data = data+","+toadd;
    }
  data = data.toString();
}
public String comp(String hexa) {
  if(hexa.equals("000000")) hexa = ".";
  if(hexa.equals("252525")) hexa = ":";
  return hexa;
}


  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "pixel_spectrum_mini" });
  }
}
