#include <Arduino.h>

void setup();
void loop();

void setup()
{
    pinMode(PA4, OUTPUT);
    Serial.begin(9600);
}

void loop()
{ 
    digitalWrite(PA4, HIGH);
    delay(150);
    digitalWrite(PA4, LOW);
    delay(150);
    Serial.println("Hello World!");
}
