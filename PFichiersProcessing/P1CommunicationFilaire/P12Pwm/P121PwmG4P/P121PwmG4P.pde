/* Ce programme construit un curseur pour commander une LED sur la carte Arduino
Une étiquette accuse réception */

import processing.serial.*;
import g4p_controls.*;
import java.awt.Font; 

Serial port;
GCustomSlider cs; 
GLabel label; 
Font fnt;

public void setup(){
  size(300,200, JAVA2D);
  port = new Serial(this, "/dev/ttyACM0", 9600);
  createGUI();  
}

public void draw(){
  background(210);  
}

public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Commande d'un signal PWM");
  fnt = new Font("Comic Sans MS", Font.BOLD, 18);
  cs = new GCustomSlider(this, 50, 30, 200, 40, "grey_blue");
  cs.setShowValue(true);
  cs.setShowLimits(true);
  cs.setLimits(127, 0, 255);
  cs.setNumberFormat(G4P.INTEGER, 0);
  cs.setOpaque(false);
  cs.addEventHandler(this, "cs_change1");
  label = new GLabel(this, 100, 100, 120, 30);
  label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label.setFont(fnt);
  label.setText("en attente");
  label.setOpaque(false);
}

public void cs_change1(GCustomSlider source, GEvent event) { 
  port.write(cs.getValueI());
  println(cs.getValueI());
  delay(10);
  label.setText((port.readString()));
} 