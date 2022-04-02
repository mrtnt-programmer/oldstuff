/*a mettre dans les boucle principale

import processing.net.*;

void setup(){
  c = new Client(this,"192.168.1.63", 6574);// rejoin un serveur 
}

void draw(){
    chat();
}

void keyPressed(){
  clavierchat();
}

void mousePressed(){
  chatbouton();
}

void mouseWheel(MouseEvent event) {//bouge le chat
   chatscroll(event);
}
*/
Client c;
String input,output;
StringList data = new StringList();
String envoi = "";
StringList archive = new StringList();



int mousewheel;
int textTHICK = 30;//modifie le taille du text
int ecart = 4;// ecart verticale entre les text
int Xchat = 0, Ychat=0;//les coordonne haut gauche du chat
int gameXchat, gameYchat;//la hauteur/largeur du chat
String name = "Mrtnt";//nom du joueur

int Xboutonchat, Yboutonchat;//les coordonne haut gauche du bouton pour minimiser
int boutonsizechat;//hauteur/largeur du bouton
boolean checkboutonchat = true;
;

void chat(){
  //definire les variable ici
  Xchat = width/2;//les coordonne haut gauche du chat
  Ychat=0;//les coordonne haut gauche du chat
  gameXchat = width/2;//largeur du chat
  gameYchat = height/2;//hauteur du chat
  boutonsizechat = width/20;//taille du bouton du chat
  Xboutonchat = gameXchat - width/40 - boutonsizechat;//calcule la coordonne haut gauch du bouton
  Yboutonchat = width/40;//j'utilise width et non height pour la beauter
  //mantenant on affiche
  connectchat();//connect au chat
  if(checkboutonchat){
    afficherarchive();//affiche tout les vieux message
    bardechat();//affiche ce qu'on ecrit
  }
  boutonchat();//affiche le bouton
  
}

void connectchat() {//connect au serveur pour les message des autre joueur
  if (c.available() > 0) {
    input = c.readString();
    archive.append(input);
  }
}

void boutonchat(){
  circle(Xboutonchat+boutonsizechat/2+Xchat,Yboutonchat+boutonsizechat/2+Ychat,boutonsizechat);
}

void chatscroll(MouseEvent event) {//bouge le chat
  mousewheel += event.getCount()*10;//changer la valeur de defaut 10 pour la sensibiliter du mousewheel
  if (mousewheel > 0) {
    mousewheel = 0;
  }
  if (mousewheel < -(gameYchat-(textTHICK+ecart)*4)) {
    mousewheel = -(gameYchat-(textTHICK+ecart)*4);
  }
}

void bardechat() {//affiche ce qu'on ecrit 
  textSize(textTHICK);
  text(envoi, Xchat+(ecart*2), gameYchat-2);
}

void afficherarchive() {//affiche tout les vieux message 
  push();
  fill(200, 200, 200);
  rect(Xchat+2, Ychat+2, gameXchat-4, gameYchat-4);//backgrond
  pop();
  push();
  translate(0, mousewheel);
  for (int i = 0; i< archive.size(); i++) {
    textSize(textTHICK);
    text(archive.get(i), Xchat+(ecart*2), Ychat+gameYchat-25+-(archive.size()*textTHICK+ecart)+(i*textTHICK+ecart));
  }
  pop();
}

void chatbouton(){
  if(abs((Xchat+Xboutonchat+boutonsizechat/2)-mouseX)< boutonsizechat/2 && abs((Ychat+Yboutonchat+boutonsizechat/2)-mouseY)<boutonsizechat/2){//pour un bouton rond
  //if(Xboutonchat < mouseX && Xboutonchat + boutonWidthchat > mouseX && Yboutonchat < mouseY && Yboutonchat + boutonHeightchat > mouseY ){//pour un bouton carre
    checkboutonchat = !checkboutonchat;
  }
}

void  clavierchat(){// a mettre dans key pressed
  if (key == BACKSPACE){
    if (data.size()>0) data.remove(data.size()-1);
  }else{
    if (key != CODED && checkboutonchat){
      String charKey = Character.toString(key);
      data.append(charKey);
    }
  }
  
  envoi = join(data.array(),"");
  //println(envoi);
  if (key ==  ENTER){
    if (envoi.length()>1) c.write(name +": "+ envoi);
    data.clear();
    envoi = "";
  }
  }
