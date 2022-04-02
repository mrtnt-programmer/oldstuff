class tile{
  int c;
  int l;
  String type;
  tile(int c, int l,String type){
    this.c = c;
    this.l = l;
    this.type = type;
  }
  void dessiner(){
    if (type == "background"){
        fill(200,200,200);
    }else{
        fill(100,100,0);
    }
    rect(l*(width/ligne),c*(height/collone),(l+1)*(width/ligne),(c+1)*(height/collone));
  }
  
}
