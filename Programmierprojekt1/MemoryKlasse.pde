class Memory {
  
  PImage bild;
  int back = 0;
  int cardW = 105;
  int cardH = 130;
  int cardX = 0;
  int cardY = 0;
  int faceValue = 0;
  String[] bildName = {"backside.jpg", "eiskunstläuferin.jpg", "football.jpg", "fallschirm.jpg", "skateboard.png", "fallschirmspringer.jpg", "schlittschuh.jpg",  "skater.jpg", "footballplayer.jpg"};
  
  //Konstrunktor
  Memory(int x, int y, int fv) {
   cardX=x;
   cardY=y;
   faceValue=fv;
  }
  
  void display() {
   bild = loadImage(bildName[back]);
   image(bild, cardX, cardY, cardW, cardH);
  }
  
  void displayFront() {
   back = faceValue; 
  }
  
  void displayBack() {
   back=0; 
  }
}