/*          */

import processing.serial.*;
import cc.arduino.*;
import g4p_controls.*;

Arduino arduino;


GCustomSlider cs1; 
GCustomSlider cs2; 


public void setup(){
  size(480, 320, JAVA2D);
  arduino = new Arduino(this, "/dev/ttyACM0", 57600);
  arduino.pinMode(3, Arduino.OUTPUT);
  arduino.pinMode(5, Arduino.OUTPUT);
  createGUI();
}

public void draw(){
  background(230);
}

public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Commande de 2 lampes par signaux PWM indépendants");
  cs1 = new GCustomSlider(this, 138, 89, 203, 40, "grey_blue");
  cs1.setShowValue(true);
  cs1.setLimits(127, 0, 255);
  cs1.setNumberFormat(G4P.INTEGER,0);
  cs1.setOpaque(false);
  cs1.addEventHandler(this, "cs1_change1");  
  cs2 = new GCustomSlider(this, 138, 181, 204, 40, "grey_blue");
  cs2.setShowValue(true);
  cs2.setLimits(127, 0, 255);
  cs2.setNumberFormat(G4P.INTEGER,0);
  cs2.setOpaque(false);
  cs2.addEventHandler(this, "cs2_change1");
}

public void cs1_change1(GCustomSlider source, GEvent event) { 
  arduino.analogWrite(3,cs1.getValueI());
  println(cs1.getValueI()); 
} 

public void cs2_change1(GCustomSlider source, GEvent event) { 
  arduino.analogWrite(5,cs2.getValueI());
  println(cs2.getValueI());
}