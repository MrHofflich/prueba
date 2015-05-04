class objeto {

  float xArcReactor, yArcReactor; // Variables for location of raindrop
  float velocidad; // speed of the drop
  float r; // Radius of the drop
  float totalTime = 5000;
  PImage arcreactor;

  objeto () {  //Constructor of drops

    r = 10;  //todas las gotas son del mismo tamanio
    xArcReactor = xEntrenamiento+anchoEntrenamiento; //empieza un poco mas afuera de la pantalla
    yArcReactor = random(yEntrenamiento,yEntrenamiento+ altoEntrenamiento);   //empieza randommente en el eje Y
    velocidad = random(1, 15);
    arcreactor = loadImage("arc reactor2.png");
  }

  //Move raindrop down

  void move() {
    xArcReactor -= velocidad ;

        if ( xArcReactor < xEntrenamiento  ) {
      xArcReactor = -1000;

    }

  }



  //Display raindrop

  void display() {
    noStroke();
    for (int i = 1; i < r ; i++) {
      image(arcreactor, xArcReactor ,yArcReactor, 40,40);
    }
  }
  void caught() {
    velocidad= 0;
    xArcReactor = -1000 ;
    totaldropcaught++;

  }

}