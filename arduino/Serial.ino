 const int xPot = 0;

 int xAcc;
 int xValue;
 int receivedData;
 
 void setup() {
   Serial.begin(9600);
 }
 
 void loop() {
   // read all analog inputs
   xValue = analogRead(xPot);

   // do not send serial data until Processing asks for it
   if(Serial.available()) {
     receivedData = Serial.read();
     if(receivedData == 'C') {
       Serial.write('C');
       
     }
     if(receivedData == 'P') {
       //Serial.write(xValue/4); 
       Serial.write(xValue/4);       // divide by 4 to send
     } 
     if(receivedData == 'X') {   // a single byte
       Serial.write(xValue/4);
     } 
   }
      
   
 }