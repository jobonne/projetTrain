/*
LOCO1 envoie un message à ARDU1 qui le renvoie à LOCO1
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
  Mirf.config(); 

  Mirf.setRADDR((byte *) "LOCO1"); 
  Mirf.setTADDR((byte *) "ARDU1");   

  Serial.println("Loco"); 
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
  
  if((message=='H')||(message=='H'+"\n")){digitalWrite(2,1);}
  if((message=='L')||(message=='L'+"\n")){digitalWrite(2,0);}
  Mirf.send((byte *) &message);
  }
} 
