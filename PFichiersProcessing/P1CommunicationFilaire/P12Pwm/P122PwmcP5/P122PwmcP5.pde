import processing.serial.*;
import controlP5.*;

Serial port;
ControlP5 cp5;
PFont pfont;
ControlFont font;
Slider slider;
Textlabel label;
 
int curseur;

void setup() {
   size(500, 150);
   surface.setTitle("Commande d'une LED par un signal PWM");
   cp5 = new ControlP5(this);    
   port = new Serial(this, "/dev/ttyACM0", 9600);
   pfont = createFont("Comic Sans MS",20,true); 
   font = new ControlFont(pfont,24);
   cp5.setFont(font);
   slider=cp5.addSlider("curseur")
        .setRange(0,255)
        .setPosition(50,50)
        .setSize(200,50)
        .setValue(128)
        .setColorValue(0xFFFFFF00)
        .setColorLabel(0xFFFF00FF)
        ;     
   cp5.getController("curseur")
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(24)
     ;
    slider.setSliderMode(Slider.FLEXIBLE);
    label=cp5.addTextlabel("label")
     .setPosition(350,60)
     .setText("en attente")
     .setColorValue(0xFFFF0000)//max de lumière,R,G,B
     .setFont(pfont)
     ;
  cp5.getController("label")
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(24)
     ;
 }
 
 void draw() {
    background(200);
  }

 void controlEvent(ControlEvent theEvent){
   if(theEvent.getController().getName()=="curseur"){
     port.write(curseur);
     delay(10);
     label.setText(port.readString());
   }
 }