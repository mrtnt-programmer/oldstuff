void setup() {
  fullScreen();
  //noCursor();
  background(0, 0, 0);
  text("loading...", width/2, height/2);
  variableandlist();
  musicplayer();
  imageload();
  terrain.spawnuniter((gamewidth/16)*5, gameheight/2, 1, 2, "nexus");
  terrain.spawnuniter((gamewidth/16)*11, gameheight/2, 2, 2, "nexus");
}

void imageload() {
  marinstill = loadImage("marinstill.png");
  marinstill.resize(width/96, height/48);
  marinstill2 = loadImage("marinstill2.png");
  marinstill2.resize(width/96, height/48);
}

void musicplayer() {
  if (playmusic) {
    minim = new Minim(this);
    music = minim.loadFile("music.mp3");
    music.loop();
  }
}

void variableandlist() {
  block = width/192;//ou diviser par 10
  gamewidth = width;
  gameheight = height;
  // team1buildings = new ArrayList<building>();
  // team2buildings = new ArrayList<building>();
  terrain = new Terrain(gamewidth, gameheight);
  units = new ArrayList<Unit>();
}

void draw() {
  frameRate(120);//de base 60fps peux aller jusqua 300
  background(0, 255, 255);
  if (gamefinished && alreadywin) {
    terrain.victory();
  } else {
    showterrain();
  }
}

void showterrain() {
  debugmode();
  movecamera(); 
  camerasize();
  if (millis()% 100<23) {//tous les dixeme de seconde
    spawntime = spawntime+0.1;
    gametime = gametime+0.1;
  }
  terrain.TerrainMaker(locationX, locationY);//cree le terrain
  terrain.action(); //actualise les uniter/tirs
  terrain.baraction();
  //trouble shoting
}  

void mousePressed() {//activated when a mouse is pressed
  if (keyCode == SHIFT) {
    selectedcolor = 1;
  }else{
    selectedcolor = 2;
  }
  if (mouseButton == LEFT) {
    terrain.spawnuniter(mouseX-locationX,mouseY-locationY,selectedcolor,1,selectedunit);//bleu passif
   // terrain.spawnuniter(mouseX-locationX,mouseY-locationY,selectedcolor,1,"firebat");//bleu passif
  }
}

void keyPressed() {
  if (keyCode == UP) {
    moveup = true;
  }
  if (keyCode == DOWN) {
    movedown = true;
  }
  if (keyCode == LEFT) {
    moveleft = true;
  }
  if (keyCode == RIGHT) {
    moveright = true;
  }
  if (key == '+') {
    bigger = true;
  }
  if (key == '-') {
    smaller = true;
  }
  if (key == ' ') {
    gamefinished = false;
    victory1 = false;
    victory2 = false;
    alreadywin = true;
  }
}

void keyReleased() {
  if (keyCode == UP) {
    moveup = false;
  }
  if (keyCode == DOWN) {
    movedown = false;
  }
  if (keyCode == LEFT) {
    moveleft = false;
  }
  if (keyCode == RIGHT) {
    moveright = false;
  }
  if (key == '+') {
    bigger = false;
  }
  if (key == '-') {
    smaller = false;
  }
}

void movecamera() {
  if (moveup) {
    locationY = locationY + 3;
  }
  if (movedown) {
    locationY = locationY - 3;
  }
  if (moveleft) {
    locationX = locationX + 3;
  }
  if (moveright) {
    locationX = locationX - 3;
  }
}

void camerasize () {
  if (bigger == true) {
    gamewidth = gamewidth + (gamewidth/100);
    gameheight = gameheight + (gameheight/100);
  }
  if (smaller == true) {
    gamewidth = gamewidth - (gamewidth/100);
    gameheight = gameheight - (gameheight/100);
  }
}

void debugmode() {  
  if (keyCode == ALT) {
    smaller = false;
  }
}



/* void  Qgamefinished(){
 if(marin.findunit("nexus",1)){//si le nexus exist tout va bien sinon fin de la partie
 gamefinished = false;
 }else{
 gamefinished = true;
 }
 if(marin.findunit("nexus",2)){//si le nexus exist tout va bien sinon fin de la partie
 gamefinished = false;
 }else{
 gamefinished = true;
 }}
 */
