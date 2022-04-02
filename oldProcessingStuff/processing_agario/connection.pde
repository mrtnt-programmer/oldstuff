int id = 567808765;  // numéro du joueur
String input; // entrée brute du serveur
int data[]; // tableau séparant les différentes données


void connected(){
  if (c.available() > 1) {
    input = c.readString(); // lit les infos envoyé du serveur
    input = input.substring(0, input.indexOf("\n")); // séparle les paquets par retour à la ligne
    data = int(split(input, ' '));  // spérare les valeurs qui sont marqué par un ESPACE pour les mettres dans un tableau.
    
    if (data[0] != id){
      ellipse(data[1], data[2], data[3], data[3]);
    }
  }
}
