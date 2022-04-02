class Person{
  int startc;//begining
  int startl;
  int endc;//end
  int endl;
  int posc;//our position
  int posl;
  boolean finishpathing = false;
  boolean moving = false;
  IntList path;//path to take
  IntList alreadypathed;//all the tiles that were already pathed to   used for calculation   SAVED IN THE FORM OF ID
  ArrayList<Path> allpath;//all possible paths   used for calculation
  Person(){
     path = new IntList();
      alreadypathed = new IntList();
      allpath = new ArrayList<Path>();//make a mini class to make a list of possible paths
  }
  
  void giveinfo(int startX,int startY,int endX,int endY){
    startc = startX;
    startl = startY;
    endc = endX;
    endl = endY;
    posc = startX;
    posl = startY;
    finishpathing = false;
    moving = false;
    path.clear();
  }
  
  void dessiner(){
    pushMatrix();
    fill(255);
    ellipse((posc-1)*(gamewidth/collone)+(gamewidth/collone/2),(posl-1)*(gameheight/ligne)+(gameheight/ligne/2),gamewidth/ligne/3,gamewidth/ligne/3);
    popMatrix();
    if(millis()%24 == 0){
      pathing(startc,startl,endc,endl);
    }
  }

  void pathing(int startc,int startl,int endc,int endl){//thes are the ID of our location and the goal
    if(!finishpathing){
      path = pathingfinder(startc,startl,endc,endl);
    }
    if (moving){
      posc = posc + (path.get(2) - path.get(0));
      posl = posl + (path.get(3) - path.get(1));
      path.remove(1);
      path.remove(0);
      println("   "+path+" "+posc+" "+posl);
      if (path.size() == 2){
        moving = false;
      }
    }
  }


  IntList pathingfinder(int startX,int startY,int endX,int endY){
    boolean found = false;
    allpath.add(new Path());
    allpath.get(allpath.size()-1).addstep(startX,startY);
    
    int cycle = 2;//the first 2 variables where added wich counts as a cycle and then 2 more for the first movement (1 cycle = x and y)
    while(!found){
      for(int i = allpath.size()-1;i >= 0;i--){//------------------------------------try find more paths---------------------------------------------------------
        println(" ");
        println(i);
        println(allpath.size());
        println(tiles.get(findtile(allpath.get(i).nextstepX(-1),allpath.get(i).nextstepY(0))).type != "wall");
        println(cycle);
        
        checksides(-1,0,i);//left
        checksides(1,0,i);//right
        checksides(0,-1,i);//up
        checksides(0,1,i);//down
      }
      for(int i = allpath.size()-1;i >= 0;i--){//------------------------------------------------------------------check if done-----------------------------------
        if(allpath.get(i).path.get(allpath.get(i).path.size()-2) == endX && allpath.get(i).path.get(allpath.get(i).path.size()-1) == endY){
          found = true;
          println("done");
          finishpathing = true;
          moving = true;
          println(allpath.get(i).path);
          return allpath.get(i).path;
        }
        if(allpath.get(i).path.size() != cycle*2){//*2 because x and y---------------------------------------------remove old paths---------------------------------
          println("removing : "+ i + " : " +allpath.get(i).path);
          alreadypathed.append(findtile(allpath.get(i).path.get(allpath.get(i).path.size()-2),allpath.get(i).path.get(allpath.get(i).path.size()-1)));
          allpath.remove(i);
        }
      }

      if(allpath.size() == 0){//--------------------------------------------------------------if nothing found------------------------------------------------------
        IntList n;
        n = new IntList();
        n.append(startX);
        n.append(startY);
        return n;
      }
      for(int i = allpath.size()-1;i >= 0;i--){
        println(i + " : " +allpath.get(i).path);
      }
      cycle++;
    }
    
    IntList n;
    n = new IntList();
    n.append(startX);
    n.append(startY);
    return n;
  }
  
  boolean alreadypathed(int pathtocheck){
    if (alreadypathed.size() == 0){//check if we even need to check in the first place
      for(int i = 0;i <= alreadypathed.size()-1;i++){//look in all checked tiles
        if (findtile(alreadypathed.get((i*2)+2),alreadypathed.get((i*2)+1)) == pathtocheck){
          return true;
        }
      }
    }
    return false; 
  }
  
  int findtile(int tileX,int tileY){//find tiles ID efficiently
    return (collone-1)*tileY + tileX;//calcule pour savoir l'id du path a partir du x et y 
  }
  
  void checksides(int decalagex,int decalagey,int pathtocheck){//sees if the path is clear
  println("   "+decalagex+" "+decalagey+" "+allpath.get(pathtocheck).path);
  println(tiles.get(findtile(allpath.get(pathtocheck).nextstepX(decalagex),allpath.get(pathtocheck).nextstepY(decalagey))).c,tiles.get(findtile(allpath.get(pathtocheck).nextstepX(decalagex),allpath.get(pathtocheck).nextstepY(decalagey))).l);
  println(tiles.get(findtile(allpath.get(pathtocheck).nextstepX(decalagex),allpath.get(pathtocheck).nextstepY(decalagey))).type != "wall");
    if(!(allpath.get(pathtocheck).nextstepX(decalagex) < 1 || allpath.get(pathtocheck).nextstepX(decalagex) > block//check if the tiles were cheking even exist because otherwise everything go BOOM
    || allpath.get(pathtocheck).nextstepY(decalagey) < 1 || allpath.get(pathtocheck).nextstepY(decalagey) > block)){
      if(tiles.get(findtile(allpath.get(pathtocheck).nextstepX(decalagex),allpath.get(pathtocheck).nextstepY(decalagey))).type != "wall" //check if this side block is a wall
         && !(alreadypathed(pathtocheck)) )//check if we already went there
      {
        allpath.add(new Path());//make a new path
        allpath.get(allpath.size()-1).addpath(allpath.get(pathtocheck).path);//add the path so far
        allpath.get(allpath.size()-1).addstep(allpath.get(pathtocheck).nextstepX(decalagex),allpath.get(pathtocheck).nextstepY(decalagey));//add the new step
      }
    }
  }
}
