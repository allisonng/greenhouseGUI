import processing.serial.*;

Serial myPort;
PFont font;

int valP_light;
int valP_slider;

byte[] inBuffer = new byte[255]; //size of the serial buffer to allow for end of data characters and all chars (see arduino code)

void setup() {
 size(400, 600); //size of window
 noStroke();
 frameRate(10); // Run 10 frames per second
 
 //font file has to be in the same folder as sketch (go Tools/ CreateFont/etc...)
 font = loadFont("Calibri-24.vlw");
   // Open the port that the board is connected to and use the same speed (9600 bps)
 myPort = new Serial(this, "/dev/tty.usbmodem1421", 9600);
}

void draw() {
 
 if (0 < myPort.available()) { // If data is available to read,
 
 println(" ");
 
 myPort.readBytesUntil('&', inBuffer); //read in all data until '&' is encountered
 
 if (inBuffer != null) {
 String myString = new String(inBuffer);
 //println(myString); //for testing only
 
 
 //p is all sensor data (with a's and b's) ('&' is eliminated) ///////////////
 
 String[] p = splitTokens(myString, "&"); 
 if (p.length < 2) return; //exit this function if packet is broken
 println(p[0]); //for testing only
 
 //get light sensor reading //////////////////////////////////////////////////
 String[] light_sensor = splitTokens(p[0], "a"); //get light sensor reading 
 if (light_sensor.length != 3) return; //exit this function if packet is broken
 //println(light_sensor[1]);
 valP_light = int(light_sensor[1]);
 
 print("light sensor:");
 print(valP_light);
 println(" "); 
 
 //get the slider reading ///////////////////////////////////////////////////
 String[] slider_sensor = splitTokens(p[0], "b");
 if (slider_sensor.length != 3) return;
 valP_slider = int(slider_sensor[1]);
 
 print("slider sensor");
 print(valP_slider);
 println(" ");
 
 
 //add some code here if you use 3 or more sensors ////////////////////////////
 
 //display square and circle with text above, to illustrate functionality of code
 
 background(245); // Clear background
 

 textFont(font); 
 text("light sensor: ", 210, 170);
 text(valP_light, 340,170);
 fill(valP_light);
 ellipse(290, 290, 200,200);
 //done
 }
 }
}
