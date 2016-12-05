# Programmierprojekt

Memory[] myMemory = new Memory[8];
int[] x = new int[8];
int[] y = new int[8];
int[] fv = new int[8];

void setup(){
  int myX = 15;
  int myY = 15;
  int myFv = 0;
  size(500,600);
  
  //arrays füllen
  for (int i = 0; i<8; i++) {
    y[i] = myY;
    x[i] = myX;
    fv[i] = i+1;
    if(myX<345) {
     myX = myX+115; 
    }
    else if(myX>345) {
      myX = 15;
      myY = myY +150;
    }
  }
  for (int i = 0; i<8; i++) {
    myMemory[i] = new Memory (x[i], y[i], fv[i]);
  }
  //legen();
}

void draw() {
  for (int i = 0; i<8; i++) {
    myMemory[i].display();
  }
  
  if (mousePressed) {
    aufdecken();
  }
}

//Aufdecken der Memory Karten
void aufdecken(){
  for (int i = 0; i<8; i++) {
    if(mouseX>x[i] && mouseX<(x[i]+105) && mouseY>y[i] && mouseY<(y[i]+130)) {
      myMemory[i].displayFront();
    }
  }
}

--------------------------------------------------------------------------------------------------------------------------------

class Memory {
  
  PImage bild;
  int side = 0;
  int cardW = 105;
  int cardH = 130;
  int cardX = 0;
  int cardY = 0;
  int faceValue = 0;
  String[] bildName = {"filou.jpg", "eiskunstläuferin.jpg", "fallschirm.jpg", "fallschirmspringer.jpg", "schlittschuh.jpg", "skateboard.png", "skater.jpg", "football.jpg", "footballplayer.jpg"};
  
  //Konstrunktor
  Memory(int x, int y, int fv) {
   cardX=x;
   cardY=y;
   faceValue=fv;
  }
  
  void display() {
   bild = loadImage(bildName[side]);
   image(bild, cardX, cardY, cardW, cardH);
  }
  
  void displayFront() {
   side = faceValue; 
  }
  
  
  
}

