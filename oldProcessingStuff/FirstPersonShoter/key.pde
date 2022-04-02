int x, y, z;
int jumpstate,speed;
boolean up, left, down, right,jump,touchground=true;

void move() {
 if (millis()%100 < 16){
   if (touchground){
     speed = 8;
   }else{
     speed = 5;
   }
   if (jump) {
     jumping();
   }
 }
   if (up) {
    x +=  sin(xRad) * -speed;
    z +=  cos(xRad) * speed;
   }
   
  if (left) {
    x += speed * sin(xRad + PI/2);
    z += -speed * cos(xRad + PI/2);
  }
  if (right) {
    x += -speed * sin(xRad + PI/2);
    z += speed * cos(xRad + PI/2);
  }
 
   if (down) {
    x +=  sin(xRad) * speed;
    z +=  cos(xRad) * -speed;
   }

  // println(x, y, z
  
}

void jumping(){
  touchground = false;
  if (jumpstate<30){
    y += 15;
  }
  if(jumpstate>30){
    y -= 5;
  }
  if (jumpstate == 120){
    jumpstate = 0;
    jump = false;
    touchground = true;
  }else{
    jumpstate ++;
  }
}

void keyPressed() {

  if (key == 'w') {
    up = true;
  }

  if (key == 'a') {
    left = true;
  }
  if (key == 's') {
    down = true;
  }
  if (key == 'd') {
    right = true;
  }
  if (key == ' ') {
    jump = true;
  }
}


void keyReleased() {

  if (key == 'w') {
    up = false;
  }

  if (key == 'a') {
    left = false;
  }
  if (key == 's') {
    down = false;
  }
  if (key == 'd') {
    right = false;
  }
}
