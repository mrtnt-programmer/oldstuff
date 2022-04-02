class Tile{
  int ID;//l id c est la position dans la list
  int c;
  int l;
  String type;
  
  Tile(int c, int l,String type,int ID){
    this.ID = ID;
    this.c = c;
    this.l = l;
    this.type = type;
  }
  void dessiner(){
    pushMatrix();
    if (type == "background"){
        fill(200,200,200);
    }
    if(type == "wall"){
        fill(100,100,0);
    }
     if(type == "start"){
        fill(255,0,255);
    }
     if(type == "end"){
        fill(255,255,0);
    }

    rect(c*(gamewidth/ligne),l*(gameheight/collone),(c+1)*(gamewidth/ligne),(l+1)*(gameheight/collone));
    popMatrix();
  }

}
