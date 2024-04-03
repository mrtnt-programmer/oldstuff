class Tir{
  PVector mybody;
  PVector target;
  PVector vitesse;
  int myteam;
  boolean deleteme = false;
  float spawntime;
  float mydegat;
  
  //fonction
  Tir(float Xdonne,float Ydonne,float Xallerdonne,float Yallerdonne,int teamdonne,float degatdonne){
    mybody = new PVector(Xdonne,Ydonne);
    myteam = teamdonne;// equipe 1 ou 2
    vitesse = new PVector(5,5);
    target = new PVector(Xallerdonne,Yallerdonne);
    spawntime = gametime;
    mydegat = degatdonne;
  }
  
  void action(){
    mouvement();
    afficher();
    detection();//regarde si on intersepte un ennemie
    tempdevie();
  }
  
  void tempdevie(){
    if(gametime-spawntime >= 2){
      deleteme = true;
    }
  }
  
  void mouvement(){
    vitesse.set((target.x - mybody.x),(target.y - mybody.y));
    vitesse.normalize();
    mybody.add(vitesse.x*2,vitesse.y*2);
  }
  
  void afficher(){
    stroke(255,0,255);
    fill(255,0,255);
    point(mybody.x+locationX,mybody.y+locationY);
  }
  
  void detection(){
    if (target.x == mybody.x && target.y == mybody.y){
      deleteme = true; 
    }
    for (int i = marins.size()-1;i >= 0;i--){
      float jesuisunesupervariable = marins.get(i).myteam;
      if (jesuisunesupervariable != myteam){
        //hibox time///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if(abs(mybody.x-marins.get(i).mybody.x)<gamewidth/192 && abs(mybody.y-marins.get(i).mybody.y)<gamewidth/192){
          marins.get(i).degat(mydegat);
          deleteme = true;
        }
      }
    }
  }
}
