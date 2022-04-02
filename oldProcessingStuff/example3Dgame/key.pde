int x, y, z;

boolean up, left, down, right;

void move() {
 
  if (up) {
    x -=  sin(xRad) * 5;
    z +=  cos(xRad) * 5;
  }

  if (left) {
    x += 5 * sin(xRad + PI/2);
    z -= 5 * cos(xRad + PI/2);
  }
  if (right) {
    x -= 5 * sin(xRad + PI/2);
    z += 5 * cos(xRad + PI/2);
  }
  if (down) {
    x += 5 * sin(xRad);
    z -= 5 * cos(xRad);
  }
  // println(x, y, z);
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
