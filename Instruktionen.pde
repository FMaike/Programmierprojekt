 
  class Instruktionen {
 int istX=20;
 int istY=120;
 PFont myFont;
 String instr="test Instruktionen";
 
 //der Konstruktor
 Instruktionen(String _instr) {
   instr=_instr;
 }
 
 void display(){
 myFont=createFont("Arial.vlw", 18);
 textFont(myFont);
 text(instr, 20,150);
 }
}