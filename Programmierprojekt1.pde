Memory[] myMemory = new Memory[8];

secondMemory [] mySecondMemory = new secondMemory [8];

Instruktionen[] myInstruktion=new Instruktionen[5];

int[] x = new int[8];
int[] y = new int[8];
int[] fv = new int[8];
int pair = 0;
int front = 0;
boolean[] umgedreht = new boolean[8];

//Instruktionsvariablen
String pause="Du hast nun Zeit für eine kurze Pause. \nWenn du bereit bist weiterzuspielen, drücke w.";
String instrEins="Im Folgenden wird dir ein Memory-Kartenspiel Präsentiert. \nDeine Aufgabe ist es den jeweiligen Sportlern ihr \npassendes Sportgerät zuzuordnen. \nUm ein nicht passendes Kartenpaar wieder umzudrehen \ndrücke die 'u' Taste. \nUm das Spiel zu Starten drücke nun die Taste w. ";
String instrZwei="Spiele nun das Spiel noch einmal. \nOrdne den Sportlern Ihre Sportgeräte zu und versuche dich nicht von der Farbgebung der Karten ablenken zu lassen. Du startest die zweite Runde mit w.";
String endscreen = "Herzlichen Glückwunsch, du hast es geschafft! \nVielen Dank für deine Teilnahme, das Experiment ist nun beendet.";
String VPNr = "Willkommen zu diesem Experiment \nBitte gib zunächst hier deine Versuchspersonennummer ein.";
boolean seenVPNr = false;
boolean seenEins=false;
boolean seenPause=false;
boolean seenZwei=false;
boolean seenSecondGame = false;
boolean seenEndscreen =false;
boolean[] pressed=new boolean[8];
String myText = "Willkommen zu diesem Experiment. \nBitte gib zunächst hier deine Versuchspersonennummer ein.\n";


void setup() {
  int myX = 15;
  int myY = 15;
  int myFv = 0;
  size(500, 600);

  //Arrays füllen, Spielkarten Instanziieren
  for (int i = 0; i<8; i++) {
    y[i] = myY;
    x[i] = myX;
    fv[i] = i+1;
    umgedreht[i]=false;
    pressed[i]=false;
    if (myX<345) {
      myX = myX+115;
    } else if (myX>345) {
      myX = 15;
      myY = myY +150;
    }
  }
  for (int i = 0; i<8; i++) {
    myMemory[i] = new Memory (x[i], y[i], fv[i]);
  }

  for (int i = 0; i<8; i++) {
    mySecondMemory[i] = new secondMemory (x[i], y[i], fv[i]);
  }

  myInstruktion[0]=new Instruktionen(instrEins);
  myInstruktion[1]=new Instruktionen(pause);
  myInstruktion[2]=new Instruktionen(instrZwei);
  myInstruktion[3]=new Instruktionen(endscreen);
  myInstruktion[4]=new Instruktionen(VPNr);

//Form für den Eingabetext
 textSize(30);
  fill(0);

}

void draw() {
  background(255);
  fill(0);
  println(front);

if (seenVPNr == false){
  text(myText, 10, 100, width, height);
  texteingabe();
  if (keyPressed==true && key=='w') {
      seenVPNr=true;
    }
}




//Startscreen mit Versuchspersonennummereingabefeld
//if (seenVPNr == false){
//  myInstruktion[4].display();
//  if (keyPressed==true && key=='w') {
//      seenVPNr=true;
//    }
//}

//Erste Instruktion Anzeigen lassen
  if (seenVPNr == true && seenEins==false) {
    myInstruktion[0].display();
    if (keyPressed==true && key=='w') { //wenn ich dieses if rausnehme wird die nächste instruktion richtig angezeigt, so jedoch übersprungen
      seenEins=true;
    }
  }
  //Karten mit der Rückseite nach oben zeichnen;
  if (seenEins==true) {
    for (int i = 0; i<8; i++) {
      myMemory[i].display(); 
    }

    if (mousePressed) {
      if (front<=1) { //Es können maximal 2 Karten umgedreht werden
        aufdecken();
      }
    }
    if (keyPressed && key=='u') {
      for (int i = 0; i<8; i++) {
        myMemory[i].displayBack();
        umgedreht[i]=false;
        front = 0;
        pressed[i]=false;
      }
    }
    //Passende Paare finden; wenn Paare gefunden wurden, verschwinden die Karten vom Spielfeld
    if (umgedreht[0]==true && umgedreht[5] ==true) {
      myMemory[0].cardX=-150;
      myMemory[0].cardY=-150;
      myMemory[5].cardX=-150;
      myMemory[5].cardY=-150;
      //zum Gewinnen werden 4 Paare gebraucht, immer wenn eins gefunden wird, wird hochgezählt
      pair = pair+1;
      front=0;
      
      //Ist ein Paar gefunden zählen die Karten nicht mehr als umgedreht
      umgedreht[0]=false; 
      umgedreht[5]=false; 
      //println(pair);
    }
    if (umgedreht[1]==true && umgedreht[7] ==true) {
      myMemory[1].cardX=-150;
      myMemory[1].cardY=-150;
      myMemory[7].cardX=-150;
      myMemory[7].cardY=-150;
      pair = pair+1;
      front=0;
      umgedreht[1]=false; 
      umgedreht[7]=false;
      //println(pair);
    }
    if (umgedreht[2]==true && umgedreht[4] ==true) {
      myMemory[2].cardX=-150;
      myMemory[2].cardY=-150;
      myMemory[4].cardX=-150;
      myMemory[4].cardY=-150;
      pair = pair+1;
      front=0;
      umgedreht[2]=false; 
      umgedreht[4]=false;
      //println(pair);
    }
    if (umgedreht[3]==true && umgedreht[6] ==true) {
      myMemory[3].cardX=-150;
      myMemory[3].cardY=-150;
      myMemory[6].cardX=-150;
      myMemory[6].cardY=-150;
      pair = pair+1;
      front=0;
      umgedreht[3]=false; 
      umgedreht[6]=false; 
      //println(pair);
    }
    
    //folgende Klammer hab ich hier gesetzt und eine ganz am schluss weggenommen:
  }
  //Nachdem alle 4 Paare korrekt gematcht wurden wird der Pausenscreen angezeigt
    if (pair==4 && seenEins==true && seenPause==false) {
      myInstruktion[1].display();
      //println(pair);
      
//Nach dem Drücken von w während des Pausenscreens wird die zweite Instruktion gezeigt.
      if (keyPressed==true && key=='w') {
        seenPause=true;
      }
    }
    if (seenEins==true && seenPause==true&&seenZwei==false) {
      myInstruktion[2].display();
    } 
    
    //warum werden pause und zweite instruktion gleichzeitig angezeigt?!
    
    
     if (keyPressed==true && key=='w') {
      seenZwei=true;
    }
    
    
    
    
    if (seenEins==true && seenPause==true && seenZwei== true ) {
     for (int i = 0; i<8; i++) {
      mySecondMemory[i].display();
     }
     
    }
    
  //Hier wiederholt sich der Vorgang für das zweite Spiel mit der zweiten Kartenklasse
  
    if (mousePressed) {
      if (front<=1) { //Es können maximal 2 Karten umgedreht werden
        aufdecken1();
      }
    }
    if (keyPressed && key=='u') {
      for (int i = 0; i<8; i++) {
        mySecondMemory[i].displayBack();
        umgedreht[i]=false;
        front = 0;
        pressed[i]=false;
      }
    }
    //Passende Paare finden; wenn Paare gefunden wurden, verschwinden die Karten vom Spielfeld
    if (umgedreht[0]==true && umgedreht[5] ==true) {
      mySecondMemory[0].cardX=-150;
      mySecondMemory[0].cardY=-150;
      mySecondMemory[5].cardX=-150;
      mySecondMemory[5].cardY=-150;
      //zum Gewinnen werden 4 Paare gebraucht, immer wenn eins gefunden wird, wir hochgezählt
      pair = pair+1;
      front=0;
      umgedreht[0]=false; 
      umgedreht[5]=false; //Ist ein Paar gefunden zählen die Karten nicht mehr als umgedreht
      //println(pair);
    }
    if (umgedreht[1]==true && umgedreht[7] ==true) {
      mySecondMemory[1].cardX=-150;
      mySecondMemory[1].cardY=-150;
      mySecondMemory[7].cardX=-150;
      mySecondMemory[7].cardY=-150;
      pair = pair+1;
      front=0;
      umgedreht[1]=false; 
      umgedreht[7]=false;
      //println(pair);
    }
    if (umgedreht[2]==true && umgedreht[4] ==true) {
      mySecondMemory[2].cardX=-150;
      mySecondMemory[2].cardY=-150;
      mySecondMemory[4].cardX=-150;
      mySecondMemory[4].cardY=-150;
      pair = pair+1;
      front=0;
      umgedreht[2]=false; 
      umgedreht[4]=false;
      //println(pair);
    }
    if (umgedreht[3]==true && umgedreht[6] ==true) {
      mySecondMemory[3].cardX=-150;
      mySecondMemory[3].cardY=-150;
      mySecondMemory[6].cardX=-150;
      mySecondMemory[6].cardY=-150;
      pair = pair+1;
      front=0;
      umgedreht[3]=false; 
      umgedreht[6]=false; 
      //println(pair);
    }
    if (pair==4 && seenZwei==true && seenEndscreen==false) {
      myInstruktion[4].display();//wirs schon vor zweiter runde angezeigt!?
      //println(pair);
      if (keyPressed==true && key=='w') {
        seenEndscreen=true;
      }
    }
    
    
    
  
  
  
  

  
  //Karten mit der Rückseite nach oben anzeigen;
  if (seenEins==true) {
    for (int i = 0; i<8; i++) {
      myMemory[i].display(); 
    }

    if (mousePressed) {
      if (front<=1) { //Es können maximal 2 Karten umgedreht werden
        aufdecken();
      }
    }
    
    
    
    
    
  }
}

//Aufdecken der Memory Karten
void aufdecken() {
  for (int i = 0; i<8; i++) {
    if (mouseX>x[i] && mouseX<(x[i]+105) && mouseY>y[i] && mouseY<(y[i]+130) && pressed[i]==false) {
      myMemory[i].displayFront();
      umgedreht[i]=true;
      front = front +1;
      pressed[i]=true;
    }
  }
}

void aufdecken1() {
  for (int i = 0; i<8; i++) {
    if (mouseX>x[i] && mouseX<(x[i]+105) && mouseY>y[i] && mouseY<(y[i]+130) && pressed[i]==false) {
      mySecondMemory[i].displayFront();
      umgedreht[i]=true;
      front = front +1;
      pressed[i]=true;
    }
  }
}

void texteingabe(){
    if (keyCode == BACKSPACE) {
    if (myText.length() > 0) {
      myText = myText.substring(0, myText.length()-1);
    }
  } else if (keyCode == DELETE) {
    myText = "";
  } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
    myText = myText + key;
  }
}