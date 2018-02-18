/* ARDU1 envoie un nombre entre 0 et 255 vers LOCO1 qui renvoie la valeur. La LED 3 s'allume en relation avec le nombre envoyé.
 */
 
#include <SPI.h>
#include <Mirf.h>
#include <nRF24L01.h>
#include <MirfHardwareSpiDriver.h>

byte message;
byte i=0;

void setup() {
  Serial.begin(9600);
  Serial.setTimeout(10);
  pinMode(3,1);

  Mirf.spi = &MirfHardwareSpi;
  Mirf.init();
  Mirf.payload = sizeof(byte);
  Mirf.config();
  
  Mirf.setRADDR((byte *) "ARDU1");
  Mirf.setTADDR((byte *) "LOCO1");

  Serial.println("Arduino");
}

void loop() {
  if (Serial.available()){
  message = Serial.parseInt();  
  Mirf.send((byte *) &message);
  i=1;
  }

  if(!Mirf.isSending() && Mirf.dataReady()){
  Mirf.getData((byte *) &message);
  Serial.println(message);
  if(i!=1){
    analogWrite(3,message); 
  Mirf.send((byte *) &message);
  i=0;
  }
  i=0;
  }
}
