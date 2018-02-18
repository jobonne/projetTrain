/* Ce programme crée une interface graphique avec 2 boutons cliquables 
pour allumer ou éteindre la LED 13 à condition d'avoir téléversé le programme Arduino adapté dans la carte */

import processing.serial.*; 
import g4p_controls.*;
import java.awt.Font;

Serial port; 
GButton button1; 
GButton button2;
GLabel label1; 
GLabel label2;  
Font fnt;

public void setup(){
  size(350, 100, JAVA2D);
  customGUI();
  port = new Serial(this, "/dev/ttyACM0", 9600);
  //String nomPort = Serial.list()[0];
  //port = new Serial(this, nomPort, 9600);
  //utiliser ces 2 lignes si /dev/ttyACM0 n'est pas reconnu  
}

public void draw(){  
  background(230);  
}

public void customGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Commande d'une sortie numérique");
  fnt = new Font("Comic Sans MS", Font.BOLD, 18);
  button1 = new GButton(this, 40, 15, 80, 30);
  button1.setFont(fnt);
  button1.setText("Allume");
  button1.addEventHandler(this, "button1_click1");
  button2 = new GButton(this, 40, 55, 80, 30);
  button2.setFont(fnt);
  button2.setText("Eteint");
  button2.addEventHandler(this, "button2_click1");
  label1 = new GLabel(this, 150, 15, 120, 30);
  label1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label1.setText("en attente");
  label1.setOpaque(false);
  label1.setFont(fnt);
  label2 = new GLabel(this, 150, 55, 120, 30);
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setText("en attente");
  label2.setOpaque(false);
  label2.setFont(fnt);  
}

public void button1_click1(GButton source, GEvent event) { 
  port.write('H');
  delay(10);
  label1.setText((port.readString()));
  label2.setText("");
  println("allumé");
} 

public void button2_click1(GButton source, GEvent event) { 
  port.write('L');
  delay(10);
  label2.setText((port.readString()));
  label1.setText("");
  println("éteint");
}