//45hp 6degat tirs tous les 0.61 vue dee 9 peux tire de 5
class Unit{
  ArrayList<Tir>tirs;//je cree la liste de mes tirs
  Tir tir;//je cree une variable de classe pour remplire/utiliser la liste de mes tirs PEW PEW PEW
  float range;//de quel distance peux je tire?
  float sight;//de quel distance peux je voir?
  int frame;
  float mydegat;
  String nomuniter;
  
  float top;//dessus de l'hitbox
  float bottom;//dessous de l'hitbox
  float left;//gauche de l'hitbox
  float right;//droit de l'hitbox
  PVector mybody;//les coordonne du millieu de l'hitbox si on est en plein ecrant//////////////////////////////////////////////////////////
  PVector mymatrixbody;//les coordonne du millieur de l'hitbox dans le jeu
  PVector vitesse;//la vitesse de l'uniter
  float myvitesse;//la vitesse de mouvement
  
  int myteam;// rouge(1) ou bleu(2)
  IntList mytargetlist;//contient l'idetifiant des l'uniter dans la ligne de tir
  int mytarget;//l'uniter la plus proche dans son champ de tir
  float myvie;//combient de degat avant que je meure
  float mysize;//quelle es mon diametre?(rayon*2)
  float attackcooldown;//horloge qui dit quand on peux attacker
  float attackspeed;//variable qui contien la vitesse a lequel on tirs
  boolean istherebuilding = false;
  // boolean 
  boolean istheretarget = false;//true if there is target false if not
  boolean combat;// ON ATTACKE!!! si c'est true...
  boolean spawn;//regard si on est dans le spawner
  boolean dead(){if (myvie < 1){return true;}else {return false;}}//suis je mort?
  boolean deleteme = false;//je suis mort alors on m'enleve de ce mond(ou je suis invisible jusqua quond m'enleve)

  Unit(float Xdonne,float Ydonne,int team,int combatdonne,String nomuniterdonne){
    nomuniter = nomuniterdonne;
  if (nomuniter == "marin"){
    mysize = gamewidth/96;
    sight = mysize*8;
    range = 5*(sight/9);
    myteam = team;// equipe 1 ou 2
    if(myteam==1){myvitesse=gamewidth/800;}
    if(myteam==2){myvitesse=-(gamewidth/800);}
  
    mybody = new PVector(Xdonne,Ydonne);
    mymatrixbody = new PVector(Xdonne,Ydonne);
    vitesse = new PVector(myvitesse,myvitesse);
    top = mybody.x;
    bottom = mybody.x+mysize;
    left = mybody.y;
    right =  mybody.y+mysize;
  
    if(combatdonne==1){spawn=true;}else{spawn=false;}
    if(combatdonne==2){combat=true;}else{combat=false;}
    mytargetlist = new IntList();
    attackspeed = 100;//par raport au fps (sur mon ordi 100~1sec)
    attackcooldown = attackspeed;
    mydegat = 6;
    istheretarget = false;
    tirs = new ArrayList<Tir>();
    myvie = 45;//regard dans strarcraft
    }
    
  if (nomuniter == "firebat"){
    mysize = gamewidth/80;
    sight = mysize*8;
    range = (sight/9);
    myteam = team;// equipe 1 ou 2
    if(myteam==1){myvitesse=gamewidth/800;}
    if(myteam==2){myvitesse=-(gamewidth/800);}
  
    mybody = new PVector(Xdonne,Ydonne);
    mymatrixbody = new PVector(Xdonne,Ydonne);
    vitesse = new PVector(myvitesse,myvitesse);
    top = mybody.x;
    bottom = mybody.x+mysize;
    left = mybody.y;
    right =  mybody.y+mysize;
  
    if(combatdonne==1){spawn=true;}else{spawn=false;}
    if(combatdonne==2){combat=true;}else{combat=false;}
    mytargetlist = new IntList();
    attackspeed = 80;//par raport au fps (sur mon ordi 100~1sec)
    attackcooldown = attackspeed;
    mydegat = 15;
    istheretarget = false;
    tirs = new ArrayList<Tir>();
    myvie = 120;//regard dans strarcraft
    }
        
  if (nomuniter == "nexus"){
    mysize = gamewidth/24;
    sight = mysize*8;
    range = 11*(sight/9);
    myteam = team;// equipe 1 ou 2
    if(myteam==1){myvitesse=0;}
    if(myteam==2){myvitesse=-0;}
  
    mybody = new PVector(Xdonne,Ydonne);
    mymatrixbody = new PVector(Xdonne,Ydonne);
    vitesse = new PVector(myvitesse,myvitesse);
    top = mybody.x;
    bottom = mybody.x+mysize;
    left = mybody.y;
    right =  mybody.y+mysize;
  
    if(combatdonne==1){spawn=true;}else{spawn=false;}
    if(combatdonne==2){combat=true;}else{combat=false;}
    mytargetlist = new IntList();
    attackspeed = 4;//par raport au fps (sur mon ordi 100~1sec)
    attackcooldown = attackspeed;
    mydegat = 70;
    istheretarget = false;
    tirs = new ArrayList<Tir>();
    myvie = 1;//regard dans strarcraft
    }
  }
  
  void action(){
    if (nomuniter == "nexus"){
      afficher();//on me vois!!!
      tirs();//on attack!!!
    }else{
      if (spawn){
        afficher();  
        horsconstructeur();    
      }
      if (combat){
        mouvement();//on bouge!!!
        horsterrain();
        afficher();//on me vois!!!
        tirs();//on attack!!!
      }
    }
    debug();
  }
  
  void debug(){//on recommance a zero pour pas de beug
    mytargetlist.clear();
    istheretarget = false;
    fill(255,255,255);
  }
  
  void horsterrain(){//si en dehort du terrain enleve
    if(mybody.x <= gamewidth/4 || mybody.x >= (gamewidth/4)*3 || mybody.y  <= gameheight/3 ||  mybody.y >= (gameheight/3)*2){//verifie si le marin est en dehord de la zone de combat
      deleteme = true;
    }
    if(myteam==1){//victoire bleu
      if( mybody.x >= (gamewidth/4)*3){
        victory1 = true;
      }
    }
    if(myteam==2){//victoire rouge
      if(mybody.x <= gamewidth/4){
        victory2 = true;
      }
    }
  }
  
  void horsconstructeur(){
    if (myteam == 1){
      if(mybody.x <= (gamewidth/16) || mybody.x >= (gamewidth/16)*3 || mybody.y  <= gameheight/3 ||  mybody.y >= (gameheight/3)*2){//verifie si le marin est en dehord de la zone de construction
        deleteme = true;
      }
    }
    if (myteam == 2){
      if(mybody.x <= (gamewidth/16)*13 || mybody.x >= (gamewidth/16)*15 || mybody.y  <= gameheight/3 ||  mybody.y >= (gameheight/3)*2){//verifie si le marin est en dehord de la zone de construction
        deleteme = true;
      }
    }
  }
  
  void mouvement(){
    detection(sight);
    if (istheretarget){
      detection(range);
      if (istheretarget){
        //on bouge pas et on tirs
      }else{
        vitesse.set((units.get(mytarget).mybody.x - mybody.x),(units.get(mytarget).mybody.y - mybody.y));//on dit ou aller
        vitesse.normalize();// on verifie que la vitesse est constante
        mybody.add(vitesse); //on bouge!!!
      }
    }else{
      if(myteam == 1){//si je suis vert la base je fonce dessu
        if (mybody.x >= (gamewidth/16)*10){//11 mais je metre 10 pour etre plus naturelle
          if (findunit("nexus",2)){
            vitesse.set(units.get(findunit).mybody.x - mybody.x,units.get(findunit).mybody.y - mybody.y);
            vitesse.normalize();
            mybody.add(vitesse);
          }else{
            avancer();
          }
        }else{//sinon j'avance
          avancer();
        }
      }
      if(myteam == 2){//si je suis verte la base fonce dessu
        if (mybody.x <= (gamewidth/16)*6){//5 mais je metre 6 pour etre plus naturelle
          if (findunit("nexus",1)){
          vitesse.set(units.get(findunit).mybody.x - mybody.x,units.get(findunit).mybody.y - mybody.y);
          vitesse.normalize();
          mybody.add(vitesse);
          }else{
            avancer();
          }
        }else{//sinon j'avance
        avancer();
        }
      }          
    }
  }
  
  void detection(float zonedetection){////doit etre donne le diametre du cercle de detection////////////////////////a optimiser//////////////////////////////////////////////////////////////////////
    for (int i = units.size()-1;i >= 0;i--){//cherche tous les marins pour ceux dans la zonedetection
      if (myteam != units.get(i).myteam){
        if(units.get(i).combat){
          // if(mybody.x-(zonedetection/2) <= units.get(i).right && mybody.x+(zonedetection/2) >= units.get(i).left && mybody.y-(zonedetection/2) <= units.get(i).bottom && mybody.y+(zonedetection/2) >= units.get(i).top){//verifie si un enemie est dans 
          if(abs(mybody.x-units.get(i).mybody.x)< zonedetection/2 && abs(mybody.y-units.get(i).mybody.y)<zonedetection/2){
            mytargetlist.append(i);
          }
          //}
        }
      }
    }
    FloatList distance;
    distance = new FloatList();
    for (int i = mytargetlist.size()-1;i >= 0;i--){//cherche la distance des marin(parmie ceux dans ca zonedetection)
      distance.append(dist(mybody.x,mybody.y,units.get(mytargetlist.get(i)).mybody.x,units.get(mytargetlist.get(i)).mybody.y));//cherche la distance
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
    }
  }
  
  void tirs(){
    detection(range);
    if(istheretarget){
      if(attackcooldown <= 0){
        fill(255,0,0);
        tirs.add(new Tir(mybody.x,mybody.y,units.get(mytarget).mybody.x,units.get(mytarget).mybody.y,myteam,mydegat));
        if(nomuniter == "nexus"){//spread attack for nexus
          tirs.add(new Tir(mybody.x,mybody.y,units.get(mytarget).mybody.x + gameheight/20,units.get(mytarget).mybody.y,myteam,mydegat));
          tirs.add(new Tir(mybody.x,mybody.y,units.get(mytarget).mybody.x - gameheight/20,units.get(mytarget).mybody.y,myteam,mydegat));
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
    if(myteam==1){fill(0,0,255);}
    if(myteam==2){fill(255,0,0);}
    int K;
    if(gamewidth >= width){
      K = gamewidth/width;//K c'est le coefficient d'agrandissement
    }else{ 
      K = width/gamewidth;//K c'est le coefficient reduction
    }
    int centreformeX = int(K*mybody.x+locationX);
    int centreformeY = int(K*mybody.y+locationY);
    if (nomuniter == "marin" || nomuniter == "nexus"){
      ellipseMode(CENTER);
      circle(centreformeX,centreformeY,K*mysize);//radius = 5pix ou width/384//////////////////////////////////////////////////////////////////////////////////////////////////////////////
    }
    if (nomuniter == "firebat"){
      rectMode(CENTER);
      int uptriX = int(mybody.x-mysize/2);
      int uptriY = int(mybody.y-mysize/2);
      int downtriX = int(mybody.x-mysize/2);
      int downtriY = int(mybody.y-mysize/2);
      int lefttriX = int(mybody.x-mysize/2);
      int lefttriY = int(mybody.y-mysize/2);
      triangle(uptriX,uptriY,downtriX,downtriY,lefttriX,lefttriY);
    }  }
  
  void degat(float nombrededegat){
    if (!(spawn)){
      myvie = myvie - nombrededegat;
    }
  }
  
  boolean findunit(String name,int team){//donner le nom de l'uniter, donner l`equipe
    for(int i=0;i<units.size();i++){
      if (units.get(i).nomuniter == name && units.get(i).myteam == team){
        findunit = i;
        return true;
      }
    }
    return false;
  }
  
  void avancer(){
    vitesse.set(myvitesse,0);
    vitesse.normalize();
    mybody.add(vitesse);
  }
}
