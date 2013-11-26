int sliderSensor = 5;
int lightSensor = 0;
int ledPin = 9;

void setup(){
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
}


void loop(){
  
  
  int sliderVal = analogRead(sliderSensor);
  int lightVal = analogRead(lightSensor)/6; // 6 instead of 4 stabilizes light
  
//  int onOff = map(sliderVal, 20, 1024, 255, 0);

  // the lowest the slider sensor can go is ~23, not 0 to turn off
  int sliderMap = map(sliderVal, 20, 1024, 0, 255);
  // IF ROOM IS DARK then control brightness by slider
  if(lightVal <= 20){
    analogWrite(ledPin, sliderMap);
//     analogWrite(ledPin, sliderVal);
  }
    // IF ROOM IS BRIGHT then turn off the LED
  else{
    analogWrite(ledPin, 0);
  }
  
 Serial.println(" ");
 Serial.print("L"); //character 'a' will delimit the reading from the light sensor
 Serial.print(lightVal);
 Serial.print("L"); 
 

 Serial.print("S");
// Serial.print(sliderVal);
 Serial.print(sliderMap);
 Serial.print("S");
 
 
 Serial.print("&");

 delay(300);
 // REMEMBER TO END IT LATER

} 
 
