/*
 *ARDUI1 envoie un message vers LOCO1 qui le renvoie à ARDU1
 */

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
  radio.openWritingPipe(slaveAddress);
  radio.openReadingPipe(1, masterAddress);
  radio.startListening(); 
  Serial.println("Arduino");
}

void loop() {
  if (Serial.available()){
    radio.stopListening();  
    message = Serial.read();
    radio.write( &message, sizeof(byte) );
    delay(1);
    //i=1; 
    radio.startListening();    
  }
  
  if (radio.available()) {        
      radio.read(&message,sizeof(byte));
      delay(1);
      Serial.print(message);
      Serial.print(" ");
      Serial.write(message);
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
