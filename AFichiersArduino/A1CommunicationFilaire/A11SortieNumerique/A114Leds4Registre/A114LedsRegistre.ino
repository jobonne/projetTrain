/* Brancher 4 LED chacune avec une résistance de protection,
 sur les broches 8,9,10 et 11. 
Taper successivement les lettres majuscules de A à P 
à partir du moniteur série
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
