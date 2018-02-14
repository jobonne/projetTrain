/* Traitement d'une chaîne du type "s3,200\n" en vue d'envoyer sur la broche 3 en PWM la valeur 200 */ 

void setup() {
  Serial.begin(9600);
  pinMode(3,OUTPUT);
  pinMode(5,OUTPUT);
}

void loop() {
  int led = 3;
  int val = 0;
  
  if (Serial.find("s")) {
    led = Serial.parseInt();
    val = Serial.parseInt();
    analogWrite(led,val);
    Serial.print(led);
    Serial.print("   ");
    Serial.print(val);
  }
}

