void keyPressed() {
  if (key == ' ') {
    if(rec){
      mm.finish();
    } 
    else{
      rec = true;
    } 
  }

  if (key == 'a') {
    echelle += 1;
  }
  if (key == 'q') {
    echelle -= 1;
  }

  if (key == 'p') {
    idImg++;
    /*img = loadImage("http://spectrum.dcfvg.com/cache-HD/"+idU+".png");
    imgMini = loadImage("http://spectrum.dcfvg.com/cache/"+idU+".png");*/
  }

  if (key == 'o') {
    idImg--;
    println(idImg);
    /*img = loadImage("http://spectrum.dcfvg.com/cache-HD/"+idU+".png");
    imgMini = loadImage("http://spectrum.dcfvg.com/cache/"+idU+".png");*/
  }

  if (key == 'b'){
    resetDw = false;
  }

  if (key == 'i'){
    if(minimg){
      minimg = false;
    }
    else{
      minimg = true;
    }

  }

  if (key == 'g'){
    if(avanceAuto){
      avanceAuto = false;
    }
    else{
      avanceAuto = true;
    }
  }
  if (key == 'h'){
    if(isometric){
      isometric = false;
    }
    else{
      isometric = true;
    }
  }
  if (key == 'c'){
    if(contBox){
      contBox = false;
    }
    else{
      contBox = true;
    }
  }
  
  if (key == 's'){
    saveFrame("save/"+fichiers[idImg%fichiers.length]+"-####.png");
    idImg++;
    img =  loadImage("data/"+fichiers[idImg%fichiers.length]);
  }
}//////////////////////////////////

void keyReleased() {
  if (key == 'b'){
    resetDw = true;
  }
}







