/* Ce programme crée une interface graphique avec 2 boutons cliquables 
pour allumer ou éteindre la LED 13 à condition d'avoir téléversé le programme Arduino adapté dans la carte */

import processing.serial.*; 
import g4p_controls.*;

Serial port; 
GButton button1; 
GButton button2; 

public void setup(){
  size(350, 100, JAVA2D);
  customGUI();
  port = new Serial(this, "/dev/ttyACM0", 9600);
  //ttyACM0 ou autre 
}

public void draw(){
  background(230);  
}

public void customGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Commande d'une sortie numérique");
  button1 = new GButton(this, 140, 13, 80, 30);
  button1.setText("Allume");
  button1.addEventHandler(this, "button1_click1");
  button2 = new GButton(this, 140, 56, 80, 30);
  button2.setText("Eteint");
  button2.addEventHandler(this, "button2_click1");
}

public void button1_click1(GButton source, GEvent event) {
  int allume = 0b100000;
port.write(allume);
println("allumé");
}
public void button2_click1(GButton source, GEvent event) {
int eteint = 0b000000;
port.write(eteint);
println("éteint");
}