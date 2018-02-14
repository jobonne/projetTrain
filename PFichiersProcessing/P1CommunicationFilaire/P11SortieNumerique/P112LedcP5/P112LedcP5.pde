/* Ce programme crée une interface graphique avec 2 boutons cliquables et une étiquette
pour allumer ou éteindre la LED 13 puis recevoir l'accusé de réception: H ou L */

import processing.serial.*;
import controlP5.*;

Serial port;
ControlP5 cp5;
PFont pfont;
ControlFont font;
Textlabel label1,label2;

int val;

void setup() {
  size(400, 250);
  surface.setTitle("Commande d'une sortie numérique");
  port = new Serial(this, "/dev/ttyACM0", 9600);
  pfont = createFont("Comic Sans MS",20,true); 
  font = new ControlFont(pfont,241);
  cp5 = new ControlP5(this);

  cp5.addButton("allume")
      //.setValue(10)
      .setPosition(50,50)
      .setSize(100,50)
      //.setId(1);
      ;
  cp5.getController("allume")
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(24)
     ;
     
  cp5.addButton("eteint")
      .setPosition(50,150)
      .setSize(100,50)
      ;
  cp5.getController("eteint")
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(24)
     ;
     
  label1=cp5.addTextlabel("label1")
     .setPosition(200,50)
     .setText("en attente")
     .setColorValue(0xFFFF0000)//max de lumière,R,G,B
     .setFont(pfont)
     ;
     cp5.getController("label1")
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(24)
     ;
     label2=cp5.addTextlabel("label2")
     .setPosition(200,150)
     .setText("en attente")
     .setColorValue(0xFFFF0000)//max de lumière,R,G,B
     .setFont(pfont)
     ;
     cp5.getController("label2")
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(24)
     ;
}

void draw() {
    background(200);
}

public void allume() {  
    port.write('H');
    delay(10);//indispensable
    label1.setText(port.readString());
    label2.setText("");
}

public void eteint() {
    port.write('L');
     delay(10);
    label1.setText("");
    label2.setText((port.readString()));
}