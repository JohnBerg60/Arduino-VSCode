#include <Arduino.h>
#include <Wire.h>

void setup();
void loop();

#define LED PC13

void setup()
{
    pinMode(LED, OUTPUT);
    Serial.begin(9600);
    Wire.begin();
}

void loop()
{ 
    digitalWrite(LED, HIGH);
    delay(500);
    digitalWrite(LED, LOW);
    delay(500);
    Serial.println("Hello World!");
}
