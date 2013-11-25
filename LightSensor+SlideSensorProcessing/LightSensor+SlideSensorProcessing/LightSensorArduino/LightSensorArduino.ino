// Code to read values from two sensors and write them to the serial port

int val_light = 0;
int val_slider = 5;
int ledPin = 9;
int inputPin0 = 0; // Analog pin 0 - for light sensor
int val;
int brightness = map(val_light, 20, 1024, 255, 0);


void setup() {
 Serial.begin(9600); // Start serial communication at 9600 bps
 pinMode(ledPin, OUTPUT);
}

void loop() {
 
 //slider sensor brightness input
 val = analogRead(val_slider);
 //analogWrite(9, val / 4);
 Serial.print("test");
  
  
 //light sensor ON and OFF 
 
 //brightness = Serial.read();
 brightness = analogRead(val_light);
 //brightness = brightness + 1;
 
 val_light = analogRead(inputPin0); // Read analog input pin0 (light sensor), put in range 0 to 255
 analogWrite(ledPin, brightness / 4);
  
  if(val_light <= 20) {
    //digitalWrite(ledPin, HIGH);
    analogWrite(ledPin, val / 4);
  }
  else {
    //digitalWrite(ledPin, LOW);
    analogWrite(ledPin, 0);
  }

 Serial.print("a"); //character 'a' will delimit the reading from the light sensor
 Serial.print(val_light);
 Serial.print("a");
 Serial.println();

 //'a' packet ends
 
 Serial.print("b");
 Serial.print(val_slider);
 Serial.print("b");
 Serial.println();
 
 
 

 Serial.print("&"); //denotes end of readings from both sensors

 //print carriage return and newline

 Serial.println();


}

