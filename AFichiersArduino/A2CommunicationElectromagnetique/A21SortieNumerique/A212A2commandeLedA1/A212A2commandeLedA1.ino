/*
LOCO1 envoie un message à ARDU1 qui le renvoie à LOCO1
Taper Z sur LOCO1: la LED 2 s'allume et celle branchée sur la broche  3  s'allume pendant 100 ms puis s'éteint.
Sur chaque moniteur série il doit y avoir le message 90 Z
Taper n'importe quel autre caractère sur le moniteur série de LOCO1 éteint la LED.
Sur chaque moniteur série il doit y avoir un  message constitué du  cade ASCII du caractère suivi du caractère.
Si la LED branchée sur la broche 3 d'une des cartes reste allumée, cela signifie que la transmission du message 
entre les cartes n'a pas eu lieu.
*/

#include <SPI.h>
#include <Mirf.h>
#include <nRF24L01.h>
#include <MirfHardwareSpiDriver.h>

byte message;
byte i=0;

void setup() {
  Serial.begin(9600);
  pinMode(2,1);
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
  if (Serial.available()){
  message = Serial.read();
  Mirf.send((byte *) &message);
  if(message=='Z'){
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
  Serial.print(message);
  Serial.print(" ");
  Serial.write(message);
  Serial.println();

  if(message=='Z'){
  delay(200);
  digitalWrite(3,0);}

  if(i!=1){
  Mirf.send((byte *) &message);
  i=0;
  }
  i=0;
  }
} 
