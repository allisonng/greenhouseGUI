import ddf.minim.*; 
AudioPlayer song; 
Minim minim; 
boolean isPlaying = false; 
boolean userKnows = false;
int humitLevel = 0 ;
int inputLevel = 3 ;

int songPlay=500;


void setup()
{
  size (100, 100); 
  minim = new Minim (this); 
  song = minim.loadFile("happy.mp3"); 
  //this loads soang.mp3 from the data folder
  
  
//  draw();
}

void draw() {
//  if (humitLevel <= inputLevel && userKnows == false) {
  if(1 < 0){

     
      song.play();

//      song.pause();
     
  }

  else 
  {
    song.pause();

  }
}

void mousePressed() {
  userKnows = true;
}

