
#include "DHT.h"
#define DHTPIN 2
#define DHTTYPE DHT11

DHT dht(DHTPIN, DHTTYPE);

int heatTrans = 9;
float tempLimit;
float prevTempLimit;

char bits[3];

void setup() {
  Serial.begin(9600); 
  pinMode(13, OUTPUT); 
 pinMode(12, OUTPUT);
 
  dht.begin();
  
  pinMode(heatTrans, OUTPUT);
  tempLimit = 15;
  prevTempLimit = 15;
}

void loop() {
  // Reading temperature or humidity takes about 250 milliseconds!
  // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)
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
    
    // DONE SENDING INFORMATION
    Serial.print("&");
    
  }
  
  /*
    Need to find out from Processing what desired temperature is
   */  
   
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
   
   
  
}
