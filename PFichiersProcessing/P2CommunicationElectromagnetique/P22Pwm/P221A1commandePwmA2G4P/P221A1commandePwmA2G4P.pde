/* A partir d'Arduino1 on commande à l'aide d'un curseur un signal \lstinline!PWM! envoyé vers une LED branchée sur la broche 3 d'Arduino2. Un accusé de réception permet de savoir que l'ordre a été transmis. */

import processing.serial.*; 
import g4p_controls.*;
import java.awt.Font;

GCustomSlider slider; 
GLabel label; 
Serial port;
Font fnt;

public void setup(){
  size(350, 150, JAVA2D);
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
  surface.setTitle("Commande à distance d'une sortie PWM");
  fnt = new Font("Comic Sans MS", Font.BOLD, 18);
  slider = new GCustomSlider(this, 70, 30, 200, 40, "grey_blue");
  slider.setShowValue(true);
  slider.setShowLimits(true);
  slider.setLimits(127, 0, 255);
  slider.setNumberFormat(G4P.INTEGER, 0);
  slider.setOpaque(false);
  slider.addEventHandler(this, "slider_change1");  
  label = new GLabel(this, 120, 80, 120, 30);
  label.setOpaque(true);
  label.setFont(fnt);
  label.setText("en attente");
}


public void slider_change1(GCustomSlider source, GEvent event) { 
  port.write(slider.getValueI());
  println(slider.getValueI());
  delay(20);
  label.setText((port.readString()));
} 