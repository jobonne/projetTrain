/*LOCO1 reçoit les messages de ARDU1, les décode, allume les LED 3 et 5
 * en fonction de la valeur reçue puis renvoie le message vers ARDU1.
 */
 
#include <SPI.h>      
#include <Mirf.h>     
#include <nRF24L01.h> 
#include <MirfHardwareSpiDriver.h>

typedef struct {
  byte arduino;
  byte commande;
  byte valeur;
} MaStructure;

void setup() {
  Serial.begin(9600);
  pinMode(3,1);
  pinMode(5,1);
  
  Mirf.spi = &MirfHardwareSpi; 
  Mirf.init();  
  Mirf.payload = sizeof(MaStructure);
  Mirf.channel=100;
  Mirf.config(); 
  
  Mirf.setRADDR((byte *) "LOCO1");
  Mirf.setTADDR((byte *) "ARDU1"); 
  
  Serial.println("Loco1"); 
}

void loop() {
  MaStructure message;

  if(!Mirf.isSending() && Mirf.dataReady()){
    Mirf.getData((byte*) &message); 
    Serial.print(" arduino = "); 
    Serial.print(message.arduino);
    Serial.print(" commande = "); 
    Serial.print(message.commande);
    Serial.print(" valeur = ");
    Serial.println(message.valeur);
    analogWrite(message.commande,message.valeur);
    
    Mirf.send((byte*) &message);
    //while(Mirf.isSending());
  }
}
/*
 void setup() {
  Serial.begin(9600);
  Mirf.spi = &MirfHardwareSpi; 
    Mirf.init();  
    Mirf.payload = sizeof(byte);
    Mirf.setRADDR((byte *) "ARDU1");
}
 
void loop() {
  if (Serial.available()){    
  message = Serial.read();
  switch(message){
  case 'H':
    Mirf.channel=100;  
    Mirf.setTADDR((byte *) "LOCO1"); 
    Mirf.config();
   break;
   case 'L':  
    Mirf.channel=100;  
    Mirf.setTADDR((byte *) "LOCO1"); 
    Mirf.config();
   break;
   case 'A':
    Mirf.channel=50;  
    Mirf.setTADDR((byte *) "LOCO2"); 
    Mirf.config();
   break;
   case 'E':
    Mirf.channel=50;  
    Mirf.setTADDR((byte *) "LOCO2"); 
    Mirf.config();
   break;
    }
  Mirf.send((byte *) &message);
  }
  
  if(!Mirf.isSending() && Mirf.dataReady()){
  Mirf.getData((byte *) &message); 
  Serial.write(message);
  }
}  
 * /
 */
