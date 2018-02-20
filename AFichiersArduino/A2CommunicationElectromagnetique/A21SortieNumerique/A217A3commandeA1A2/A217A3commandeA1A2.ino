/*
LOCO2 envoie un message à ARDU1 qui le renvoie à LOCO2
*/

#include <SPI.h> 
#include <Mirf.h> 
#include <nRF24L01.h>
#include <MirfHardwareSpiDriver.h> 

byte message;

void setup() {
  Serial.begin(9600);
  pinMode(2,1);
  Mirf.spi = &MirfHardwareSpi; 
  Mirf.init(); 
  Mirf.payload = sizeof(byte); 
  Mirf.channel=50;
  Mirf.setRADDR((byte *) "LOCO2"); 
  Mirf.setTADDR((byte *) "ARDU1"); 
  Mirf.config(); 
  
  
  Serial.println("Loco2"); 
}

void loop() {
  if (Serial.available()){
  message = Serial.read();
  Mirf.send((byte *) &message);
  }
  
  if(!Mirf.isSending() && Mirf.dataReady()){
  Mirf.getData((byte *) &message); 
  Serial.print(message);
  Serial.print(" ");  
  Serial.write(message);
  Serial.println();
  
  if((message=='A')||(message=='A'+"\n")){digitalWrite(2,1);}
  if((message=='E')||(message=='E'+"\n")){digitalWrite(2,0);}
  Mirf.send((byte *) &message);
  }
} 
