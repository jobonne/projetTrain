/* Envoyer 0b01000000 (soit 64 en décimal) est le 
 * code ASCII correspondant à  @ 
 * Envoyer 0b00100000 (soit 32 en décimal) est le 
 * code ASCII correspondant à la barre d'espace.
 * ou envoyer 0b01100000 (soit 96 en décimal) est le 
 * code ASCII correspondant à l'accent grave.
*/

void setup() {

  Serial.begin(9600);
  DDRB|=0b11111111;
}

void loop() {
  if (Serial.available()) {
    unsigned long time0=micros();
    PORTB= Serial.read();
    unsigned long timeA=micros();
    Serial.print(" durée de l'aller: ");
    Serial.print(timeA-time0);
    Serial.println(" µs ");
  }
}
