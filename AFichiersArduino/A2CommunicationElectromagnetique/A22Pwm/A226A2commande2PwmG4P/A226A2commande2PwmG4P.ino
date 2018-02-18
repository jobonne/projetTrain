/*
 */
#include <SPI.h>      // Pour la communication via le port SPI
#include <Mirf.h>     // Pour la gestion de la communication
#include <nRF24L01.h> // Pour les définitions des registres du nRF24L01
#include <MirfHardwareSpiDriver.h> // Pour la communication SPI

typedef struct {
  byte commande;
  byte valeur;
} MaStructure;

void setup() {
  Serial.begin(9600);
  pinMode(3,1);pinMode(5,1);
  //Mirf.cePin = 9; // Broche CE sur D9
  //Mirf.csnPin = 10; // Broche CSN sur D10
  Mirf.spi = &MirfHardwareSpi; // On veut utiliser le port SPI hardware
  Mirf.init(); // Initialise la bibliothèque

  Mirf.channel = 1; // Choix du canal de communication (128 canaux disponibles, de 0 à 127)
  Mirf.payload = sizeof(MaStructure); // Taille d'un message (maximum 32 octets)
  Mirf.config(); // Sauvegarde la configuration dans le module radio

  Mirf.setTADDR((byte *) "nrf01"); // Adresse de transmission
  Mirf.setRADDR((byte *) "nrf02"); // Adresse de réception

  Serial.println("Loco"); 
}

void loop() {
  MaStructure message;

  if(!Mirf.isSending() && Mirf.dataReady()){
    Mirf.getData((byte*) &message); // Réception du paquet
    
    Serial.print("commande="); // Affiche le message
    Serial.print(message.commande);
    Serial.print(" valeur=");
    Serial.println(message.valeur);
    analogWrite(message.commande,message.valeur);
    
    Mirf.send((byte*) &message);
    while(Mirf.isSending());
  }
  //
}
