/* Le programme reçoit un entier de 0 à 255 réglant le signal PWM et la luminosité de la LED branchée sur cette sortie PWM */

#define led 3
byte val;
 
void setup() {
  pinMode(led,OUTPUT);
  Serial.begin(9600);
}
 
void loop() {
  if (Serial.available()) {  
    val=Serial.read();  
    analogWrite(led,val);
    Serial.print(val);
  }
}
