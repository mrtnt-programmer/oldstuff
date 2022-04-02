ArrayList<tile> tiles;
int collone = 5;
int ligne = 5;


void setup(){
  fullScreen();
  tiles = new ArrayList <tile>();
  makeboard();
}

void draw(){
  background(200,200,200);
  showboard();
}

void makeboard(){
  for (int c = 0;c<collone;c++){
    for (int l = 0;l<ligne;l++){
      tiles.add(new tile(c,l,"background"));
      
    }
  }
}

void showboard(){
  for(int i = 0;i<tiles.size();i++){
    tiles.get(i).dessiner();
  }
}

void makewall(){
  //
  
}
