class Point{
  int pX,pY,psize;
  Point(){
    pX = int(random(0,width));
    pY = int(random(0,height));
    psize = int(random(1,15));
  }
  void update(){
    fill(255,255,0);
    ellipse(pX+X,pY+Y,psize,psize);
  }
  
}
