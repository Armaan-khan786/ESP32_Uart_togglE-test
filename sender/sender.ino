// sender.ino
#define TX_PIN 17
#define RX_PIN 16
#define BAUD_RATE 115200

bool state = true;  // start at '1'

void setup() {
  Serial.begin(115200);
  Serial2.begin(BAUD_RATE, SERIAL_8N1, RX_PIN, TX_PIN);
}

void loop() {
  for (int i = 0; i < 5; i++) {
    Serial2.write(state ? '1' : '0');
    state = !state;
    delay(10);
  }
  Serial2.write('\n');
  delay(500);
}