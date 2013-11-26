import processing.serial.*;


Serial port;
PFont font;

int lightVal, sliderVal;

byte[] inBuffer = new byte[255];

void setup(){
  size(400, 600); 
  noStroke();
  frameRate(10);
  
  font = loadFont("ArialRoundedMTBold-48.vlw");
  port = new Serial(this, Serial.list()[0], 9600); 

}


void draw(){
  if(port.available() > 0){
   println(" ");
   port.readBytesUntil('&', inBuffer);
   
   if(inBuffer!= null){
     String myString = new String(inBuffer);
     
     String[] lightAndSliderStr = splitTokens(myString, "&");
     if(lightAndSliderStr.length < 2) return;
//     println(lightAndSliderStr[0]); // TESTSTESTEST
     
     // Light Sensor Reading
     String[] lightSensor = splitTokens(lightAndSliderStr[0], "L");
     lightVal = int(lightSensor[1]);
     
     
     if(lightVal > 5){
       // Light is off
      print("sunshine is on"); 
     }
     else{
      print("LED is on");       
     }
     print("\nlight sensor: " + lightVal);
    
     
   }
  }
  
}
