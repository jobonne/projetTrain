/*ARDU1 envoie vers LOCO1 2 types de messsages:
 * a2,s3,<entier de 0 à 255> ou a2,s5,<entier de 0 à 255>
 * Si ces messages sont transmis par LOCO1, ils sont envoyés 
 * vers l'interface Processing
 * idem vers LOCO2
 */
 
#include <SPI.h>      
#include <Mirf.h>     
#include <nRF24L01.h>
#include <MirfHardwareSpiDriver.h> 

//byte message;

typedef struct {
  byte arduino;
  byte commande;
  byte valeur;
} MaStructure;
 
void setup() {
  Serial.begin(9600);
  Serial.setTimeout(3);
   
  Mirf.spi = &MirfHardwareSpi; 
  Mirf.init();   
  Mirf.payload = sizeof(MaStructure);
  //Mirf.config();
  
  Mirf.setRADDR((byte *) "ARDU1");
  //Mirf.setTADDR((byte *) "LOCO1"); 
}
/*
void setup() {
  Serial.begin(9600);
  Mirf.spi = &MirfHardwareSpi; 
    Mirf.init();  
    Mirf.payload = sizeof(byte);
    Mirf.setRADDR((byte *) "ARDU1");
}
*/

void loop() {
  MaStructure message;
  
  if (Serial.available()){ 
  message.arduino= Serial.parseInt();
  message.commande = Serial.parseInt();
  message.valeur = Serial.parseInt();
  switch(message.arduino){
    case 2:
        Mirf.channel=100;  
        Mirf.setTADDR((byte *) "LOCO1"); 
        Mirf.config();
        break;
    case 3:
        Mirf.channel=50;  
        Mirf.setTADDR((byte *) "LOCO2"); 
        Mirf.config();
        break;    
  }
  Mirf.send((byte*) &message);
  } 
  
  if(!Mirf.isSending() && Mirf.dataReady()){
  Mirf.getData((byte *) &message); 
  Serial.print(message.arduino);Serial.print("  ");
  Serial.print(message.commande);Serial.print("  ");
  Serial.println(message.valeur);
  }
}

