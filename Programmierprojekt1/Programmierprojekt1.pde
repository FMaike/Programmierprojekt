Memory[] myMemory = new Memory[8];
Instruktionen[] myInstruktion=new Instruktionen[3];
int[] x = new int[8];
int[] y = new int[8];
int[] fv = new int[8];
int pair = 0;
int front = 0;
boolean[] umgedreht = new boolean[8];
String pause="Pause!";
boolean pressed = false;

void setup(){
  int myX = 15;
  int myY = 15;
  int myFv = 0;
  size(500,600);
  
  //arrays füllen
  for (int i = 0; i<8; i++) {
    y[i] = myY+50;
    x[i] = myX;
    fv[i] = i+1;
    umgedreht[i]=false;
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
  myInstruktion[1] = new Instruktionen ("Decke zwei Karen auf versuche den Sportlern ihre passenden Sportgeräte zuzuordnen. Drücke die Leertaste um ein Probespiel zu starten"); 
  myInstruktion[2]=new Instruktionen(pause);
  //legen();
}

void draw() {
  background(255);
  fill(0);
  {
    myInstruktion[1].display();
    println(pair);
  }
  for (int i = 0; i<8; i++) {
    myMemory[i].display(); //Karten mit Rückseite nach oben anzeigen
  }
  
  if (mousePressed) {
    if(front<=2){ //Es können maximal 2 Karten umgedreht werden
    aufdecken();
    // doppelanschlag bei umdrehen vermeiden
    if (pressed == false){
      pressed = true;
    }
    
    if (keyPressed == false) {
      pressed = false;
    }
    }
  }
  if(keyPressed && key=='u'){
    for (int i = 0; i<8; i++) {
    myMemory[i].displayBack();
    umgedreht[i]=false;
    front = 0;
    }
  }
  //wenn Paare gefunden werden, verschwinden die Karten vom Spielfeld
  if(umgedreht[0]==true && umgedreht[5] ==true){
   myMemory[0].cardX=-150;
   myMemory[0].cardY=-150;
   myMemory[5].cardX=-150;
   myMemory[5].cardY=-150;
   pair = pair+1;
   front=0;
   umgedreht[0]=false; umgedreht[5]=false;
   println(pair);
  }
  if(umgedreht[1]==true && umgedreht[7] ==true){
   myMemory[1].cardX=-150;
   myMemory[1].cardY=-150;
   myMemory[7].cardX=-150;
   myMemory[7].cardY=-150;
   pair = pair+1;
   front=0;
   umgedreht[1]=false; umgedreht[7]=false;
   println(pair);
  }
  if(umgedreht[2]==true && umgedreht[4] ==true){
   myMemory[2].cardX=-150;
   myMemory[2].cardY=-150;
   myMemory[4].cardX=-150;
   myMemory[4].cardY=-150;
   pair = pair+1;
   front=0;
   umgedreht[2]=false; umgedreht[4]=false;
   println(pair);
  }
  if(umgedreht[3]==true && umgedreht[6] ==true){
   myMemory[3].cardX=-150;
   myMemory[3].cardY=-150;
   myMemory[6].cardX=-150;
   myMemory[6].cardY=-150;
   pair = pair+1;
   front=0;
   umgedreht[3]=false; umgedreht[6]=false;
   println(pair);
  }
  if(pair==4){
    myInstruktion[2].display();
    println(pair);
  }
  
}

//Aufdecken der Memory Karten
void aufdecken(){
  for (int i = 0; i<8; i++) {
    if(mouseX>x[i] && mouseX<(x[i]+105) && mouseY>y[i] && mouseY<(y[i]+130)) {
      myMemory[i].displayFront();
      umgedreht[i]=true;
      front = front +1;
    }
  }
}