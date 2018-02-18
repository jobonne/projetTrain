/*LOCO1 reçoit un entier de 0 à 255 de ARDU1 et le retourne
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

  Mirf.setRADDR((byte *) "LOCO1");
  Mirf.setTADDR((byte *) "ARDU1");

  Serial.println("Loco");
}

void loop() {
  if(!Mirf.isSending() && Mirf.dataReady()){
  Mirf.getData((byte *) &message);
  Serial.println(message);

    analogWrite(3,message); 
  Mirf.send((byte *) &message);
  }
}
