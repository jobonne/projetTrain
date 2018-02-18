/* A partir d'Arduino1 on commande une LED branchée sur la broche 2 d'Arduino2. Un accusé de réception permet de savoir que l'ordre a été transmis. */

import processing.serial.*; 
import g4p_controls.*;
import java.awt.Font;

GButton button1; 
GButton button2; 
GLabel label; 
Serial port;
Font fnt;

public void setup(){
  size(480, 320, JAVA2D);
  port = new Serial(this, "/dev/ttyACM0", 9600);
  customGUI();
}

public void draw(){
  background(230);  
}


public void customGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Commande à distance d'une sortie numérique");
  fnt = new Font("Comic Sans MS", Font.BOLD, 18);
  button1 = new GButton(this, 178, 60, 80, 30);
  button1.setFont(fnt);
  button1.setText("Allume");
  button1.addEventHandler(this, "button1_click1");
  button2 = new GButton(this, 178, 120, 80, 30);
  button2.setFont(fnt);
  button2.setText("Eteint");
  button2.addEventHandler(this, "button2_click1");
  label = new GLabel(this, 178, 180, 120, 30);
  label.setOpaque(true);
  label.setFont(fnt);
  label.setText("en attente");
}


public void button1_click1(GButton source, GEvent event) {
  port.write('H');
  println("allumé");
  delay(10);
  if(port.read()=='H'){label.setText("allumé");}
  }

public void button2_click1(GButton source, GEvent event) {
  port.write('L');
  println("éteint"); 
  delay(10);
  if(port.read()=='L'){label.setText("éteint");}
  }