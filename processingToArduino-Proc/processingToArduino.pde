

import processing.serial.*;
Serial myPort; 



void setup(){
  
  myPort = new Serial(this, Serial.list()[0], 9600);
  
}


void draw(){
  
  // Clear output channel
  myPort.clear(); 

  // 'H' for start of Heating Pad desired temp
//  myPort.write('H');  // Ascii for H
//  delay(500);
//  myPort.write(15);  
//  delay(500);
//  myPort.write('&');
//  delay(500);
  
  
  byte bits[] = {'H', 15, 'X', '&'};
  myPort.write(bits[0]);
//  delay(500);
  myPort.write(bits[1]);
//  delay(500);
  myPort.write(bits[2]);
//  myPort.clear();
  delay(300);
  int read = myPort.read();
  println("prog2: " + read);
  delay(300);
  
  
  
  
  

  if(0 < myPort.available()){
    // println(" ");
    
    byte[] inBuffer = new byte[255];
    myPort.readBytesUntil('&', inBuffer);
    
    if(inBuffer != null){
      String bufferString = new String(inBuffer);
//      println("bufferString "+ bufferString.toString());
      String[] bufferArray = splitTokens(bufferString, "&");
//      println("bufferArray");
//      for(int i=0; i<bufferArray.length; i++){
//        println(" "+bufferArray[i]);
//      }
//      println("end bufferArray");
      if(bufferArray.length < 2) return;

      String[] dhtSensor = splitTokens(bufferArray[0], "dht");
      if(dhtSensor.length < 3) return;

//      println(dhtSensor);  
      // dhtSensor[0] is the " ";
      // dhtSensor[1] is humidty percentage
      // dhtSensor[2] is temperature
     float desiredTemp = Float.valueOf(dhtSensor[2]).floatValue(); 
     println("desired temp: " + desiredTemp);
    } 
    
  }
}
