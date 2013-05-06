Farbergé Egg Break
==================

This is a simple sketch, where using your computer's accelerometer, you can tip the Fabergé Egg from its pedestal and make it break. The sketch uses Shiffman's Sudden Motion Sensor Processing Library and Box2D. Unfortunately, it seems like the SMS library no longer works with either Lion or the new Processing 2.0b8.

You could also write a simple Arduino sketch and write to the serial port. Sketch can be simple like this (you might need to change the mapping values):


`void setup() {
  Serial.begin(9600);
}

void loop() {
  Serial.write(map(analogRead(A0), 260, 406, 0, 100));
  delay(100); 
}`