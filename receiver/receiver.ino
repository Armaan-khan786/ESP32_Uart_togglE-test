// receiver.ino
#define TX_PIN 17
#define RX_PIN 16
#define BAUD_RATE 115200

char lastBit = 0;
int bitCount = 0;
bool toggleError = false;

void setup() {
  Serial.begin(115200);
  Serial2.begin(BAUD_RATE, SERIAL_8N1, RX_PIN, TX_PIN);
}

void loop() {
  while (Serial2.available()) {
    char c = Serial2.read();

    if (c == '\n') {
      if (!toggleError && bitCount == 5) {
        Serial.println("UART TOGGLE TEST PASS");
      } else {
        Serial.println("UART TOGGLE TEST FAIL");
      }

      // reset
      lastBit = 0;
      bitCount = 0;
      toggleError = false;
      return;
    }

    if (c != '0' && c != '1') {
      toggleError = true;
      continue;
    }

    if (lastBit != 0 && c == lastBit) {
      toggleError = true;  // no toggle detected
    }

    lastBit = c;
    bitCount++;
  }
}