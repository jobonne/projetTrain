/* Ouvrir le moniteur série et envoyer un entier entre 0 et 255. 
 L'éclairage de la LED dépend du nombre envoyé. 
 La carte renvoie l'entier vers l'ordinateur.
 Remarque: 
 Serial.setTimeout(2) à 9600
 Serial.setTimeout(1) à 115200
 */
  
#define led 3 

byte val;
unsigned long instant0,instantA,instantR;
 
void setup() { 
  pinMode(led,OUTPUT); 
  Serial.begin(9600); 
  Serial.setTimeout(2);
} 

void loop() { 
  if (Serial.available()) { 
  instant0=micros();
  val=Serial.parseInt(); 
  instantA=micros();  
  analogWrite(led,val); 
  Serial.print(val); 
  instantR=micros();
  Serial.print(" durée aller: ");
  Serial.print(instantA-instant0);  
  Serial.print(" µs "); 
  Serial.print(" durée retour: ");
  Serial.print(instantR-instantA);  
  Serial.println(" µs "); 
  } 
} 
