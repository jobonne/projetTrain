/*Ce programme crée 2 curseurs et 2 étiquettes. 
Le premier curseur permet d'envoyer une chaime s3,<0 à 255>
Le second curseur permet d'envoyer une chaime s5,<0 à 255>
Ces chaines sont envoyées vers une carte Arduino dans le but
d'être transmises vers 2 sorties PWM d'une autre carte Arduino.
Si la transmission s'est bien déroulée, la chaîne est retournée 
vers ce programme et affichée. 
*/

import processing.serial.*; 
import g4p_controls.*;
import java.awt.Font;

Serial port;
GLabel lb1,lb2;
GCustomSlider cs1,cs2;
Font fnt;

public void setup(){
  size(450, 200, JAVA2D);
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
  surface.setTitle("Commande de 2 sorties PWM");
  fnt = new Font("Comic Sans MS", Font.BOLD, 18);
  cs1 = new GCustomSlider(this, 50, 30, 200, 40, "grey_blue");
  cs1.setShowValue(true);
  cs1.setShowLimits(true);
  cs1.setLimits(127, 0, 255);
  cs1.setNumberFormat(G4P.INTEGER, 0);
  cs1.setOpaque(false);
  cs1.addEventHandler(this, "cs1_change1");
  lb1 = new GLabel(this, 300,30, 120, 30);
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
}

public void cs1_change1(GCustomSlider source, GEvent event) { 
  port.write("s3,"+str(cs1.getValueI()));//exemple s3,123
  println(cs1.getValueI());
  delay(30);
  lb1.setText((port.readString()));
} 

public void cs2_change1(GCustomSlider source, GEvent event) { 
  port.write("s5,"+str(cs2.getValueI()));//exemple s5,234
  println(cs2.getValueI());
  delay(30);
  lb2.setText((port.readString()));
} 