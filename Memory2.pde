//Kartenklasse für die zweite Kondition


class secondMemory {
  
  PImage bild;
  int back = 0;
  int cardW = 105;
  int cardH = 130;
  int cardX = 0;
  int cardY = 0;
  int faceValue = 0;
  String[] bildName = {"backside.jpg", "eiskunstläuferin2.jpg", "football2.jpg", "fallschirm2.jpg", "skateboard2.png", "fallschirmspringer2.jpg", "schlittschuh2.jpg",  "skater2.jpg", "footballplayer2.jpg"};
  
  //Konstrunktor
  secondMemory(int x, int y, int fv) {
   cardX=x;
   cardY=y;
   faceValue=fv;
  }
  
  void display() {
   bild = loadImage(bildName[back]);
   //pushstyle
   
   image(bild, cardX, cardY, cardW, cardH);
     //popstyle
// tint farbwerte in der kartenklasse definieren. wenn die karte gezeichnet wird (in der for schleife), dann kann man sich auch die 2. kartenklasse sparen (indem man beim ersten durchlauf nichts zuweist).
  }
  
  void displayFront() {
   back = faceValue; 
  }
  
  void displayBack() {
   back=0; 
  }
}