/*
PGraphics pg;
pg = createGraphics(width,height);
 
 pg.begindraw();
 pg.enddraw();
 
 Pimage vision = background.get(topleftX,topleftY,sizeX,sizeY);
 set(topleftX,topleftY,vision)

*/

ArrayList<Tile> tiles;
ArrayList<Path> allpath;
Person person;
int block;
int collone;
int ligne;
int gameheight;
int gamewidth;
int botbarsize = 150;
boolean start = false;

void setup(){
  size(800,600);
  tiles = new ArrayList <Tile>();
  allpath = new ArrayList <Path>();
  person = new Person();
  block = width/96;
  collone = block;
  ligne = block;
  makeboard();
  gameheight = height-botbarsize;
  gamewidth = width;

}

void draw(){
  background(255);
  showboard();
  botbar();
  showperson();
}

void botbar(){
  pushMatrix();
  fill(255);
  rect(0,gameheight,gamewidth,height);
  fill(255);
  rect(0,gameheight,gamewidth/3,height);
  rect(gamewidth/3,gameheight,gamewidth/3*2,height);
  rect(gamewidth/3*2,gameheight,gamewidth,height);

  fill(0);
  textSize(width/9);
  text("start",0,gameheight,gamewidth/3,height);
  text("restart",gamewidth/3,gameheight,gamewidth/3*2,height);
  text("reset",gamewidth/3*2,gameheight,gamewidth,height);
  popMatrix();
}


void makeboard(){
  for (int l = 0;l<ligne;l++){
    for (int c = 0;c<collone;c++){
      int i = 1;//ID du Tile
      tiles.add(new Tile(c,l,"background",i));
      i++;

    }
  }
}

void showboard(){
  for(int i = 0;i<tiles.size();i++){
    tiles.get(i).dessiner();
  }
}

void showperson(){
  if (start){
    person.dessiner();
  }
}

void makewall(){
  //

}

void mousePressed(){
  for(int i=0;i<tiles.size();i++){
    if (abs(tiles.get(i).c*(gamewidth/collone)-mouseX+(gamewidth/collone/2))< (gamewidth/collone)/2 && abs(tiles.get(i).l*(gameheight/ligne)-mouseY+(gameheight/ligne/2))< (gameheight/collone)/2  ){
      if (tiles.get(i).type == "background"){
         tiles.get(i).type = "wall";
      }else{
        if (tiles.get(i).type == "wall"){
          tiles.get(i).type = "start";
        }else{
          if (tiles.get(i).type == "start"){
            tiles.get(i).type = "end";
          }else{
            if (tiles.get(i).type == "end"){
              tiles.get(i).type = "background";
            }
          }
        }
      }
    }
  }

  if(abs(-(gamewidth/3) +mouseX+gamewidth/3/2) < gamewidth/3/2 && abs(gameheight-mouseY+botbarsize/2)<botbarsize/2 ){
    if (!start){
      println("start");
      start = true;
      startpathing();
    }
  }

  if(abs(-(gamewidth/3*2) +mouseX+gamewidth/3/2) < gamewidth/3/2 && abs(gameheight-mouseY+botbarsize/2)<botbarsize/2 ){
    println("restart");
    startpathing();
  }

  if(abs(-(gamewidth) +mouseX+gamewidth/3/2) < gamewidth/3/2 && abs(gameheight-mouseY+botbarsize/2)<botbarsize/2 ){
    println("reset");
    makeboard();
  }
}

void startpathing(){
  int startX = 0;
  int startY = 0;
  int endX=0;
  int endY=0;
  for(int i = 0;i<tiles.size();i++){
    if (tiles.get(i).type == "start"){
      startX = tiles.get(i).c+1;//+1 car on commence a 1,1 et non a 0,0
      startY = tiles.get(i).l+1;
    }
    if (tiles.get(i).type == "end"){
      endX = tiles.get(i).c+1;
      endY = tiles.get(i).l+1;
    }
  }
  person.giveinfo(startX,startY,endX,endY);
}
