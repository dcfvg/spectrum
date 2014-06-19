// MODES // // // // // // 
Boolean fromPict = true;
Boolean rec = false;
Boolean minimg = true;
Boolean avanceAuto = true;
Boolean isometric = true;
Boolean contBox = false;

float echelleMini = 0.5;
int tailleGen = 1280;
int idFrame = 0;
// // // // // // // // //
void setup() 
{
  frameRate(8);
  size(1280,720, P3D);

  colorMode(RGB, 255,255,255,100);
  background(0);

  nbSpect = 10580;
  echelle = 1.7;
  
}//////////////////////////////////
void draw() 
{
  if(resetDw){
    background(0,0,0,0);
  }
  if(idImg+1 > nbSpect){    
    idImg = 0;
    avanceAuto = false; 
  }
  if(idImg != idImgEx){

    img = loadImage("data/HD320/im-"+idImg+".png");
    imgMini = loadImage("data/HD/im-"+idImg+".png");
    
    //println(idImg+"/"+nbSpect);
    idImgEx = idImg;
  }
  println(idImg+"/"+nbSpect+" ( frame:"+idFrame+" - +"+frameRate+")");
  idFrame++;
  
  if(minimg)image(imgMini, 0,104, 512, 512);
  if(avanceAuto) idImg++;
  if(isometric) ortho(-width/2, width/2, -height/2, height/2, -127, 127);
  else perspective();

  translate(width/1.45, height/2, 0);
  rotateX(-PI/6);
  float rotat = (PI/3)-(PI/(nbSpect/14))*idFrame%nbSpect;
  rotateY(rotat);
  setpixels(1,100,fromPict);
  
  String zero = "";
  if(idImg<100) zero = "0";
  if(idImg<10) zero = "00";

  saveFrame("save/"+zero+idFrame+".png");

} //////////////////////////////////
