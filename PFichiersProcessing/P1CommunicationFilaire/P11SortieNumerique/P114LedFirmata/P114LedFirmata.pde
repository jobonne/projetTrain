/* Ce programme allume ou éteint la LED 13.
Il faut préalablement avoir téléversé la bibliothèque Fichier/Exemples/Firmata/StandardFirmata dans la carte Arduino */

import processing.serial.*; 
import g4p_controls.*;
import cc.arduino.*;

Arduino arduino;

Serial port; 
GButton button1; 
GButton button2; 

int ledPin = 13;

public void setup(){
  size(350, 100, JAVA2D);
  customGUI();
  arduino = new Arduino(this, "/dev/ttyACM0", 57600);
  arduino.pinMode(ledPin, Arduino.OUTPUT);
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
   arduino.digitalWrite(ledPin, Arduino.HIGH);
   println("allumé");
}
public void button2_click1(GButton source, GEvent event) {
   arduino.digitalWrite(ledPin, Arduino.LOW);
   println("éteint");
}