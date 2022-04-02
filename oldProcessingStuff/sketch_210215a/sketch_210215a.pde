int nombre = 0;

void setup(){
  thread("fast");
}

void draw(){
  //              0123456789
  //while(nombre <= 9999999999L);{

}

void fast(){//utilisation de thread pour aller plus vite
  while(nombre <= 9999999999L);{
    delay(1);//delay de 1 millisecond pour ne pas exploser l'ordi
    nombre++;
    println(nombre);
  }
}
