


void setup() {
  noCursor();
  size(800, 600, P3D);
  initMouse();
}


void draw() {
  background(0);

  translate(width/2, height/2, 0);
  translate(0, 0, 500);
  rotateY(xRad);
  //rotateX(radians(yRad));
  move();
  translate(x, y, z);
//rect(-1000,0,1000,1000);
boxes(0,0,500, 200);
boxes(500,0,0, 200);
boxes(-500,0,0, 200);
boxes(0,0,-500, 200);

}
