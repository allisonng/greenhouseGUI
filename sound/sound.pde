import ddf.minim.*; 
AudioPlayer song; 
Minim minim; 
boolean userKnowsMoist = false; 
int humitLevel = 0 ;
int inputLevel = 3 ;

void setup()
{
  size (100, 100); 
  minim = new Minim (this); 
  song = minim.loadFile("waterdrop.mp3");
  song.loop(2);
  //this loads soang.mp3 from the data folder
  draw();
}

void draw(){

  if (humitLevel <= inputLevel)
  {
    // If the user isn't aware of sound and hasn't pressed stop.
    if(userKnowsMoist == false){
//      song.play();
//    song.pause();
      song.loop();
      
    }
  } 
  else 
  {
     song.pause(); 
     userKnowsMoist = false;
   }

  
}

void mousePressed(){
  userKnowsMoist = true;
  println("I know!");
}
