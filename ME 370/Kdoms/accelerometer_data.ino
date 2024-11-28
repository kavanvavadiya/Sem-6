/*
Vibration Data Acquisition and Analysis
ME370
A program to acquire data using the MMA7361 accelerometer

Prepared by: Abhilash Patel
Instructor: Prof. Salil Kulkarni & Prof. Darshan Shah

*/

float x,y,z;  
// Declaring variable to store the voltage values
 
void setup()
{
  // Starting the Serial Communication
  Serial.begin(9600); 
}

void loop()
{

  // measuring the voltage from the accelerometer
  
  x = analogRead(A0); // Connect X axis output to A0
  y = analogRead(A1); // Connect Y axis output to A1
  z = analogRead(A2); // Connect Z axis output to A2
  

 // converting voltage value to "Volts" and sending it to computer
  Serial.print(millis());
  Serial.print("\t");
  Serial.print(x*5.0/1024.0);
  Serial.print("\t");
  Serial.print(y*5.0/1024.0);
  Serial.print("\t");
  Serial.println(z*5.0/1024.0);

  // Set appropriate delay (in milliseconds) to achieve required sampling rate
  delay(20);
  
}
