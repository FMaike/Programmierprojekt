Memory[] myMemory = new Memory[8];
Instruktionen[] myInstruktion=new Instruktionen[5];

//Kartenvariablen
int[] x = new int[8];
int[] y = new int[8];
int[] fv = new int[8];
int pair = 0;
int front = 0;
int geseheneKarten=0;
String[]nameEins={"backside.jpg", "eiskunstläuferin.jpg", "football.jpg", "fallschirm.jpg", "skateboard.png", "fallschirmspringer.jpg", "schlittschuh.jpg", "skater.jpg", "footballplayer.jpg"};
String[]nameZwei={"backside.jpg", "fallschirmspringer2.jpg.jpeg", "fallschirm2.jpg.jpeg", "eiskunstläuferin2.jpg.jpeg", "football2.jpg.jpeg", "schlittschuh2.jpg.jpeg", "skater2.jpg.jpeg", "footballplayer2.jpg.jpeg", "skateboard2.png.jpeg"};


//Zeitmessung
int tStop=0;
int tStart;
int t2Stop=0;
int t2Start;
int tBed1=0;
int tBed2=0;

//Text Variablen
int xText=800;
int yText=750;
char myKey;
PFont myFont;

String vpNr="Willkommen zu diesem Experiment \nBitte gib zunächst hier deine Versuchspersonennummer ein. \nBestätige deine Eingabe mit Enter\n";
String pause="Du hast nun Zeit für eine kurze Pause. \nWenn du bereit bist weiterzuspielen, drücke Enter";
String instrEins="Im Folgenden wird dir ein Memory-Kartenspiel präsentiert. \n Deine Aufgabe ist es den jeweiligen Sportlern ihr \n passendes Sportgerät zuzuordnen (z.B. würden ein Fußballer und ein Fußball zusammengehören). \n Um ein nicht passendes Kartenpaar wieder umzudrehen drücke die Leertaste. \n Um das Spiel zu starten drücke nun die Taste w. ";
String instrZwei="Spiele nun das Spiel noch einmal. \n Ordne den Sportlern wieder ihre Sportgeräte zu. Du startest die zweite Runde mit w.";
String ende="Herzlichen Glückwunsch, du hast es geschafft! \nVielen Dank für deine Teilnahme, das Experiment ist nun beendet.";

//Steuerung des Spielablaufs durch Zustandsabfragen
boolean seenEins=false;
boolean seenPause=false;
boolean seenZwei=false;
boolean seenVP=false;
boolean[] pressed=new boolean[8];
boolean[] umgedreht = new boolean[8];

//Logfile
PrintWriter output;

void setup() {
  int myX = width/2;
  int myY = height/2;
  fullScreen();

  //Die Logdatei wird erstellt
  output=createWriter("logfile.txt"); 

  //Arrays werden befüllt
  for (int i = 0; i<8; i++) {
    //Die Karten werden mittig auf dem Screen dargestellt
    y[i] = myY-225;
    x[i] = myX-375;
    fv[i] = i+1;
    umgedreht[i]=false;
    pressed[i]=false;
    //Wenn das Ende der Leinwand erreicht wurde, wird die zweite Kartenreihe darunter gelegt.
    if (myX<(width/2+500)) {
      myX = myX+200;
    } else if (myX>(width/2+500)) {
      myX = width/2;
      myY = myY +250;
    }
  }
  for (int i = 0; i<8; i++) {
    myMemory[i] = new Memory (x[i], y[i], fv[i]);
  }

  myInstruktion[0]=new Instruktionen(instrEins);
  myInstruktion[1]=new Instruktionen(pause);
  myInstruktion[2]=new Instruktionen(instrZwei);
  myInstruktion[3]=new Instruktionen(ende);
  myInstruktion[4]=new Instruktionen(vpNr);
}

void draw() {

  background(255);
  fill(0);
  //println(front);
  //println(seenEins);
  //println(seenPause);
  //println(seenZwei);

  //Zu Beginn wird der Teilnehmer gebeten, seine Versuchspersonennummer anzugeben welche ins Logfile geschrieben wird. Durch Drücken der Enter Taste erscheint der Instruktionsbildschirm
  if (seenVP==false) {
    myInstruktion[4].display();
    if (keyPressed==true && key==ENTER) {
      output.println(myInstruktion[4].instr);
      seenVP=true;
    }
  }
  //Es werden die ersten Instruktionen angezeigt die erklären wie das Experiment funktioniert. Durch Drücken der Taste w wird das erste Spiel gestartet
  if (seenVP && seenEins==false && seenZwei==false) {
    myInstruktion[0].display();
    if (keyPressed==true && key=='w') {
      //Es wird im Logfile vermerkt, dass die folgenden Angaben sich auf die erste Bedingung beziehen
      output.println("Bedingung 1"); 
      seenEins=true;
      // Die Zeitmessung für die erste Bedingung startet hier
      tStart=millis();
    }
  }

  if (seenEins && seenZwei==false) {

    //Karten werden mit der Rückseite nach oben angezeigt mit Erinnerung wie sie wieder verdeckt werden
    text("Drücke die Leertaste zum Verdecken der Karten", xText+50, yText+50);
    for (int i = 0; i<8; i++) {
      myMemory[i].bildName = nameEins; 
      myMemory[i].display();
    }
    //Wenn geklickt wird, werden die Karten umgereht
    if (mousePressed) { 
      //Es können maximal 2 Karten umgedreht werden
      if (front<=1) { 
        aufdecken();
      }
    }
    //Wenn die Leertaste gedrückt wird, werden die Karten wieder mit der Rückseite nach oben angezeigt
    if (keyPressed && key==' ') {
      for (int i = 0; i<8; i++) {
        myMemory[i].displayBack();
        umgedreht[i]=false;
        front = 0;
        pressed[i]=false;
      }
    }
    //wenn Paare gefunden werden, verschwinden die Karten vom Spielfeld
    if (umgedreht[0] && umgedreht[5]) {
      myMemory[0].cardX=-150;
      myMemory[5].cardX=-150;
      //Zum Gewinnen werden 4 Paare benötigt, immer wenn eins gefunden wird, wir hochgezählt
      pair = pair+1; 
      front=0;
      umgedreht[0]=false; 
      umgedreht[5]=false;
      //println(pair);
    }

    if (umgedreht[1] && umgedreht[7]) {
      myMemory[1].cardX=-150;
      myMemory[7].cardX=-150;
      pair = pair+1;
      front=0;
      umgedreht[1]=false; 
      umgedreht[7]=false;
      //println(pair);
    }
    if (umgedreht[2] && umgedreht[4]) {
      myMemory[2].cardX=-150;
      myMemory[4].cardX=-150;
      pair = pair+1;
      front=0;
      umgedreht[2]=false; 
      umgedreht[4]=false;
      //println(pair);
    }
    if (umgedreht[3] && umgedreht[6]) {
      myMemory[3].cardX=-150;
      myMemory[6].cardX=-150;
      pair = pair+1;
      front=0;
      umgedreht[3]=false; 
      umgedreht[6]=false; 
      //println(pair);
    }
    if (pair==4 && seenEins && seenPause==false && seenZwei==false) {
      //yText=-500;
      if (tStop==0)tStop=millis();
      //Ausrechnen und Aufzeichnen der Dauer des erste Spiels in Millisekunden 
      tBed1=tStop-tStart; 
      output.println("Dauer erste Bedingung"+ "," + tBed1);
      xText=-500;
      //Anzeigen des Pausenscreens
      myInstruktion[1].display();

      //Nach Drücken der Entertaste erscheint die Zweite Instruktion
      if (keyPressed==true && key==ENTER) {
        seenPause=true;
      }
    }

    if (seenEins && seenPause && seenZwei==false) {
      myInstruktion[2].display();

      //Nach Drücken der w Taste wird die Zeitmessung der zweiten Bedingung gestartet und die Karten des zweiten Spiels mit Rückseite nach oben angezeigt (inklusive Einnerung wie sie wieder umgedreht werden) 
      if (keyPressed==true && key=='w') {
        //Es wird im Logfile vermerkt, dass die folgenden Angaben sich auf die zweite Bedingung beziehen
        output.println("Bedingung 2");
        t2Start=millis();
        for (int i = 0; i<8; i++) {

          myMemory[i].bildName = nameZwei;
          myMemory[i].cardX=x[i];
          myMemory[i].displayBack();
          umgedreht[i]=false;
          front = 0;
          pressed[i]=false;
          geseheneKarten=0;
        }
        seenZwei=true;
      }
    }
  }
  if (seenZwei) {
    text("Drücke die Leertaste zum Verdecken der Karten", xText, yText);
    for (int i = 0; i<8; i++) {
      myMemory[i].display();
    }

    //Wenn geklickt wird, werden die Karten umgereht
    if (mousePressed) {

      //Es können maximal 2 Karten umgedreht werden
      if (front<=1) { 
        aufdecken();
      }
    }

    //Wenn die Leertaste gedrückt wird werden die aufgedeckten Karten wieder umgedeckt
    if (keyPressed && key==' ') {
      for (int i = 0; i<8; i++) {
        myMemory[i].displayBack();
        umgedreht[i]=false;
        front = 0;
        pressed[i]=false;
      }
    }
    //wenn Paare gefunden werden, verschwinden die Karten vom Spielfeld
    if (umgedreht[0] && umgedreht[1]) {
      myMemory[0].cardX=-150;
      myMemory[1].cardX=-150;

      //zum Gewinnen werden 4 Paare gebraucht, immer wenn eins gefunden wird, wir hochgezählt, ist ein Paar gefunden zählen die Karten nicht mehr als umgedreht
      pair = pair+1; 
      front=0;
      umgedreht[0]=false; 
      umgedreht[1]=false; 
      //println(pair);
    }
    if (umgedreht[2] && umgedreht[4]) {
      myMemory[2].cardX=-150;
      myMemory[4].cardX=-150;
      pair = pair+1;
      front=0;
      umgedreht[2]=false; 
      umgedreht[4]=false;
      //println(pair);
    }
    if (umgedreht[3] && umgedreht[6]) {
      myMemory[3].cardX=-150;
      myMemory[6].cardX=-150;
      pair = pair+1;
      front=0;
      umgedreht[3]=false; 
      umgedreht[6]=false;
      //println(pair);
    }
    if (umgedreht[5] && umgedreht[7]) {
      myMemory[5].cardX=-150;
      myMemory[7].cardX=-150;
      pair = pair+1;
      front=0;
      umgedreht[5]=false; 
      umgedreht[7]=false; 
      //println(pair);
    }
    if (pair==8) {
      xText=-500;
      if (t2Stop==0)t2Stop=millis();
      //Ausrechnen und Aufzeichnen der Dauer des zweiten Spiels in Millisekunden 
      tBed2=t2Stop-t2Start;
      output.println("Dauer zweite Bedingung"+ "," + tBed2);
      output.flush();
      output.close();

      //Anzeigen des Endscreens
      myInstruktion[3].display();
      //println(pair);
    }
  }
}

//Aufdecken der Memory Karten wenn mit der Maus auf sie geklickt wird. Anzahl der aufgedeckten Karten wird im Logfile aufgezeichnet
void aufdecken() {
  for (int i = 0; i<8; i++) {
    if (mouseX>x[i] && mouseX<(x[i]+150) && mouseY>y[i] && mouseY<(y[i]+200) && pressed[i]==false) {      
      myMemory[i].displayFront();
      umgedreht[i]=true;
      front = front +1;
      pressed[i]=true;
      geseheneKarten++;
      output.println("Anzahl der gesehenen Karten"+"," + geseheneKarten);
    }
  }
}

//Anzeigen der Begrüßung mit Möglichkeit zur Eingabe der VP Nummer, die Korrekturen durch die Backspace oder Entfernen Taste zulässt
void keyPressed() {
  if (keyCode == BACKSPACE) {
    if (myInstruktion[4].instr.length() > 0) {
      myInstruktion[4].instr = myInstruktion[4].instr.substring(0, myInstruktion[4].instr.length()-1);
    }
  } else if (keyCode == DELETE) {
    myInstruktion[4].instr = "";
  } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
    myInstruktion[4].instr = myInstruktion[4].instr + key;
  }
}
