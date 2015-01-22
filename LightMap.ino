/*
  LightMap V 1.00
  
  This software + hardware is designed to map lighting intensity in a serie of 
  successive locations.
  
  It outputs the resistance value of the photoresistor (LDR) but it would need 
  further calibration to be used as a luxmeter.
  
  It was designed to measure light uniformity in an indoor seedling rack and can 
  be useful for lighting devices designers, stage lighting, etc ...
 
  The sensor is made of a photoresistor (LDR) in parrallel with a switch and a 
  0.1uF capacitor.
  The sensor is connected between ground and the analog pin. An external pullup 
  resistor is connected to Vcc. The capacitor allows smoothing, but limits accurate 
  read speed to less than 2 measurements/second. It's large value allows for long 
  wires between the sensor and the board.
  
  the default values allow the device to be implemented on a 7 pins female header 
  connected on the "Vin" corner of a Nano board.
  
  The user positions the sensor, then clicks. Each clic sends a light intensity value 
  through the serial port and sounds the beeper as a feedback.
  
  The LED will blink at one half the sampling rate and will go blank when a value is sent.
 
  Using a white paper with a set of marked locations will give a good positional 
  repeatability for the measurements.
 
  This software is Copyright 1988-2014 by Eric Vinter and is distributed under the 
  terms of the GNU General Public License.

  This program is free software; you can redistribute it and/or modify it under the 
  terms of the GNU General Public License as published by the Free Software Foundation;
  either version 2 of the License, or any later version.

  This program is distributed in the hope that it will be useful, but WITHOUT ANY 
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR 
  A PARTICULAR PURPOSE. See the GNU General Public License for more details.

  You should have received a copy of the GNU General Public License along with this 
  program. If not, see < http://www.gnu.org/licenses/ >.


  Contact: https://github.com/ermtl/LightMap   

 */
 
 const int PhotoresistorPin = A7; // Pin where the photoresistor is connected (to the ground, with 18Ko pullup resistor)
       int BeeperPin = A5;        // The beeper is connected between this pin and +5V
       int LedPin  = 13;          // Standard LED on pin 13;
       int Samples = 200;         // Number of analog samples per value (averaging)
       int ClosedVal = 150;       // Value below witch the contact is considered closed
       float Rpullup = 18000;     // Pullup resistor (can be changed depending on LDR type and useable range)
       float Vcc = 5.0;           // Power supply (usually 5V or 3.3V)
       float Version = 1.00;      // Software version
 

// the setup function runs once when you press reset or power the board
// 2 beeps at start (1 long beep if serial port fails to start)
void setup() {

  // initialize led pin as an output.
  pinMode(LedPin, OUTPUT);
  // initialize beeper pin as an output.
  pinMode(BeeperPin, OUTPUT);
  digitalWrite(BeeperPin, LOW);    // turn the beeper on
  delay(50);                       // wait for 50 ms
  
  Serial.begin(115200); 
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }

  // prints title with ending line break 
  Serial.print("Light Map V"); Serial.print(Version);Serial.println(" (Value in Ohms)");
  
  digitalWrite(BeeperPin, HIGH);   // turn the beeper off
  delay(150);              // wait a bit
  digitalWrite(BeeperPin, LOW);    // turn the beeper on
  delay(50);              // wait for 50 ms
  digitalWrite(BeeperPin, HIGH);   // turn the beeper off

}

long  val, val1, val2, val3;
float Vout,R;

// the loop function runs over and over again forever
void loop() {
  val=0;
  for (int cnt=0; cnt < Samples; cnt++){ val+= analogRead(PhotoresistorPin); } 
  val = (val*10) / Samples;
  if ((val<ClosedVal) && (val1>ClosedVal) && (val2>ClosedVal) && (val3>ClosedVal))
   {
    digitalWrite(LedPin, LOW);  
    Vout=((val3)*Vcc)/10240.0;
    R=Rpullup*((Vcc/(Vcc-Vout)) -1);
 //   Serial.print(Vout); 
 //   Serial.print("V "); 
    Serial.print(R); 
 //   Serial.print("Ohms "); 
 //   Serial.print(val3); 
    Serial.println(); 
    digitalWrite(BeeperPin, LOW);    // turn the beeper on
    delay(50);              // wait for 50 ms
    digitalWrite(BeeperPin, HIGH);   // turn the beeper off   
   } 
  digitalWrite(LedPin, !digitalRead(LedPin)); 
  val3=val2; 
  val2=val1; 
  val1=val;   
}
