/*
 *ARDUI1 envoie un message vers LOCO1 qui le renvoie à ARDU1
 * Taper A : la LED 2 d'Arduino s'allume et la LED 3  s'allume pendant 100 ms puis s'éteint. 
 * Sur chaque moniteur série :  message  65 A 
 * Taper n'importe quel autre caractère éteint la LED. 
 * Sur chaque moniteur série :  message constitué du  cade ASCII du caractère suivi du caractère
*/

#include <SPI.h>
#include <Mirf.h>
#include <nRF24L01.h>
#include <MirfHardwareSpiDriver.h>

byte message;
byte i=0;
unsigned long instant0, instant1;

void setup() {
  Serial.begin(9600);
  pinMode(2,1);
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
  message = Serial.read();
  instant0=micros();
  Mirf.send((byte *) &message);  
  if(message=='A'){
  digitalWrite(2,1);
  digitalWrite(3,1);
  }else{
  digitalWrite(2,0);
  digitalWrite(3,0);
  }
  i=1;
  }
  
  if(!Mirf.isSending() && Mirf.dataReady()){
  Mirf.getData((byte *) &message);
  instant1=micros();
  Serial.print(message);
  Serial.print(" ");
  Serial.write(message);
  Serial.print(" durée aller retour: ");
  Serial.print(instant1-instant0);
  Serial.println(" µs ");
  
  if(message=='A'){  
  delay(200);
  digitalWrite(3,0);
  }

  if(i!=1){Mirf.send((byte *) &message);
  i=0;
  }
  
  i=0;
  }
}
