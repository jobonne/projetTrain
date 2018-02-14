/* Envoyer 0b00000000 (soit 0 en décimal) est le 
 * code ASCII correspondant à  Ctrl@ 
 * Envoyer 0b00100000 (soit 32 en décimal) est le 
 * code ASCII correspondant à la barre d'espace.
*/

void setup() {

  Serial.begin(9600);
  DDRB|=0b100000;
}

void loop() {
  if (Serial.available()) {
    unsigned long time0=micros();
    PORTB= Serial.read();
    unsigned long timeA=micros();
    Serial.print(timeA-time0);
    Serial.println(" µs ");
  }
}
