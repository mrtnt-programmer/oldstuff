import processing.net.*;

Server s; 
Client c;
String input = "";

void setup() { 
  s = new Server(this, 6574);
}

void draw() {   
  Client thisClient = s.available();
  if (thisClient != null) {
    if (thisClient.available() > 0) {
      input = thisClient.readString(); 
      println(input);
      s.write(input);
    }
  }
}
