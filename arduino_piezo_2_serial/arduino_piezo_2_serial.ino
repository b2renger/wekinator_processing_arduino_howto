
void setup() {
  Serial.begin(115200);
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
  json = json + "}";
  Serial.println(json);

  // to trace the output
  /*
    Serial.print(analogRead(0));
    Serial.print(",");
    Serial.print(analogRead(1));
    Serial.print(",");
    Serial.print(analogRead(2));
    Serial.println();*/
}
