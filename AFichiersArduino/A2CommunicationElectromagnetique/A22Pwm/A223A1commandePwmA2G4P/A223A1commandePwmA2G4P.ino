/*ARDU1 envoie un entier de 0 à 255 vers LOCO1 qui le retourne
 */
 
#include <SPI.h>
#include <Mirf.h>
#include <nRF24L01.h>
#include <MirfHardwareSpiDriver.h>

byte message;

void setup() {
  Serial.begin(9600);
  pinMode(3,1);

  Mirf.spi = &MirfHardwareSpi;
  Mirf.init();
  Mirf.payload = sizeof(byte);
  Mirf.config();
  
  Mirf.setRADDR((byte *) "ARDU1");
  Mirf.setTADDR((byte *) "LOCO1");  
}

void loop() {
  if (Serial.available()){
  message = Serial.read();  
  Mirf.send((byte *) &message);
  }
  
  if(!Mirf.isSending() && Mirf.dataReady()){
  Mirf.getData((byte *) &message);
  Serial.println(message);
  }
}
