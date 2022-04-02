import processing.net.*;
Server serveur;
Client client;
int X,Y;
PImage fond;
boolean L,R,U,D;
public ArrayList<Joueur> joueurs;
ArrayList<Point> points;

Server s; // créer un objet serveur
Client c; // créer un objet client
int size = 40;


void setup(){
  size(800,600);
  fond = loadImage("aga.png");
  fond.resize(width,height);
  joueurs = new ArrayList<Joueur>();
  points = new ArrayList<Point>();
  joueurs.add(new Joueur(1,20,20,50));
  fairdespoint();
  c = new Client(this,"127.0.0.1",12345);
}

void draw(){
  background(200,200,200);//fond
  
  push();
  translate(X,Y);
  scale(4);
  image(fond,0,0);//grille inutile
  pop();
  
  push();
  fill(255,0,255);//violet yeaya
  strokeWeight(8);//boum la taille de contour
  stroke(0,255,255);//bordure bleu ha
  ellipse(height/2,width/2,50,50);//le cercle principale
  pop();
  
  afficherpoint();
  move();
  connected();
  c.write(id+ " "+ X + " " + Y + " " + size + "\n"); // //envoie les informations aux clients 
}

 
void afficherpoint(){
  for(int i = 0;i < 200;i++){
    Point p = points.get(i);
    p.update();
  }  
}

void keyPressed(){
  if (keyCode == RIGHT){
    R = true;
  }
  if (keyCode == LEFT){
    L = true;
  }  
  if (keyCode == UP){
    U = true;
  }
  if (keyCode == DOWN){
    D = true;
  }
}

void keyReleased(){
  if (keyCode == RIGHT){
    R = false;
  }
  if (keyCode == LEFT){
    L = false;
  }  
  if (keyCode == UP){
    U = false;
  }
  if (keyCode == DOWN){
    D = false;
  }
}

void fairdespoint(){
  for(int i = 0;i < 200;i++){
    points.add(new Point());
  }
  
}

  void move(){
    if (R){
      X -=5;
    }
    if (L){
      X +=5;
    }  
    if (U){
      Y +=5;
    }
    if (D){
      Y -=5;
    }
  }  
