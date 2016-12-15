class Memory {
  // Die Default Vorlage zur Erstellung von Spielkarten (Position, Größe, Zustand (aufgedeckt vs. verdeckt)
  
  PImage bild;
  int back = 0;
  int cardW = 150;
  int cardH = 200;
  int cardX = 0;
  int cardY = 0;
  int faceValue = 0;
  String[] bildName; 
  
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