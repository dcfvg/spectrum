
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
void setup() 
{
  String imageParam = param("imageIn");
  if(imageParam != null) imageToExplode = imageParam;
  size(700,700,P3D);
  background(0);
  img = loadImage(imageToExplode);
}//////////////////////////////////

void draw() 
{
  if(resetDw) background(0);
  if(minimg) image(img, 10, 10);
  if(isometric) ortho(-width/2, width/2, -height/2, height/2, -100, 100);
  else perspective();

  translate(width/2, height/2, 0);
  setpixels();
} //////////////////////////////////


// FUNCTION  // // // // // //
void setpixels() {

  rotationAuto ();
  stroke(255,255,255,30);
  noFill();

  if(contBox) box(255*echelle);
  noStroke();

  rEx = int(127*echelle);
  vEx = int(127*echelle);
  bEx = int(127*echelle);
  int r,v,b;

  for(int i = 0; i < img.width*img.height; i += 1) 
  {  
    int here = img.pixels[i];
    r = int(red(here));
    v = int(green(here));
    b = int(blue(here));
    traceCube(r,v,b);
  }

}//////////////////////////////////

void traceCube(int r,int v,int b){
  fill(r,v,b);
  translate(-rEx,-vEx,-bEx); // remise au centre
  r = int(r*echelle);
  v = int(v*echelle);
  b = int(b*echelle);

  translate(r,v,b);
  box(1);

  rEx = r;
  vEx = v;
  bEx = b;
}
void rotationAuto (){
  rotX = (rotX + 0.8)%360;
  rotY = (rotY + 0.5)%360;
  rotZ = (rotZ + 0.1)%360;
  rotateX(radians(rotX)); 
  rotateY(radians(rotY));
  rotateZ(radians(rotZ));
}

// clavier // // // // // // // // 

void keyPressed() {
  if (key == '0') echelle = 0.5;
  if (key == '1') echelle = 1;
  if (key == '2') echelle = 2;
  if (key == '3') echelle = 3;
  
  if (key == 'a') echelle += 0.1;
  if (key == 'q') echelle -= 0.1;
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
void keyReleased() {
  if (key == 'b') resetDw = true;
}


