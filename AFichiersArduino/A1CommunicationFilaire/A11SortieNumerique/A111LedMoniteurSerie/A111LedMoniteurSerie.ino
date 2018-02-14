/* Ouvrir le moniteur série, option: pas de fin de ligne puis taper H pour
allumer la LED 13 ou L pour l'éteindre. Envoyer vers la carte. La carte
répond par "allumé" ou "éteint" ou par un message d'erreur.
Autres informations: durée de la communication aller et durée de la communication retour*/

#define led 13
unsigned long instant0,instantA,instantR;

void setup() {
  Serial.begin(9600);
  pinMode(led, OUTPUT);
}

void loop() {
  if (Serial.available()) {
  instant0=micros();
  int hl = Serial.read();
   switch (hl)
    {
    case 'H':
      digitalWrite(led, HIGH);
      instantA=micros();
      Serial.print("allumé - ");
      instantR=micros();
    break;
    case 'L':
      digitalWrite(led, LOW);
      instantA=micros();
      Serial.print("éteint - ");
      instantR=micros();
    break;
    default:
      instantA=micros();
      Serial.print("taper H ou L -");
      instantR=micros();
    }
    Serial.print(" durée de l'aller: ");
    Serial.print(instantA-instant0);
    Serial.print(" µs ");
    Serial.print(" durée du retour: ");
    Serial.print(instantR-instantA);
    Serial.println(" µs"); 
  }
}
