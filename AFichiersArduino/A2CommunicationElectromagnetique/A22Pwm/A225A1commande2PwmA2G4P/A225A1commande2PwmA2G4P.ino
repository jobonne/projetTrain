/*ARDU1 envoie vers LOCO1 2 types de messsages:
 * s3,<entier de 0 à 255> ou s5,<entier de 0 à 255>
 * Si ces messages sont transmis par LOCO1, ils sont envoyés 
 * vers l'interface Processing
 */
 
#include <SPI.h>      
#include <Mirf.h>     
#include <nRF24L01.h>
#include <MirfHardwareSpiDriver.h> 
 
typedef struct {
  byte commande;
  byte valeur;
} MaStructure;
 
void setup() {
  Serial.begin(9600);
  Serial.setTimeout(10);
   
  Mirf.spi = &MirfHardwareSpi; 
  Mirf.init();   
  Mirf.payload = sizeof(MaStructure);
  Mirf.config();
  
  Mirf.setRADDR((byte *) "ARDU1");
  Mirf.setTADDR((byte *) "LOCO1"); 
}
 
void loop() {
  MaStructure message;
  
  while(!Serial.available()); 
  message.commande = Serial.parseInt();
  message.valeur = Serial.parseInt();
  
  Mirf.send((byte*) &message); 
  while(Mirf.isSending()); 
  if(!Mirf.isSending() && Mirf.dataReady()){
    Mirf.getData((byte*) &message); 
    Serial.print(message.commande);Serial.print(" ");
    Serial.println(message.valeur);
} 
}
