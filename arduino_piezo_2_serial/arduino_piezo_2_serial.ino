
void setup() {
  Serial.begin(9600);
}

void loop() {
  // to communicate to processing

  String json;
  json = "{\"p1\":";
  json = json + analogRead(0);
  json = json + ",\"p2\":";
  json = json +  analogRead(1);
  json = json + ",\"p3\":";
  json = json +  analogRead(2);
  json = json + ",\"p4\":";
  json = json +  analogRead(3);
  json = json + ",\"p5\":";
  json = json +  analogRead(4);
  json = json + "}";
  Serial.println(json);


  // to trace the output
  /*
    Serial.print(analogRead(0));
    Serial.print(",");
    Serial.print(analogRead(1));
    Serial.print(",");
    Serial.print(analogRead(2));
    Serial.print(",");
    Serial.print(analogRead(3));
    Serial.print(",");
    Serial.print(analogRead(4));
    Serial.println();
    */
}
