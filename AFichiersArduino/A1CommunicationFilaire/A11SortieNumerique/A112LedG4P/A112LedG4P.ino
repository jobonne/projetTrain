/* La carte récupère H ou L et allume ou éteint la LED 13 */

#define led 13

void setup() {
  Serial.begin(9600);
  pinMode(led, OUTPUT);
}

void loop() {
  if (Serial.available()>0) {
    int hl = Serial.read();
    switch (hl)
     {
     case 'H':      
      digitalWrite(led, HIGH);
      Serial.write('H');
      break;
     case 'L':
      digitalWrite(led, LOW);
      Serial.write('L');
      break;      
     }
  }
}
