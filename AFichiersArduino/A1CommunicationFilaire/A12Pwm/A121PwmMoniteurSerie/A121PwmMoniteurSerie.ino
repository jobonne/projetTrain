/* Ouvrir le moniteur série et envoyer un entier entre 0 et 255. 
 L'éclairage de la LED dépend du nombre envoyé. 
 La carte renvoie l'entier vers l'ordinateur. */
  
#define led 3 

byte val;
 
void setup() { 
  pinMode(led,OUTPUT); 
  Serial.begin(9600); 
} 

void loop() { 
  if (Serial.available()) { 
  val=Serial.parseInt(); 
  Serial.println(val); 
  analogWrite(led,val); 
  } 
} 
