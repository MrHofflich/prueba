

class Timer {
 
  int tiempoTranscurrido; // When Timer started
  int tiempoTotal; // How long Timer should last
  int contadorSegundos;
  int segundos;
  int minutos;
  int horas;
  int passedTime;
  
  Timer(int tiempoTotal_) {
    tiempoTotal = tiempoTotal_;
  }
  
  // Starting the timer
  void start() {
    // When the timer starts it stores the current time in milliseconds.
    tiempoTranscurrido = millis(); 
    contadorSegundos = millis();
    

  }
  
  // The function isFinished() returns true if 5,000 ms have passed. 
  // The work of the timer is farmed out to this method.
  boolean isFinished() { 
    // Check how much time has passed
     passedTime = millis()- tiempoTranscurrido;
    if (passedTime > tiempoTotal) {
      return true;
    } else {
      return false;
    }
  }
  
  void convertir() {
     if(contadorSegundos >= 1000) {
     segundos++;
     contadorSegundos = 0; 
    }
    
    if(segundos >= 60) {
     minutos++;
     segundos = 0;
    }
    
    if(minutos >= 60) {
     horas++;
     minutos = 0;
    }
  }
      
}

