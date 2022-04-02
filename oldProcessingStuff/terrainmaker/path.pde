class Path{
  IntList path;
  Path(){
    path = new IntList();
  }
  
   void addpath(IntList pathtoadd){
     path.append(pathtoadd);
   }
  
  void addstep(int startXdonne,int startYdonne){
    path.append(startXdonne);
    path.append(startYdonne);
  }
  
  int nextstepX(int shift){//can be givin a variable to find left and right tiles ID
    println("nextstepx : "+(path.get(path.size()-2) + shift));
    return path.get(path.size()-2) + shift;//-1 because list and -1 because x is behind y 
  }
  
  int nextstepY(int shift){//can be givin a variable to find left and right tiles ID
    println("nextstepy : "+(path.get(path.size()-1) + shift));
    return path.get(path.size()-1) + shift;//-1 because list
  }
}
