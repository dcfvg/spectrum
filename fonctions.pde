import processing.pdf.*;
void setpixels(int taille,int transparence,Boolean fromPict) {


  stroke(255,255,255,50);
  noFill();

  if(contBox){
    box(255*echelle);
  }
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
    traceCube(r,v,b,transparence,taille);
  }
}//////////////////////////////////

void traceCube(int r,int v,int b,int transparence,int taille){
  fill(r,v,b,transparence);
  translate(-rEx,-vEx,-bEx); // remise au centre

  r = int(r*echelle);
  v = int(v*echelle);
  b = int(b*echelle);

  translate(r,v,b);
  box(taille);
  rEx = r;
  vEx = v;
  bEx = b;
}//////////////////////////////////

void rotationAuto (){
  rotX = (rotX + 0.8)%360;
  rotY = (rotY + 0.5)%360;
  rotZ = (rotZ + 1)%360;
  //rotateX(radians(rotX)); 
  rotateY(radians(rotY));
  //rotateZ(radians(rotZ));
}//////////////////////////////////




















