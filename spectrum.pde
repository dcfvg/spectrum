import processing.video.*;
Capture video;

float a, ratio = 1;
int videoW = 240, videoH = 135, fps = 30;
int pix[][][] = new int[videoW][videoH][3];

boolean sketchFullScreen() {return true;}

void setup() {

  size(1920, 1080, OPENGL);
  noFill();
  noSmooth();

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) println(i+" — "+cameras[i]);

    // The camera can be initialized directly using an 
    // element from the array returned by list():
    video = new Capture(this, cameras[0]);
    video.start();
  }

  frameRate(fps);
}

void draw() {

  if (video.available() == true) video.read();

  // get pixels and color value
  image(video, 0, 0, videoW, videoH);

  loadPixels();
  
  for (int x=0; x<videoW; x++) {
    for (int y=0; y<videoH; y++) {
      color c = get(x, y);
      pix[x][y][0] = int(red(c));
      pix[x][y][1] = int(green(c));
      pix[x][y][2] = int(blue(c));
    }
  }

  background(0);
  image(video, 0, 0, 1920, 1080);

  pushMatrix();

  // set isometric perspective and center 
  ortho(0, width, 0, height); 
  translate(width-width/5, height/2, 255*ratio);

  // set rotation
  rotateX(-PI/6);
  rotateY(a);
  rotateZ(PI);

  a+=.015;

  // display box
  stroke(50);
  box(255*ratio);

  // display pixels in the cube
  translate(-127.5*ratio, -127.5*ratio, -127.5*ratio);

  for (int x=0; x<videoW; x++) {
    for (int y=0; y<videoH; y++) {
      stroke(pix[x][y][0], pix[x][y][1], pix[x][y][2]);
      point(pix[x][y][0]*ratio, pix[x][y][1]*ratio, pix[x][y][2]*ratio);
    }
  }
  popMatrix();

  // video feedback
}

