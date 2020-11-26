


void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:


 String json;
  json = "{\"p1\":"; // on ajoute la première clé "photor1"
  json = json + analogRead(0); // on ajoute la première valeur  
  json = json +",\"p2\":"; // on ajoute la seconde clé "photor2"
  json = json +  analogRead(1);// on ajoute la seconde valeur 
  json = json +",\"p3\":"; // on ajoute la seconde clé "photor2"
  json = json +  analogRead(2);// on ajoute la seconde valeur  
  json = json + "}";

  Serial.println(json);

}
