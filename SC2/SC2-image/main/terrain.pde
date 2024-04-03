class Terrain{
  IntList marinaspawn;
  
  Terrain(int Xdonne,int Ydonne){
  gamewidth = Xdonne;
  gameheight = Ydonne;
  marinaspawn = new IntList();
 // team2buildings.add(new building((gamewidth/16)*11,gameheight/2,2,1));
 // team1buildings.add(new building((gamewidth/16)*5,gameheight/2,1,1));
  }
    
  void action(){
    actionmarin();//active/enleve/les marin ansi que verifie les marin dans le constructeur
    spawnmarin();//on mete TOUT les marin de TOUT les constructeur sur le terrain(si le temp est bon)
    actionbuilding();//on active/enleve les batiment
    victory();//verifie si quelquin a gagner
    extra();
  }
  
  void actionbuilding(){
    for (int i = team1buildings.size()-1;i >= 0;i--){//on active/enleve les batiment de la team 1
      team1buildings.get(i).action();
      if (team1buildings.get(i).dead()){
        team1buildings.remove(i);
      }
    }
    for (int i = team2buildings.size()-1;i >= 0;i--){//on active/enleve les batiment de la team 2
      team2buildings.get(i).action();
      if (team2buildings.get(i).dead()){
        team2buildings.remove(i);
      }
    }  }
  
  void actionmarin(){
    for (int i = marins.size()-1;i >= 0;i--){//on active/enleve les marin
      marins.get(i).action();
      if(marins.get(i).spawn){//si dans le constructeur spawn
        marinaspawn.append(i);
      }
      if (marins.get(i).dead() || marins.get(i).deleteme){
        marins.remove(i);
      }
    }
  }
  
  void spawnmarin(){
    if (spawntime >= 5){//tous les 5sec on spawn l,armee
       spawnterrain();
       spawntime = 0;
    }else{
      if(marinaspawn.size() >= 1 ){
        marinaspawn.clear();
      }
    }
  }
  
  void spawnterrain(){
    for (int i = marinaspawn.size()-1;i >= 0;i--){
      /////////////////////////////////////////////////////////////////////////////////////to optimes/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      if(marins.get(marinaspawn.get(i)).myteam == 1){
        spawnmarin(marins.get(marinaspawn.get(i)).mybody.x + (gamewidth/16)*3,marins.get(marinaspawn.get(i)).mybody.y,marins.get(marinaspawn.get(i)).myteam,2,"marin");
      }
      if(marins.get(marinaspawn.get(i)).myteam == 2){
        spawnmarin(marins.get(marinaspawn.get(i)).mybody.x - (gamewidth/16)*3,marins.get(marinaspawn.get(i)).mybody.y,marins.get(marinaspawn.get(i)).myteam,2,"marin");
      }
    }
  }
   
  void TerrainMaker(int Xdonne,int Ydonne){
    int X = Xdonne;
    int Y = Ydonne;
    fill(0,0,0);
    rect(X+gamewidth/4,Y+gameheight/3,gamewidth/2,gameheight/3);//le terrain de combat
    fill(255,0,255);
    rect(X+gamewidth/16,Y+gameheight/3,gamewidth/8,gameheight/3);//joueur1 terrain de l'armee
    rect(X+(gamewidth/4)*3+gamewidth/16,Y+gameheight/3,gamewidth/8,gameheight/3);//joueur2 terrain de l'armee
    
  }
  
  void spawnmarin(float Xdonne,float Ydonne,int team,int combatdonne,String nomuniterdonne){
    marins.add(new Marin(Xdonne,Ydonne,team,combatdonne,nomuniterdonne));////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  }
  
  void extra(){
    fill(0,0,0);
    text(gametime,width/2,height/26);
    text(spawntime,width/2,height/20);
  }
  void victory(){
    if (victory1 && alreadywin == false){
      background(0,0,0);
      text("blue wins",width/2,height/2);
      text("press space to continu",width/2,height/2+10);
    }
    if (victory2 && alreadywin == false){
      background(0,0,0);
      text("red wins",width/2,height/2);    
      text("press space to continu",width/2,height/2+10);    
    }
  }

}
