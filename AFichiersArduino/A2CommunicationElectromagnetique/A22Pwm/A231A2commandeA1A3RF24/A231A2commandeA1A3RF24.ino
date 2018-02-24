#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>

typedef struct {
  byte arduino;
  byte commande;
  byte valeur;
} MaStructure;

const byte address1[5] = {"LOCO11"};
const byte addressA[5] = {"ARDU1"};

RF24 radio(8,7);

void setup() {
  Serial.begin(9600);
  Serial.setTimeout(3);
  pinMode(2,1);
  pinMode(3,1);
  radio.begin();
  radio.setChannel(100);
  radio.openWritingPipe(addressA);
  radio.openReadingPipe(1, address1);
  radio.startListening();
  Serial.println("Loco1");
}

void loop() {

MaStructure message;

  if (radio.available()) {
    radio.read(&message,sizeof(MaStructure));
    delay(10);
    analogWrite(message.commande,message.valeur);
    Serial.print(message.arduino);
    Serial.print(" ");
    Serial.print(message.commande);
    Serial.print(" ");
    Serial.println(message.valeur);
  }
}
