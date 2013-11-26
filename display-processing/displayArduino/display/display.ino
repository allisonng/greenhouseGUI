
#include "DHT.h"
#define DHTPIN 2
#define DHTTYPE DHT11

DHT dht(DHTPIN, DHTTYPE);

int heatTrans = 10;
float tempLimit;
float prevTempLimit;

// SLIDER AND LIGHT SENSOR
int sliderSensor = 5;
int lightSensor = 0;
int ledPin = 9; // the transistor for LED strip

// For turning off the heat
char bits[3];


void setup() {
  Serial.begin(9600); 
 
  pinMode(9, OUTPUT);
 
  dht.begin();
  
  pinMode(heatTrans, OUTPUT);
  tempLimit = 15;
  prevTempLimit = 15;
}

void loop() {
  float hum = dht.readHumidity();
  float currTemp = dht.readTemperature();
 
  tempLimit = prevTempLimit;
  
  Serial.println(" ");
  // Make sure h and t read are numbers, NaN = not a number
  // ifnan is true, then oopsies
  if(isnan(currTemp) || isnan(hum)){
    Serial.print("DHT error");
  }
  else{
    Serial.print("dht");
    Serial.print(hum);
    Serial.print("dht");
    Serial.print(currTemp);
    Serial.print("dht");
  }
  
  // LIGHT AND SLIDER INFORMATION
  int sliderVal = analogRead(sliderSensor);
  int lightVal = analogRead(lightSensor)/6; // 6 instead of 4 stabilizes light

  // the lowest the slider sensor can go is ~23, not 0 to turn off
  int min = 20;
  int sliderMap = map(sliderVal, min, 1024, 0, 255);
    
  if(lightVal <= min){
    analogWrite(ledPin, sliderMap); 
  } else{
    analogWrite(ledPin, 0);
  }
  
  Serial.print("l"); // l for light sensor
  Serial.print(lightVal);
  Serial.print("l");  
  
  // DONE SENDING INFO, SEND '&'
  Serial.print("&");  

  /*
    Need to find out from Processing what desired temperature is
   */  
   /*
   if(Serial.available() > 0){
//
//    digitalWrite(12, HIGH);
//    delay(100); // anything higher than 100 will delay bits[1] light
//    digitalWrite(12, LOW);      
//    delay(100);
    
    // Means & will not actually be read
    Serial.readBytesUntil('&', bits, 4);
//    Serial.flush();    
    
    // If input is temperature limit
    if(bits[0] == 'T'){
      
      tempLimit = bits[1];
      prevTempLimit = tempLimit;
      
      if(currTemp > tempLimit){ 
        // If current temp is greater than user's desired limit,
        // then turn off transistor to heat pads!      
        analogWrite(heatTrans, 0);
      }
      else{
        analogWrite(heatTrans, 255);
      }
    } 
   }
   */
   
  
}
