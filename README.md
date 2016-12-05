# Programmierprojekt

Memory[] myMemory = new Memory[6];
int[] x = new int[6];
int[] y = new int[6];
int[] fv = new int[6];

void setup(){
  int myX = 15;
  int myY = 15;
  int myFv = 0;
  size(500,600);
  
  //arrays füllen
  for (int i = 0; i<6; i++) {
    y[i] = myY;
    x[i] = myX;
    fv[i] = i+1;
    if(myX<345){
     myX = myX+115; 
    }
    else if(myX>345) {
      myX = 15;
      myY = myY +150;
    }
  }
  for (int i = 0; i<6; i++) {
    myMemory[i] = new Memory (x[i], y[i], fv[i]);
  }
}

void draw() {
  for (int i = 0; i<6; i++){
    myMemory[i].display();
  }
  
  if (mousePressed) {
    aufdecken();
  }
}

//Aufdecken der Memory Karten
void aufdecken(){
  for (int i = 0; i<6; i++) {
    if(mouseX>x[i] && mouseX<(x[i]+105) && mouseY>y[i] && mouseY<(y[i]+130)) {
      myMemory[i].displayFront();
    }
  }
}
