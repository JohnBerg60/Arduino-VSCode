#include <Arduino.h>

extern "C" void initialise_monitor_handles(void);

void setup();
void loop();

#define LED PC13

void setup()
{
    initialise_monitor_handles();
    pinMode(LED, OUTPUT);
}

int cnt = 0;

void loop()
{ 
    digitalWrite(LED, HIGH);
    delay(100);
    digitalWrite(LED, LOW);
    delay(100);
    printf("Count value: %d\n", cnt++);
}
