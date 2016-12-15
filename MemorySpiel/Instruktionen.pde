class Instruktionen {
  // Die Vorlage zum Erstellen von Instruktionen (Größe, Font, Position)
  
 int istX=20;
 int istY=20;
 PFont myFont;
 String instr="test Instruktionen";
 
 //der Konstruktor
 Instruktionen(String _instr) {
   instr=_instr;
 }
 
 void display(){
 textAlign(CENTER, CENTER);  
 myFont=createFont("Arial.vlw", 24);
 textFont(myFont);
 text(instr, width/2 ,height/2);
 }
}