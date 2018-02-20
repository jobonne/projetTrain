/*
ARDUI1 envoie un message vers LOCO1 qui le renvoie à ARDU1
*/

#include <SPI.h>      
#include <Mirf.h>     
#include <nRF24L01.h> 
#include <MirfHardwareSpiDriver.h> 

byte message;

void setup() {
  Serial.begin(9600);
  Mirf.spi = &MirfHardwareSpi; 
    Mirf.init();  
    Mirf.payload = sizeof(byte);
    //Mirf.channel=100;  
    Mirf.setRADDR((byte *) "ARDU1");
    //Mirf.setTADDR((byte *) "LOCO1"); 
    //Mirf.config();
}
 
void loop() {
  if (Serial.available()){    
  message = Serial.read();
  switch(message){
  case 'H':
    //Mirf.init();  
    //Mirf.payload = sizeof(byte);
    Mirf.channel=100;  
    //Mirf.setRADDR((byte *) "ARDU1");
    Mirf.setTADDR((byte *) "LOCO1"); 
    Mirf.config();
   break;
   case 'L':  
    //Mirf.init();  
    //Mirf.payload = sizeof(byte);
    Mirf.channel=100;  
    //Mirf.setRADDR((byte *) "ARDU1");
    Mirf.setTADDR((byte *) "LOCO1"); 
    Mirf.config();
   break;
   case 'A':
    Mirf.init();  
    Mirf.payload = sizeof(byte);
    Mirf.channel=50;  
    Mirf.setRADDR((byte *) "ARDU1");
    Mirf.setTADDR((byte *) "LOCO2"); 
    Mirf.config();
   break;
   case 'E':
    Mirf.init();  
    Mirf.payload = sizeof(byte);
    Mirf.channel=50;  
    Mirf.setRADDR((byte *) "ARDU1");
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
