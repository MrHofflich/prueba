class arcR {

float altura;
float velY = 5;
int xValue;
int x,r;
PImage arc;
float gravedad = 0.1;

  arcR (int x_, float altura_, int r_ ) {
    x = x_;
    altura = altura_;
    r = r_;
    arc = loadImage("image10.png");
  }

  void display() {
    noStroke();
    fill(33,254,237);
    image(arc,x+r,altura,r*2,r);

  }


//for debugging
  void update() {

    altura = altura + velY/5;
    velY = velY + gravedad;

   if(altura <= yEntrenamiento +r/2) {
     altura =  yEntrenamiento;
     velY = 10;
   }
   if(altura >= yEntrenamiento +altoEntrenamiento) {
     altura = altoEntrenamiento -r;
     velY = 10;
   }


/*
  if(keyPressed == true) {
    if(keyCode == UP) {
      altura = altura - velY;
    }
  }

      if(keyCode == DOWN) {
        altura += velY;
      }
    }

    if(altura <= 0) {
      altura = 0;
    }
    */

  }

    boolean intersect (objeto o) {
    /* A function that returns true or fals base on whether
     two circles intersect. If distance is less than the sum
     radii the circles touch */
    float distance = dist (x+r/2, altura, o.xArcReactor,o.yArcReactor); //calcula la distancia
    if (distance < r + o.r) {  //comparala con la suma de los radios
      return true;

    }
    else {
      return false;
    }

  }


}