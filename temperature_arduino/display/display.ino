
#include "DHT.h"
#define DHTPIN 2
#define DHTTYPE DHT11

DHT dht(DHTPIN, DHTTYPE);

int hpTrans = 9;

void setup() {
  Serial.begin(9600); 
 
  dht.begin();
  pinMode(hpTrans, OUTPUT);
}

void loop() {
  // Reading temperature or humidity takes about 250 milliseconds!
  // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)
  float h = dht.readHumidity();
  float t = dht.readTemperature();
  
  Serial.println(" ");
  // Make sure h and t read are numbers, NaN = not a number
  // ifnan is true, then oopsies
  if(isnan(t) || isnan(h)){
    Serial.print("DHT error");
  }
  else{
    Serial.print("dht");
    Serial.print(h);
    Serial.print("dht");
    Serial.print(t);
    Serial.print("dht");
    
    // DONE SENDING INFORMATION
    Serial.print("&");
    
  }
  
  /*
    Need to find out from Processing what desired temperature is
   */  
   
    if(Serial.available() > 0){
    byte incomingByte = Serial.read();
    byte nextByte = Serial.read();
    
    nextByte = nextByte - '0';
    
    if(incomingByte == 'H'){
      analogWrite(9, 255);
      digitalWrite(13, LOW);
    }
    else if(incomingByte == 15){
      digitalWrite(13, HIGH);  
      analogWrite(9, 0);
    }
  }  
  
  
}
