#include <Arduino.h>

void setup();
void loop();

void setup()
{
    pinMode(PC13, OUTPUT);
    Serial.begin(9600);
}

void loop()
{
    digitalWrite(PC13, HIGH);
    delay(750);
    digitalWrite(PC13, LOW);
    delay(150);
    Serial.println("Hello World!");
}
