void setup() {
  Serial.begin(9600);
  Serial3.begin(9600);

}

void loop() {
  // read from port 0, send to port 1:
  if (Serial.available()) {
    int inByte = Serial.read();
    Serial3.print(inByte);

  }
  // read from port 1, send to port 0:
  if (Serial3.available()) {
    int inByte = Serial3.read();
    Serial.println(inByte);
  }
}
