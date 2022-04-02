
import java.awt.AWTException; // pour les erreurs système
import java.awt.Robot; // pour controller la souris

Robot robby; // invoque la classe

float xRad, yRad; // variable pour l'angle de la souris en X et Y


void initMouse() { // à mettre dans la setup

  try  {
    robby = new Robot();
  }
  catch (AWTException e) {
    println("Robot class not supported by your system!");
    exit();
  }
}



void mouseMoved() {
  robby.mouseMove(displayWidth/2, displayHeight/2);
  xRad += radians( (mouseX-width/2)* 0.1);
  yRad -= radians((mouseY-height/2)* 0.1);

  println(xRad);
}
