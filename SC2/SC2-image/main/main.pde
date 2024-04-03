/*
commencer le 01/04/2019
play 
loop
triger

Minim

itch.io

https://processing.org/reference/mouseReleased_.html

if(millis()% 1000<20){//de 18 a 30 (18 ca risaue de louper 30 ca le ferai une seul foit)
1000 = 1 sec

pour les <> "ou list super baleze" sont compliquer premier programe avec super liste 
command:
list.get(quelcombre) au lieu de list[quelnombre]
list.size   
list.add(variable) ou avec des list list.add(new jesuisuneclasse)
list.remove(quelnombre) enleve list[quelnombre]
list.clear() enleve tous

rect(X,Y,width,height);
mon ecrant a 
width = 1920 pix   X
height = 1080 pix  Y
gamewidth = 7680   X
gameheight = 4320  Y
*/   


void setup() {
  fullScreen();
  //noCursor();
  background(0,0,0);
  text("loading...",width/2,height/2);
  variableandlist();
  musicplayer();
  imageload();
  terrain.spawnmarin((gamewidth/16)*11,gameheight/2,2,2,"nexus");////////////////////////////////////////////////////////////////////////////////////////////////
  terrain.spawnmarin((gamewidth/16)*5,gameheight/2,2,1,"nexus");

}

void imageload(){
  marinstill = loadImage("marinstill.png");
  marinstill.resize(width/96,height/48);
  marinstill2 = loadImage("marinstill2.png");
  marinstill2.resize(width/96,height/48);
}
  
void musicplayer(){
  if (playmusic){
    minim = new Minim(this);
    music = minim.loadFile("music.mp3");
    music.loop();
  } 
}

void variableandlist(){
  block = width/192;//ou diviser par 10
  gamewidth = width;
  gameheight = height;
  team1buildings = new ArrayList<building>();
  team2buildings = new ArrayList<building>();
  terrain = new Terrain(gamewidth,gameheight);
  marins = new ArrayList<Marin>();
}

void draw() {
  frameRate(120);//de base 60fps peux aller jusqua 300
  background(0, 255, 255);
  if (gamefinished && alreadywin){
    terrain.victory();
  }else{
    showterrain();
  }
}

void mousePressed(){//activated when a mouse is pressed
  if (keyCode == SHIFT){
    if (mouseButton == LEFT) {
      terrain.spawnmarin(mouseX-locationX      ,mouseY-locationY      ,1           ,1            ,"marin"        );//bleu passif
//////clasee/.fonction//(coordonneX dans le jeu,coordonneY dans le jeu,couleur/team,Action/passif,nom de l'uniter
    }
  }else{
    if (mouseButton == LEFT) {
      terrain.spawnmarin(mouseX-locationX,mouseY-locationY,2,1,"marin");//rouge passif
    } 
  }
}

void keyPressed(){
  if (keyCode == UP){
    moveup = true;
  }
  if (keyCode == DOWN){
    movedown = true;
  }
  if (keyCode == LEFT){
    moveleft = true;
  }
  if (keyCode == RIGHT){
    moveright = true;
  }
  if (key == '+'){
    bigger = true;
  }
  if (key == '-'){
    smaller = true;
  }
  if (key == ' '){
    gamefinished = false;
    victory1 = false;
    victory2 = false;
    alreadywin = true;
  }
}

void keyReleased(){
  if (keyCode == UP){
    moveup = false;
  }
  if (keyCode == DOWN){
    movedown = false;
  }
  if (keyCode == LEFT){
    moveleft = false;
  }
  if (keyCode == RIGHT){
    moveright = false;
  }
  if (key == '+'){
    bigger = false;
  }
  if (key == '-'){
    smaller = false;
  }
}

void movecamera(){
  if (moveup){
    locationY = locationY + 3;
  }
  if (movedown){
    locationY = locationY - 3;
  }
  if (moveleft){
    locationX = locationX + 3;
  }
  if (moveright){
    locationX = locationX - 3;
  }
}

void camerasize (){
  if (bigger == true){
    gamewidth = gamewidth + (gamewidth/100);
    gameheight = gameheight + (gameheight/100);
  }
  if (smaller == true){
    gamewidth = gamewidth - (gamewidth/100);
    gameheight = gameheight - (gameheight/100);
  }
}

void showterrain(){
  movecamera(); 
  camerasize();
  if(millis()% 100<23){//tous les dixeme de seconde
    spawntime = spawntime+0.1;
    gametime = gametime+0.1;
  }
  terrain.TerrainMaker(locationX,locationY);//cree le terrain
  terrain.action(); //actualise les uniter/tirs
  //trouble shoting  
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
