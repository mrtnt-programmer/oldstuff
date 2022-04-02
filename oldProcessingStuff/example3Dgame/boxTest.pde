
void boxes(int xx, int yy, int zz, int siize) {
  push();
  translate(xx, yy, zz);
  box(siize);
  pop();
}
