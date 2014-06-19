// MODES // // // // // // 
Boolean fromPict = true;
Boolean rec = false;
Boolean minimg = true;
Boolean avanceAuto = false;
Boolean isometric = true;
Boolean contBox = true;

float echelleMini = 0.49;
int tailleGen = 200;
// // // // // // // // //
void setup() 
{
  size(tailleGen,tailleGen, P3D);

  colorMode(RGB, 255,255,255,100);
  background(0,0,0,0);
  frameRate(12);

  xml = new XMLElement(this, "http://spectrum.dcfvg.com/api.xml");
  nbSpect = xml.getChildCount();
  echelle = 0.49;
  
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
    XMLElement kid = xml.getChild(idImg%nbSpect);
    idU = kid.getStringAttribute("idU"); 

    img = loadImage("http://spectrum.dcfvg.com/cache/"+idU+".png");
    imgMini = loadImage("http://spectrum.dcfvg.com/cache/"+idU+".png");
    println(idImg+"/"+nbSpect+" => "+idU);
    idImgEx = idImg;
  }
  if(minimg)image(imgMini, tailleGen-(imgMini.width*echelleMini), tailleGen-(imgMini.height*echelleMini),(imgMini.width*echelleMini),(imgMini.height*echelleMini));
  if(avanceAuto) idImg++;
  if(isometric) ortho(-width/2, width/2, -height/2, height/2, -127, 127);
  else perspective();

  translate(width/2, height/2, 0);
  rotateX(-PI/6);
  float rotat = (PI/3)-(PI/nbSpect)*idImg%nbSpect;
  rotateY(rotat);
  setpixels(1,100,fromPict);
  
  String zero = "";
  if(idImg<100) zero = "0";
  if(idImg<10) zero = "00";

  if(avanceAuto)saveFrame("save/"+zero+idImg+".png");

} //////////////////////////////////
















