class building{
  ArrayList<Tir>tirs;//je cree la liste de mes tirs
  Tir tir;//je cree une variable de classe pour remplire/utiliser la liste de mes tirs PEW PEW PEW
  float range;//de quel distance peux je tire?
  float sight;//de quel distance peux je voir?
  int frame;
  
  float top;//dessus de l'hitbox
  float bottom;//dessous de l'hitbox
  float left;//gauche de l'hitbox
  float right;//droit de l'hitbox
  PVector mybody;//les coordonne du millieu de l'hitbox
  PVector vitesse;//la vitesse de l'uniter
  float myvitesse;//la vitesse de mouvement
  float mydegat;
  
  int myteam;// rouge(1) ou bleu(2)
  IntList mytargetlist;//contient l'idetifiant des l'uniter dans la ligne de tir
  int mytarget;//l'uniter la plus proche dans son champ de tir
  float myvie;//combient de degat avant que je meure
  float mysize;//quelle es mon diametre?(rayon*2)
  int mybuildingtype;//1 = nexus 2 = canon
  float attackcooldown;//horloge qui dit quand on peux attacker
  float attackspeed;//variable qui contien la vitesse a lequel on tirs
  boolean istheretarget;//true if there is target false if not
  boolean dead(){if (myvie < 1){return true;}else {return false;}}//suis je mort?
  int buildingtype;
    
  building(float Xdonne,float Ydonne,int teamdonne,int buildingtypedonne){
  buildingtype = buildingtypedonne;
  if (buildingtype == 1){//mainbase
    mysize = gamewidth/24;
    attackspeed = 4;//par raport au fps (sur mon ordi 100~1sec)
    myvie = 2000;//regard dans strarcraft
    mydegat = 70;
  }
  if (buildingtype == 2){//frontbase
    mysize = gamewidth/48; 
    attackspeed = 2;//par raport au fps (sur mon ordi 100~1sec)
    myvie = 850;//regard dans strarcraft
    mydegat = 12;
  }
    
  sight = mysize*7;
  range = sight;
  myteam = teamdonne;// equipe 1 ou 2  
  mybody = new PVector(Xdonne,Ydonne);
  top = mybody.x;
  bottom = mybody.x+mysize;
  left = mybody.y;
  right =  mybody.y+mysize;
  mytargetlist = new IntList();
  attackcooldown = attackspeed;
  istheretarget = false;
  tirs = new ArrayList<Tir>();
  
  }
  
  void action(){  
    afficher();//on me vois!!!
    tirs();//on attack!!!
    debug();
  }
  
  void debug(){//on recommance a zero pour pas de beug
    mytargetlist.clear();
    istheretarget = false;
    fill(255,255,255);
  }
  
  void detection(float zonedetection){////doit etre donne le diametre du cercle de detection////////////////////////a optimiser//////////////////////////////////////////////////////////////////////
    for (int i = marins.size()-1;i >= 0;i--){//cherche tous les marins pour ceux dans la zonedetection
      if (myteam != marins.get(i).myteam){
        if(marins.get(i).combat){
          // if(mybody.x-(zonedetection/2) <= marins.get(i).right && mybody.x+(zonedetection/2) >= marins.get(i).left && mybody.y-(zonedetection/2) <= marins.get(i).bottom && mybody.y+(zonedetection/2) >= marins.get(i).top){//verifie si un enemie est dans 
          if(abs(mybody.x-marins.get(i).mybody.x)< zonedetection/2 && abs(mybody.y-marins.get(i).mybody.y)<zonedetection/2){
            mytargetlist.append(i);
          }
          //}
        }
      }
    }
    FloatList distance;
    distance = new FloatList();
    for (int i = mytargetlist.size()-1;i >= 0;i--){//cherche la distance des marin(parmie ceux dans ca zonedetection)
      distance.append(dist(mybody.x,mybody.y,marins.get(mytargetlist.get(i)).mybody.x,marins.get(mytargetlist.get(i)).mybody.y));//cherche la distance
    }
    for (int i = distance.size()-1;i >= 0;i--){//cherche le marin le plus proche(parmie ceux dans ca zonedetection)
      if (i != 0){
        if (distance.get(i) > distance.get(i-1)){
          mytargetlist.remove(i);
          distance.remove(i);
        }else{
          mytargetlist.remove(i-1);
          distance.remove(i-1);
        }
      }
    }
    if (mytargetlist.size() >= 1){
      mytarget = mytargetlist.get(0);//on a trouver!!!
      mytargetlist.clear();
      istheretarget = true;
    }else{
      istheretarget = false;
    }
  }
  
  void tirs(){
    detection(range);
    if(istheretarget){
      if(attackcooldown <= 0){
        fill(255,0,0);
        tirs.add(new Tir(mybody.x,mybody.y,marins.get(mytarget).mybody.x,marins.get(mytarget).mybody.y,myteam,mydegat));
        if(buildingtype == 1){//spread attack for mainbase
          tirs.add(new Tir(mybody.x,mybody.y,marins.get(mytarget).mybody.x + gameheight/20,marins.get(mytarget).mybody.y,myteam,mydegat));
          tirs.add(new Tir(mybody.x,mybody.y,marins.get(mytarget).mybody.x - gameheight/20,marins.get(mytarget).mybody.y,myteam,mydegat));
        }
        attackcooldown = attackspeed;
      }
    }
    if(attackcooldown > 0){
      attackcooldown--;
    }
    //on active/enleve tous les tirs
    for (int i = tirs.size()-1;i >= 0;i--){
      if (tirs.get(i).deleteme == true){
        tirs.remove(i);
      }else{
        tirs.get(i).action();
      }    
    }
  }
  
  void afficher(){
    ellipseMode(CENTER);
    if(myteam==1){fill(0,0,255);}
    if(myteam==2){fill(255,0,0);}
    circle(mybody.x+locationX,mybody.y+locationY,mysize);//radius = 5pix ou width/384
  }
  
  void degat(float nombrededegat){
    myvie = myvie - nombrededegat;
  }
}
