#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>

typedef struct {
  byte arduino;
  byte commande;
  byte valeur;
} MaStructure;

const byte addressA[5] = {"ARDU1"};
const byte address1[5] = {"LOCO1"};
const byte address2[5] = {"LOCO2"};

RF24 radio(8,7);

void setup() {
  Serial.begin(9600);
  Serial.setTimeout(3);
  Serial.println("Arduino");
}

void loop() {
  MaStructure message;
 
  if (Serial.available()){
  message.arduino= Serial.parseInt();
  message.commande = Serial.parseInt();
  message.valeur = Serial.parseInt();
    switch(message.arduino){
        case 2:
          Serial.println(message.arduino);
            radio.begin();
            radio.setChannel(100);  
            radio.openWritingPipe(address1); 
            break;
        case 3:
          Serial.println(message.arduino);
            radio.begin();
            radio.setChannel(50);  
            radio.openWritingPipe(address2); 
            break;   
        }
  radio.write( &message, sizeof(MaStructure) );
  radio.startListening();
  }
}
