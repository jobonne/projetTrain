/*
LOCO1 reçoit un message de ARDU1 qui le renvoie à LOCO1
*/

#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>

byte message;
//byte i=0;

const byte slaveAddress[5] = {"LOCO1"};
const byte masterAddress[5] = {"ARDU1"};

RF24 radio(8,7);

void setup() {
  Serial.begin(9600);
  radio.begin();
  radio.setRetries(1,15); // delay, count
  radio.openWritingPipe(masterAddress);
  radio.openReadingPipe(1, slaveAddress);
  radio.startListening();  
  Serial.println("Loco");
}

void loop() {
  if (Serial.available()){
    radio.stopListening();  
    message = Serial.read();
    radio.write( &message, sizeof(byte) );
    delay(1);
    //i =1;
    radio.startListening();     
  }
  
  if (radio.available()) {        
        radio.read(&message,sizeof(byte));          
        Serial.print(message);
        Serial.print(" ");
        Serial.write(message);
        delay(1);
        Serial.println();
          //if(i==0){
            radio.stopListening();
            radio.write( &message, sizeof(byte) );
            delay(1);
            radio.startListening();            
            //}        
    }
    //i=0;
}
