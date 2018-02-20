import g4p_controls.*;
import processing.serial.*; 
import java.awt.Font;


GButton button1; 
GButton button2; 
GButton button3; 
GButton button4; 
GLabel label1; 
GLabel label2; 
GLabel label3; 
GLabel label4; 
Serial port;
Font fnt;

public void setup(){
  size(350, 320, JAVA2D);
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
  surface.setTitle("Sortie numérique sur 2 Arduino");
  fnt = new Font("Comic Sans MS", Font.BOLD, 18);
  button1 = new GButton(this, 55, 100, 80, 30);
  button1.setFont(fnt);
  button1.setText("Allume");
  button1.addEventHandler(this, "button1_click1");
  button2 = new GButton(this, 55, 165, 80, 30);
  button2.setFont(fnt);
  button2.setText("Eteint");
  button2.addEventHandler(this, "button2_click1");
  button3 = new GButton(this, 190, 100, 80, 30);
  button3.setFont(fnt);
  button3.setText("Allume");
  button3.addEventHandler(this, "button3_click1");
  button4 = new GButton(this, 190, 165, 80, 30);
  button4.setFont(fnt);
  button4.setText("Eteint");
  button4.addEventHandler(this, "button4_click1");
  label1 = new GLabel(this, 45, 45, 100, 20);
  label1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label1.setFont(fnt);
  label1.setText("Arduino2");
  label1.setOpaque(false);
  label2 = new GLabel(this, 45, 230, 100, 20);
  label2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label2.setFont(fnt);
  label2.setText("en attente");
  label2.setOpaque(false);
  label3 = new GLabel(this, 180, 45, 100, 20);
  label3.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label3.setFont(fnt);
  label3.setText("Arduino3");
  label3.setOpaque(false);
  label4 = new GLabel(this, 180, 230, 100, 20);
  label4.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label4.setFont(fnt);
  label4.setText("en attente");
  label4.setOpaque(false);
}

public void button1_click1(GButton source, GEvent event) {
  port.write('H');
  println("allumé");
  delay(10);
  if(port.read()=='H'){label2.setText("allumé");}
  }


public void button2_click1(GButton source, GEvent event) {
  port.write('L');
  println("éteint"); 
  delay(10);
  if(port.read()=='L'){label2.setText("éteint");}
  }
 

public void button3_click1(GButton source, GEvent event) { 
  port.write('A');
  println("allumé");
  delay(10);
  if(port.read()=='A'){label4.setText("allumé");}
  }

public void button4_click1(GButton source, GEvent event) { 
  port.write('E');
  println("éteint"); 
  delay(10);
  if(port.read()=='E'){label4.setText("éteint");}
  }