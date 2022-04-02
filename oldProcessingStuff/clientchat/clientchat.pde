import processing.net.*;
void setup() {
  size(800,600);
  c = new Client(this,"192.168.1.63", 6574);// lance un serveur
}
void draw(){
  background(0);
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
