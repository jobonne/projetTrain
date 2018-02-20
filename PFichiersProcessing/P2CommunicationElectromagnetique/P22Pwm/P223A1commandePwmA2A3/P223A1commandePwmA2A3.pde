/*Ce programme crée 4 curseurs et 6 étiquettes. 
Le premier curseur permet d'envoyer une chaime a2,s3,<0 à 255>
Le deuxième curseur permet d'envoyer une chaime a2,s5,<0 à 255>
Le troisième curseur permet d'envoyer une chaime a3,s3,<0 à 255>
Le quatrième curseur permet d'envoyer une chaime a3,s5,<0 à 255>
Ces chaines sont envoyées vers 2 cartes Arduino dans le but
d'être transmises vers 2 de leurs sorties PWM, toutes au choix.
Si la transmission s'est bien déroulée, la chaîne est retournée 
vers ce programme et affichée. 
*/

import processing.serial.*; 
import g4p_controls.*;
import java.awt.Font;

Serial port;
GLabel lb1,lb2,lb3,lb4,lb5,lb6;
GCustomSlider cs1,cs2,cs3,cs4;
Font fnt;

public void setup(){
  size(900, 200, JAVA2D);
  customGUI();
  port = new Serial(this, "/dev/ttyACM0", 9600);
}

public void draw(){  
  background(230);  
}

public void customGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Commande de 2 sorties PWM sur 2 Arduino");
  fnt = new Font("Comic Sans MS", Font.BOLD, 18);
  cs1 = new GCustomSlider(this, 50, 50, 200, 40, "grey_blue");
  cs1.setShowValue(true);
  cs1.setShowLimits(true);
  cs1.setLimits(127, 0, 255);
  cs1.setNumberFormat(G4P.INTEGER, 0);
  cs1.setOpaque(false);
  cs1.addEventHandler(this, "cs1_change1");
  lb1 = new GLabel(this, 300,50, 120, 30);
  lb1.setTextAlign(GAlign.CENTER, GAlign.LEFT);
  lb1.setText("en attente");
  lb1.setOpaque(false);
  lb1.setFont(fnt);
  cs2 = new GCustomSlider(this, 50, 130, 200, 40, "grey_blue");
  cs2.setShowValue(true);
  cs2.setShowLimits(true);
  cs2.setLimits(127, 0, 255);
  cs2.setNumberFormat(G4P.INTEGER, 0);
  cs2.setOpaque(false);
  cs2.addEventHandler(this, "cs2_change1");
  lb2 = new GLabel(this, 300,130, 120, 30);
  lb2.setTextAlign(GAlign.CENTER, GAlign.LEFT);
  lb2.setText("en attente");
  lb2.setOpaque(false);
  lb2.setFont(fnt);
  cs3 = new GCustomSlider(this, 500, 50, 200, 40, "grey_blue");
  cs3.setShowValue(true);
  cs3.setShowLimits(true);
  cs3.setLimits(127, 0, 255);
  cs3.setNumberFormat(G4P.INTEGER, 0);
  cs3.setOpaque(false);
  cs3.addEventHandler(this, "cs3_change1");
  lb3 = new GLabel(this, 750,50, 120, 30);
  lb3.setTextAlign(GAlign.CENTER, GAlign.LEFT);
  lb3.setText("en attente");
  lb3.setOpaque(false);
  lb3.setFont(fnt);
  cs4 = new GCustomSlider(this, 500, 130, 200, 40, "grey_blue");
  cs4.setShowValue(true);
  cs4.setShowLimits(true);
  cs4.setLimits(127, 0, 255);
  cs4.setNumberFormat(G4P.INTEGER, 0);
  cs4.setOpaque(false);
  cs4.addEventHandler(this, "cs4_change1");
  lb4 = new GLabel(this, 750,130, 120, 30);
  lb4.setTextAlign(GAlign.CENTER, GAlign.LEFT);
  lb4.setText("en attente");
  lb4.setOpaque(false);
  lb4.setFont(fnt);
  lb5 = new GLabel(this, 90,0, 120, 30);
  lb5.setTextAlign(GAlign.CENTER, GAlign.LEFT);
  lb5.setText("Arduino2");
  lb5.setOpaque(false);
  lb5.setFont(fnt);
  lb6 = new GLabel(this, 540,0, 120, 30);
  lb6.setTextAlign(GAlign.CENTER, GAlign.LEFT);
  lb6.setText("Arduino3");
  lb6.setOpaque(false);
  lb6.setFont(fnt);
}

public void cs1_change1(GCustomSlider source, GEvent event) { 
  port.write("a2,s3,"+str(cs1.getValueI()));//exemple a2,s3,123
  println(cs1.getValueI());
  delay(40);
  lb1.setText((port.readString()));
} 

public void cs2_change1(GCustomSlider source, GEvent event) { 
  port.write("a2,s5,"+str(cs2.getValueI()));//exemple a2,s5,234
  println(cs2.getValueI());
  delay(40);
  lb2.setText((port.readString()));
} 

public void cs3_change1(GCustomSlider source, GEvent event) { 
  port.write("a3,s3,"+str(cs3.getValueI()));//exemple a3,s3,123
  println(cs3.getValueI());
  delay(40);
  lb3.setText((port.readString()));
} 

public void cs4_change1(GCustomSlider source, GEvent event) { 
  port.write("a3,s5,"+str(cs4.getValueI()));//exemple a3,s5,234
  println(cs4.getValueI());
  delay(40);
  lb4.setText((port.readString()));
} 