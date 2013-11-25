import processing.serial.*;
import java.text.DecimalFormat;

PImage upArrow, downArrow;
PFont font;
float x, y;
Serial port;
float desiredTemp;  // will display -100 if no input taken
float prevDesiredTemp;
float currentTemp = 0;
DecimalFormat decFormat;
String newDesiredTempStr = ""; // only update if new != curr
String currDesiredTempStr = "";

boolean isOnTempUpArrow = false;
boolean isOnTempDownArrow = false;
boolean increaseTempCheck = false;
boolean decreaseTempCheck = false;

int upX, upY, tempDownX, tempDownY;

// Positioning
int numbBoxWidth = 48;
int numbBoxHeight = 48;
int marginFromBox = 120;



void setup(){
  size(600,600);
  background(255);
  port = new Serial(this, Serial.list()[0], 9600); 
  decFormat = new DecimalFormat("###.#");
  
  translate(x,y);
  
  font = loadFont("ArialRoundedMTBold-48.vlw");
  textFont(font, 18); 
 
  upArrow = loadImage("arrow_up.gif");
  downArrow = loadImage("arrow_down.gif"); 
  
  prevDesiredTemp = 15;
  
  numbBoxWidth = 48;
  numbBoxHeight = 48;
}


void draw(){
  /*
  NOTE TO SELF: it appears that when you do text("asd", x, y")
  it will not go x+n, y+n but rather x-n, y-n (above the designated coordinate)
  */
  
    
  // MAIN BORDER ============================================
  noFill();
  stroke(5);
  strokeWeight(5);
  rect(x + 100, y + 50, 400, 500); 
  
  
  if(0 < port.available()){
    // println(" ");
    
    byte[] inBuffer = new byte[255];
    port.readBytesUntil('&', inBuffer);
    
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
      currentTemp = Float.valueOf(dhtSensor[2]).floatValue(); 
//      println("desired temp: " + desiredTemp);
    } 
    
  }
  else{
     desiredTemp = 0; 
  }
  
  // TODO: test
//  if(desiredTemp != -100){
//     desiredTemp = prevDesiredTemp;
//       
//  }
    desiredTemp = prevDesiredTemp;
  
  // TODO: make positions more dynamic
  // Temperature
  
  
  update(mouseX, mouseY);
    
    
  /*
    Light (volume-like scale)
    Light Timer
    Current Moisture Level
    Desired Moisture Level
    Desired/Current Temperature
   */

    
  // CURRENT MOISTURE LEVEL ================================
  int cMoistHeaderX = marginFromBox;
  int cMoistHeaderY = 100;
  text("Current Moisture", cMoistHeaderX, cMoistHeaderY);
  int cMoistRectX = cMoistHeaderX + 30;
  int cMoistRectY = cMoistHeaderY +5;
  noFill();
  strokeWeight(2);
  rect(cMoistRectX, cMoistRectY, numbBoxWidth, numbBoxHeight);
  
  // DESIRED MOISTURE LEVEL =================================
  int dMoistHeaderX = marginFromBox;
  int dMoistHeaderY = cMoistHeaderY + 80;
  text("Desired Moisture", dMoistHeaderX, dMoistHeaderY);
  int dMoistRectX = dMoistHeaderX + 30;
  int dMoistRectY = dMoistHeaderY +5;
  noFill();
  strokeWeight(2);
  rect(dMoistRectX, dMoistRectY, numbBoxWidth, numbBoxHeight);  
  
  
  
  // CURRENT TEMPERATURE ==================================== 
  int cTempX = marginFromBox;  
  int cTempY = 300;
  text("Current Temperature", cTempX, cTempY);
  int cRectX = cTempX + 30;
  int cRectY = cTempY + 5;
  noFill();
  strokeWeight(2);
  rect(cRectX, cRectY, numbBoxWidth, numbBoxHeight);

   // this will cover the previous value and replace with new one
   noStroke();
   fill(255);
   rect(cTempX+32, cTempY+7, 45, 45);
   
   // If you don't put this, rectangles BEFORE will have weird greyed out border
   stroke(0); 
   fill(0);

  // format to 2 decimal places
  String currTempStr = decFormat.format(currentTemp);  
  text(currTempStr, cTempX + 45, cTempY + 35);
  

  
  // STUFF TO GO HERE LATER,
  // TURNING OFF IF CERTAIN TEMPERATURE IS REACHED


  
  
  // DESIRED TEMPERATURE =====================================
  int dTempX = marginFromBox;
  int dTempY = cTempY+80; // 180
  fill(0); //text colour

  text("Desired Temperature: ", dTempX, dTempY);
//  int cTempY= 100;

  // up arrow
  upX = dTempX;
  upY = dTempY+5;
  image(upArrow, upX, upY);
  // down arrow
  tempDownX = upX; // arrow dimensions are 20x25 WxH
  tempDownY = dTempY+32;
  image(downArrow, tempDownX, tempDownY);


  //box position for desired temperature number
  noFill();
  strokeWeight(2);
  rect(dTempX+30, upY, numbBoxWidth, numbBoxWidth);

  
//  println("Desiredtemp: " + desiredTemp);
  if(desiredTemp != -100){
    if(increaseTempCheck){
      desiredTemp = desiredTemp+1;
      increaseTempCheck = false;
    }
    else if(decreaseTempCheck){
      // Set minimum temperature to 10.
      // Cannot go lower than 10.
      if(desiredTemp > 10){
//        println("\t decrease!");
        desiredTemp = desiredTemp-1;
      }
      decreaseTempCheck = false;

    }
    
//    println("Desiredtemp: " + desiredTemp);

    currDesiredTempStr = decFormat.format(desiredTemp);
    prevDesiredTemp = desiredTemp;
    //newDesiredTempStr = currDesiredTempStr; // only update if new != curr
 
     // this will cover the previous value and replace with new one
     noStroke();
     fill(255);
     rect(dTempX+32, upY+2, 45, 45);
   
     // If you don't put this, rectangles BEFORE will have weird greyed out border
     stroke(0); 
     fill(0);
     
     text(currDesiredTempStr, dTempX+45, dTempY+35);
     
     // Send what temperature to turn off the heat pads at
     byte bits[] = {'T', byte(desiredTemp), 'X', '&'};
     for(int i=0; i<bits.length; i++){
       port.write(bits[i]);
       delay(100);
     
     }
     
     println("bits[1]: " + bits[1]);
     
   //}
  }
  
  
   //println("mouseX :" + mouseX + "\tmouseY: " + mouseY); 
   //println("upX :" + upX + "\tupY: " + upY + "\t" + (upX+20) + "\t" + (upY+26)); 
   delay(200); 
  
}

// capture mousex and mousey at that current moment
void update(int mousex, int mousey){
  if(overTempUpArrow(mousex, mousey)){
    // println("isOnTempUpArrow");
    isOnTempUpArrow = true;
  }
  else if(overTempDownArrow(mousex, mousey)){
    // println("isOnTempDOWNArrow");
    isOnTempDownArrow = true;
  }
  else{ 
//    For some reason when program runs, 
//    overTempUpArrow returns true, so this is needed. 
    isOnTempUpArrow = false;
    isOnTempDownArrow = false;
  }
//  else if(overTempDownArrow(mousex, mousey)){

  
}

void mousePressed(){
  if(isOnTempUpArrow){
    // println("mouse pressed");
    increaseTempCheck = true;
    isOnTempUpArrow = false;
  }
  else if(isOnTempDownArrow){
    // println("MP on Down");
    decreaseTempCheck = true;
    isOnTempDownArrow = false;
  }
}

boolean overTempUpArrow(int mousex, int mousey){
 /* 
   if mouse coordinates are within the current box of the arrow
  */ 
  // arrow size is 20x26
  if((upX <= mousex && mousex <= upX+upArrow.width) && (upY <= mousey && mousey <= upY+upArrow.height)){
  //if((100 <= mouseX && mouseX <= 200) && (100 <= mouseY && mouseY <= 200)){
     // mousePressedCheck = true;
     // println("Inside UP, TRUE");
     return true;
  } else {
     // mousePressedCheck = false;
//     ln("Not inside UP, false");
     return false;
  }    
}

boolean overTempDownArrow(int mousex, int mousey){
  if((tempDownX <= mousex && mousex <= tempDownX+downArrow.width) && (tempDownY <= mousey && mousey <= tempDownY+downArrow.height)){
    // println("Inside DOWN, TRUE");
    return true;
  } else{
//    println("Not inside DOWN, false");
    return false;
  }
}

