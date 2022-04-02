class Loop extends Thread{
  long threadID;
  Loop(long threadID){
    this.threadID =threadID;
  }
  public void run(){
    while(start){
      delay(1);//pour calmer l'ordi
      i++;
      println(threadID +" "+ i);

    }
  }
}



long i;
boolean start = true;
void setup(){
  size(80,80);
  for(int i = 0;i<10;i++){
  Loop loop = new Loop(i);
  loop.start();
  }
}

void draw(){

  println(i);
}
