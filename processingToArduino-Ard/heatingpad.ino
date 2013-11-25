
#include "DHT.h"
#define DHTPIN 2
#define DHTTYPE DHT11

DHT dht(DHTPIN, DHTTYPE);

char bits[3];

void setup(){
 pinMode(13, OUTPUT); 
 pinMode(12, OUTPUT);

 Serial.begin(9600);
 
 dht.begin();

}

void loop(){
  // 255 is max
//  Serial.write('C'); // prints 67 to table
  
  
  if(Serial.available() > 0){

    digitalWrite(12, HIGH);
    delay(200);
    digitalWrite(12, LOW);      
    delay(200);
    
    // Means & will not actually be read
    Serial.readBytesUntil('&', bits, 4);
    Serial.flush();
    Serial.write(bits[1]); // confirm temperature was received    
//    byte incomingByte = Serial.read();
//    byte nextByte = Serial.read();
//    byte lastByte = Serial.read();
    // nextByte = nextByte - '0';
    
    
    if(bits[0] == 'T'){
      
      if(bits[1] >=20 ){
        
        analogWrite(9, 255);
        digitalWrite(13, LOW); 
        delay(500);    
      }
      else{
        analogWrite(9, 0);
      }
    } 
 
//    if(bits[2] == 'X'){
//
//      digitalWrite(13, HIGH);  
//      analogWrite(9, 0);
//      digitalWrite(12, LOW);
//      delay(500);
//    }
  }
  
  
  
  
  
  
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
  
}
