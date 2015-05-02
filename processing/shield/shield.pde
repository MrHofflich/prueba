// Librerias
import processing.serial.*;

//Objetos
Serial    serialPort;
objeto[]  objetos;
arcR      IronMan;
Button    b;
Button    b2;
Timer     timer;

//Serial
boolean   intro         = true;
boolean   menu          = false;
boolean   crearAgente   = false;
boolean   verAgente     = false;
boolean   practica      = false;
boolean   entrenamiento = false;
boolean   estadisticas  = false;

//Serial
int       sentData = 'C';
int       receivedData, encender, xValue, altura;

//Datos de Agente

int       sangria    = 180;
int       separacion = 60;
int       datosY     = 550;
int       totalAgentes;
int       index;
String[]  nombre  = new String[100];
String[]  nick    = new String[100];
int[]     edad    = new int[100];
String[]  ingreso = new String[100];
String[]  estatus = new String[100];

//Datos de practica
int       practicaSeleccionada;
int       agenteSeleccionado;
int       tiempoPasado;
boolean   iniciarPractica = false;
int       numeroDePractica;

//Datos de entrenamiento
int       totaldrops         = 0;
int       totaldropcaught    = 0;
int       xEntrenamiento     = 100;
int       yEntrenamiento     = 210;
int       anchoEntrenamiento = 1700;
int       altoEntrenamiento  = 600;
boolean   iniciarEntrenamiento;
int       numeroDeEntrenamiento;
int       anchoIronMan       = 110;

//Variables de datos
Table     logPracticaAlejandro;
Table     table;
TableRow  row;

//Variables de tiempo
int dia = day();
int mes = month();
int year = year();

// Datos de formas e imagenes
PImage[]  images = new PImage[3];
PShape s, s2, s3, s4, s5, s6, atras, atras2, atras3, atras4, atras5, atras6, atras7, atras8, atras9, atras10, boton1, boton2, foco, etiquetaPractica, etiquetaAgente;
PImage    fondoEntrenamiento;

/**
 * Always run the application in full screen.
 */
boolean sketchFullScreen() {
  return true;
}

void setup() {

  size(1920, 1080, P3D);

  b = new Button(width/2, height/2, 350, 0);
  b2 = new Button(width/1.1, height/12,150,150);

  table = loadTable("datos.csv","header");
  for ( int i = 0; i< images.length; i++ ) {
    images[i] = loadImage( i + ".jpg" );   // make sure images "0.jpg" to "11.jpg" exist
  }

  fondoEntrenamiento = loadImage("avengers_wallpaper_city_background_by_thewolfmonster-d4y8job.png");
  foco = loadShape("light-bulb-7.svg");
  formas();


  println(Serial.list());
  serialPort = new Serial(this, "/dev/cu.usbmodem1d1111", 9600);
  logPracticaAlejandro = loadTable("logPracticaAlejandro.csv", "header");

  IronMan = new arcR(xEntrenamiento +anchoIronMan/2, yEntrenamiento, anchoIronMan);
  objetos= new objeto[50];

  timer = new Timer(800);
}


void draw() {
    tiempoPasado = millis();

  if (intro && !menu && !crearAgente && !verAgente && !practica && !entrenamiento && !estadisticas) {

    drawIntro();

  } else if(menu) {

    drawMenu();

  }
   //Interaccion
      if(crearAgente) {
        for (int x = 0; x <= width; x = x+50) {
          for ( int y = 0; y <= height; y =y +50) {
            stroke(0, 184, 182, 100);
            strokeWeight(.5);
            line (x, 0, x, width);
            line ( 0, y, width, y);
          }
        }

        noStroke();
        fill(0, 200);
        rect(0, 0, width, height);

        b2.boton1();
        b2.interact1();

        shape(s2, 0, 0);
        shape(atras,width, height-50);
        fill(0);
        textSize(40);
        text("Crear Agente", 160, 100);
        text("Atrás",width -370, height - 150);


        stroke(0, 184, 182,100);
        strokeWeight(10);
        line(300, height - 80, width-300, height -80);

        stroke(0, 184, 182);
        strokeWeight(6);
        line(width, height, width -300, height -100);
        line(0, height, 300, height -100);
        line(300, height-100, width-300, height-100);

        stroke(0, 184, 182);
        fill(0,184,182);
        rect(100,200,500,650);
        fill(0);
        rect(110,210,480,320);




        //PARA REGRESAR AL MENU
        if(mouseX >= width-450 && mouseX <= width -90 && mouseY <= height -130 && mouseY >= height-200) {
           shape(atras2,width, height-50);
           text("Atrás",width -370, height - 150);
          if(mousePressed) {
             menu = true;
             crearAgente = false;
             verAgente = false;
             practica = false;
             entrenamiento = false;
             estadisticas = false;
          }

        }


      }

      if(verAgente) {
        verAgente();
      }

      if(practica) {

        for (int x = 0; x <= width; x = x+50) {
          for ( int y = 0; y <= height; y =y +50) {
            stroke(0, 184, 182, 100);
            strokeWeight(.5);
            line (x, 0, x, width);
            line ( 0, y, width, y);
          }
        }

        noStroke();
        fill(0, 200);
        rect(0, 0, width, height);

        b2.boton1();
        b2.interact1();

        shape(s4, 0, 0);
        shape(atras5,width, height-50);
        fill(0);
        textSize(40);
        text("Practica", 160, 100);
        text("Atrás",width -370, height - 150);

        stroke(0, 184, 182,100);
        strokeWeight(10);
        line(300, height - 80, width-300, height -80);

        stroke(0, 184, 182);
        strokeWeight(6);
        line(width, height, width -300, height -100);
        line(0, height, 300, height -100);
        line(300, height-100, width-300, height-100);


        if(practicaSeleccionada == 1) {
          sentData = 'P';
          textSize(15);
          stroke(0,184,182);
          fill(255);
          text(tiempoPasado,1800,250);
          shape(etiquetaPractica,650,0);
          shape(etiquetaAgente,1100,0);
          textSize(90);
          text("Biceps",730,80);
          textSize(60);
          text("Alejandro",1200,50);
          stroke(0,184,182);
          fill(0,190,180,120);
          rect(150,600,600,350);
          stroke(255);
          strokeWeight(3);
          line(180,775,730,775);
          strokeWeight(1);
          foco.disableStyle();
          fill(255);
          shape(foco, 800,580,300,370);
          fill(255);
          textSize(90);
          text("ON",375,730);
          text("OFF",375,900);


            if(iniciarPractica) {
              TableRow row = logPracticaAlejandro.addRow();
              row.setString("Fecha", dia +"/" + mes +"/" + year);
              row.setString("Agente", "Alejandro");
              row.setString("Tipo de ejercicio","Practica");
              row.setInt("Numero de practica",numeroDePractica);
              row.setString("Musculo","Biceps" );
              row.setString("Sensor", "Mioelectrico");
              row.setInt("Valor de Sensor", encender);
              row.setInt("Tiempo", tiempoPasado);

              if(encender >= 30) {
                fill(0,190,180,260);
                stroke(0,184,182);
                rect(150,600,600,172);
                fill(255);
                textSize(90);
                text("ON",375,730);
                fill(247,148,30);
                stroke(247,148,30);
                shape(foco, 800,580,300,370);
              }  else {
                  fill(255);
                  stroke(247,148,30);
                  shape(foco, 800,580,300,370);
                  stroke(0,184,182);
                  fill(0,190,180,260);
                  rect(150,778,600,175);
                  fill(255);
                  textSize(90);
                  text("OFF",375,900);
                 }

            }

          }
        //PARA REGRESAR AL MENU
          if(mouseX >= width-450 && mouseX <= width -90 && mouseY <= height -130 && mouseY >= height-200) {
            shape(atras6,width, height-50);
            textSize(40);
            text("Atrás",width -370, height - 150);
            if(mousePressed) {
              menu = true;
              crearAgente = false;
              verAgente = false;
              practica = false;
              entrenamiento = false;
              estadisticas = false;
          }

        }
      }

      if(entrenamiento) {
        for (int x = 0; x <= width; x = x+50) {
          for ( int y = 0; y <= height; y =y +50) {
            stroke(0, 184, 182, 100);
            strokeWeight(.5);
            line (x, 0, x, width);
            line ( 0, y, width, y);
          }
        }

        noStroke();
        fill(0, 200);
        rect(0, 0, width, height);

        b2.boton1();
        b2.interact1();


        shape(s5, 0, 0);
        shape(atras7,width, height-50);
        fill(0);
        textSize(40);
        text("Entrenamiento", 160, 100);
        text("Atrás",width -370, height - 150);

        stroke(0, 184, 182,100);
        strokeWeight(10);
        line(300, height - 80, width-300, height -80);

        stroke(0, 184, 182);
        strokeWeight(6);
        line(width, height, width -300, height -100);
        line(0, height, 300, height -100);
        line(300, height-100, width-300, height-100);

        if(iniciarEntrenamiento) {
          sentData = 'X';
          stroke(0,184,182);
          fill(20,20,20,120);
          rect(xEntrenamiento,yEntrenamiento,anchoEntrenamiento,altoEntrenamiento);
          image(fondoEntrenamiento,xEntrenamiento,yEntrenamiento,anchoEntrenamiento,altoEntrenamiento);
          IronMan.display();
          IronMan.update();
          TableRow row = logPracticaAlejandro.addRow();
          row.setString("Fecha", dia +"/" + mes +"/" + year);
          row.setString("Agente", "Alejandro");
          row.setString("Tipo de ejercicio","Entrenamiento");
          row.setInt("Numero de practica",numeroDeEntrenamiento);
          row.setString("Musculo","Biceps" );
          row.setString("Sensor", "Mioelectrico");
          row.setInt("Valor de Sensor", altura);
          row.setInt("Tiempo", tiempoPasado);

          if (timer.isFinished()) {
            //ahora siguen las gotas
            //initialize one drop
            objetos[totaldrops] = new objeto();
            //increment total drops
            totaldrops++;
            // If we hit the end of the array
            if (totaldrops >= objetos.length) {
              totaldrops = 0; //lo reinicias
            }

            timer.start();
          }
          // Move and display all drops
          for (int i= 0 ; i < totaldrops ; i++) {
            objetos[i].move();
            objetos[i].display();
            if (IronMan.intersect(objetos[i])) {
              objetos[i].caught();
              //println (totaldropcaught);

            }
          }

          if (totaldropcaught >= 20) {
          background(0);
          textSize(50);
          stroke(255);
          fill(255);
          text("Perfecto Sr. Stark",width/2-100,height/2);
          }
        }

                        //PARA REGRESAR AL MENU
        if(mouseX >= width-450 && mouseX <= width -90 && mouseY <= height -130 && mouseY >= height-200) {
          shape(atras8,width, height-50);
          text("Atrás",width -370, height - 150);
          if(mousePressed) {
             menu = true;
             crearAgente = false;
             verAgente = false;
             practica = false;
             entrenamiento = false;
             estadisticas = false;
          }

        }
      }

      if(estadisticas) {

        for (int x = 0; x <= width; x = x+50) {
          for ( int y = 0; y <= height; y =y +50) {
            stroke(0, 184, 182, 100);
            strokeWeight(.5);
            line (x, 0, x, width);
            line ( 0, y, width, y);
          }
        }

        noStroke();
        fill(0, 200);
        rect(0, 0, width, height);

        b2.boton1();
        b2.interact1();

        shape(s6, 0, 0);
        shape(atras9,width, height-50);
        fill(0);
        textSize(40);
        text("Estadisticas", 160, 100);
        text("Atrás",width -370, height - 150);

        stroke(0, 184, 182,100);
        strokeWeight(10);
        line(300, height - 80, width-300, height -80);

        stroke(0, 184, 182);
        strokeWeight(6);
        line(width, height, width -300, height -100);
        line(0, height, 300, height -100);
        line(300, height-100, width-300, height-100);

                        //PARA REGRESAR AL MENU
        if(mouseX >= width-450 && mouseX <= width -90 && mouseY <= height -130 && mouseY >= height-200) {
          shape(atras10,width, height-50);
          text("Atrás",width -370, height - 150);
          if(mousePressed) {
             menu = true;
             crearAgente = false;
             verAgente = false;
             practica = false;
             entrenamiento = false;
             estadisticas = false;
          }

        }
      }

}

void drawIntro() {
    noStroke();
    fill(0);
    rect(0, 0, width, height);
    b.boton1();
    b.interact1();
}

void drawMenu() {

    for (int x = 0; x <= width; x = x+50) {
      for ( int y = 0; y <= height; y =y +50) {
        stroke(0, 184, 182, 20);
        strokeWeight(.5);
        line (x, 0, x, width);
        line ( 0, y, width, y);
      }
    }

    noStroke();
    fill(0, 200);
    rect(0, 0, width, height);

    b2.boton1();
    b2.interact1();

    stroke(0, 184, 182,100);
    strokeWeight(10);
    line(300, height - 80, width - 300, height - 80);

    stroke(0, 184, 182);
    strokeWeight(6);
    line(width, height, width -300, height -100);
    line(0, height, 300, height -100);
    line(300, height-100, width-300, height-100);



    shape(s, 0, 0);
    fill(0);
    textSize(40);
    text("S.H.I.E.L.D.", 160, 100);

    //Opciones
    shape(boton1,width/3.5,height/5);
    fill(0);
    textSize(40);
    text("Crear Agente", width/2.5 ,height/4.3);
    shape(boton1,width/3.5,height/3.7);
    fill(0);
    textSize(40);
    text("Ver Agentes", width/2.5 ,height/3.25);
    shape(boton1,width/3.5,height/2.9);
    fill(0);
    textSize(40);
    text("Practica", width/2.35 ,height/2.64);
    shape(boton1,width/3.5,height/2.37);
    fill(0);
    textSize(40);
    text("Entrenamiento", width/2.55 ,height/2.19);
    shape(boton1,width/3.5,height/2);
    fill(0);
    textSize(40);
    text("Estadisticas", width/2.45 ,height/1.87);

    //Interaccion
    if(mouseX >= width/3.6 && mouseX <= width/1.44 && mouseY >= height/5 && mouseY <= height/4.21 ) {
      shape(boton2,width/3.5,height/5);
      fill(0);
      textSize(40);
      text("Crear Agente", width/2.5 ,height/4.3);
      if(mousePressed) {
        menu = false;
        crearAgente = true;
        verAgente = false;
        practica = false;
        entrenamiento = false;
        estadisticas = false;
      }
    }

    if(mouseX >= width/3.6 && mouseX <= width/1.44 && mouseY >= height/3.7 && mouseY <= height/3.15) {
      shape(boton2,width/3.5,height/3.7);
      fill(0);
      textSize(40);
      text("Ver Agentes", width/2.5 ,height/3.25);
      if(mousePressed) {
        menu = false;
        crearAgente = false;
        verAgente = true;
        practica = false;
        entrenamiento = false;
        estadisticas = false;
      }
    }

    if(mouseX >= width/3.6 && mouseX <= width/1.44 && mouseY >= height/2.9 && mouseY <= height/2.55) {
      shape(boton2,width/3.5,height/2.9);
      fill(0);
      textSize(40);
      text("Practica", width/2.35 ,height/2.64);
      if(mousePressed) {
        menu = false;
        crearAgente = false;
        verAgente = false;
        practica = true;
        entrenamiento = false;
        estadisticas = false;
      }
    }

    if(mouseX >= width/3.6 && mouseX <= width/1.44 && mouseY >= height/2.37 && mouseY <= height/2.13) {
      shape(boton2,width/3.5,height/2.37);
      fill(0);
      textSize(40);
      text("Entrenamiento", width/2.55 ,height/2.19);
      if(mousePressed) {
        menu = false;
        crearAgente = false;
        verAgente = false;
        practica = false;
        entrenamiento = true;
        estadisticas = false;
      }
    }

    if(mouseX >= width/3.6 && mouseX <= width/1.44 && mouseY >= height/2 && mouseY <= height/1.83){
      shape(boton2,width/3.5,height/2);
      fill(0);
      textSize(40);
      text("Estadisticas", width/2.45 ,height/1.87);
      if(mousePressed) {
        menu = false;
        crearAgente = false;
        verAgente = false;
        practica = false;
        entrenamiento = false;
        estadisticas = true;
      }
    }

}

void verAgente() {

        for (int x = 0; x <= width; x = x+50) {
          for ( int y = 0; y <= height; y =y +50) {
            stroke(0, 184, 182, 100);
            strokeWeight(.5);
            line (x, 0, x, width);
            line ( 0, y, width, y);
          }
        }

        noStroke();
        fill(0);
        rect(0, 0, width, height);
        shape(s3, 0, 0);
        shape(atras3,width, height-50);
        fill(0);
        textSize(40);
        text("Ver Agente", 160, 100);
        text("Atrás",width -370, height - 150);

        b2.boton1();
        b2.interact1();


        for (int i = 0; i <= table.getRowCount()-1; i++) {

          row = table.getRow(i);
          nombre[i] = row.getString("Nombre");
          nick[i] = row.getString("Nick");
          edad[i] = row.getInt("Edad");
          ingreso[i] = row.getString ("Ingreso");
          estatus[i] = row.getString("Estatus");
          totalAgentes = table.getRowCount();

        }

         if(  index <= totalAgentes -1) {

          stroke(0,184,182);
          fill(0,190,180,120);
          rect(130,180,500,700);

          fill(255,180);
          text("Nombre:" + nombre[index], sangria,datosY+separacion*0);
          text("Alias: " + nick[index],sangria,datosY+separacion*1);
          text("Edad: " + edad[index],sangria, datosY+separacion*2);
          text("Fecha de Ingreso: " + ingreso[index],sangria,datosY+separacion*3);
          text("Estatus: " + estatus[index],sangria,datosY+separacion*4);
          image(images[index],sangria,200,400,300);
          }



        stroke(0, 184, 182,100);
        strokeWeight(10);
        line(300, height - 80, width-300, height -80);

        stroke(0, 184, 182);
        strokeWeight(6);
        line(width, height, width -300, height -100);
        line(0, height, 300, height -100);
        line(300, height-100, width-300, height-100);

                //PARA REGRESAR AL MENU
        if(mouseX >= width-450 && mouseX <= width -90 && mouseY <= height -130 && mouseY >= height-200) {
          shape(atras4,width, height-50);
          textSize(40);
          text("Atrás",width -370, height - 150);
          if(mousePressed) {
             menu = true;
             crearAgente = false;
             verAgente = false;
             practica = false;
             entrenamiento = false;
             estadisticas = false;
          }

        }
}

void serialEvent(Serial serialPort) {
  receivedData = serialPort.read();

  if(sentData == 'C') {
    int conectado = receivedData;
    if(conectado =='C'){
     println("Conectado y en espera");
      serialPort.write(sentData);
   }
  }

  if(sentData == 'P') {
    encender = receivedData;
    sentData = 'P';
   println(encender);
    serialPort.write(sentData);
  }

  if(sentData == 'X') {
    altura = receivedData;
    println(receivedData);
    IronMan.altura = (int)map(altura, 0, 255,yEntrenamiento, yEntrenamiento+altoEntrenamiento);
    serialPort.write(sentData);
  }

}


void keyPressed() {

  if(keyPressed) {

    if(keyCode == LEFT) {
      if(index<=0) {
        index = 0;
      }else if( index >=0 && index <= totalAgentes) {
        index--;
      }
    }

    if(keyCode == RIGHT) {
      if(index >=0 && index <= totalAgentes) {
        index++;
    }
      if(index>= totalAgentes){
      index = totalAgentes;
      }
    }
    if(key == '1') {
         practicaSeleccionada = 1;
         agenteSeleccionado = 0;
    }

    if(key == 'i') {
      iniciarPractica = true;
      logPracticaAlejandro = loadTable("data/logPracticaAlejandro.csv","header");
    }

    if(key == 's') {
      iniciarPractica = false;
      saveTable(logPracticaAlejandro, "data/logPracticaAlejandro.csv");
      numeroDePractica++;
    }

    if(key=='e') {
     iniciarEntrenamiento = true;
     logPracticaAlejandro = loadTable("data/logPracticaAlejandro.csv","header");
    }

    if(key == 'd') {
     iniciarEntrenamiento = false;
     saveTable(logPracticaAlejandro, "data/logPracticaAlejandro.csv");
     numeroDeEntrenamiento++;
    }


  }

}

void formas() {

 s = createShape();
  s.beginShape();
  s.fill(0, 184, 182, 150);
  s.noStroke();
  s.vertex(0, 0);
  s.vertex(120, 0);
  s.vertex(170, 50);
  s.vertex(500, 50);
  s.vertex(480, 110);
  s.vertex(110, 110);
  s.vertex(0, 0);
  s.endShape();

  s2 = createShape();
  s2.beginShape();
  s2.fill(0, 184, 182, 150);
  s2.noStroke();
  s2.vertex(0, 0);
  s2.vertex(120, 0);
  s2.vertex(170, 50);
  s2.vertex(500, 50);
  s2.vertex(480, 110);
  s2.vertex(110, 110);
  s2.vertex(0, 0);
  s2.endShape();

  s3 = createShape();
  s3.beginShape();
  s3.fill(0, 184, 182, 150);
  s3.noStroke();
  s3.vertex(0, 0);
  s3.vertex(120, 0);
  s3.vertex(170, 50);
  s3.vertex(500, 50);
  s3.vertex(480, 110);
  s3.vertex(110, 110);
  s3.vertex(0, 0);
  s3.endShape();

  s4 = createShape();
  s4.beginShape();
  s4.fill(0, 184, 182, 150);
  s4.noStroke();
  s4.vertex(0, 0);
  s4.vertex(120, 0);
  s4.vertex(170, 50);
  s4.vertex(500, 50);
  s4.vertex(480, 110);
  s4.vertex(110, 110);
  s4.vertex(0, 0);
  s4.endShape();

  s5 = createShape();
  s5.beginShape();
  s5.fill(0, 184, 182, 150);
  s5.noStroke();
  s5.vertex(0, 0);
  s5.vertex(120, 0);
  s5.vertex(170, 50);
  s5.vertex(500, 50);
  s5.vertex(480, 110);
  s5.vertex(110, 110);
  s5.vertex(0, 0);
  s5.endShape();

  s6 = createShape();
  s6.beginShape();
  s6.fill(0, 184, 182, 150);
  s6.noStroke();
  s6.vertex(0, 0);
  s6.vertex(120, 0);
  s6.vertex(170, 50);
  s6.vertex(500, 50);
  s6.vertex(480, 110);
  s6.vertex(110, 110);
  s6.vertex(0, 0);
  s6.endShape();

  atras = createShape();
  atras.beginShape();
  atras.fill(0,184,182,150);
  atras.noStroke();
  atras.vertex(0, 0);
  atras.vertex(-120,-80);
  atras.vertex(-450,-80);
  atras.vertex(-380,-150);
  atras.vertex(-90,-150);
  atras.vertex(0,-95);
  atras.endShape();

  atras2 = createShape();
  atras2.beginShape();
  atras2.fill(0,184,182,200);
  atras2.noStroke();
  atras2.vertex(0, 0);
  atras2.vertex(-120,-80);
  atras2.vertex(-450,-80);
  atras2.vertex(-380,-150);
  atras2.vertex(-90,-150);
  atras2.vertex(0,-95);
  atras2.endShape();

  atras3 = createShape();
  atras3.beginShape();
  atras3.fill(0,184,182,150);
  atras3.noStroke();
  atras3.vertex(0, 0);
  atras3.vertex(-120,-80);
  atras3.vertex(-450,-80);
  atras3.vertex(-380,-150);
  atras3.vertex(-90,-150);
  atras3.vertex(0,-95);
  atras3.endShape();

  atras4 = createShape();
  atras4.beginShape();
  atras4.fill(0,184,182,200);
  atras4.noStroke();
  atras4.vertex(0, 0);
  atras4.vertex(-120,-80);
  atras4.vertex(-450,-80);
  atras4.vertex(-380,-150);
  atras4.vertex(-90,-150);
  atras4.vertex(0,-95);
  atras4.endShape();

  atras5 = createShape();
  atras5.beginShape();
  atras5.fill(0,184,182,150);
  atras5.noStroke();
  atras5.vertex(0, 0);
  atras5.vertex(-120,-80);
  atras5.vertex(-450,-80);
  atras5.vertex(-380,-150);
  atras5.vertex(-90,-150);
  atras5.vertex(0,-95);
  atras5.endShape();

  atras6 = createShape();
  atras6.beginShape();
  atras6.fill(0,184,182,200);
  atras6.noStroke();
  atras6.vertex(0, 0);
  atras6.vertex(-120,-80);
  atras6.vertex(-450,-80);
  atras6.vertex(-380,-150);
  atras6.vertex(-90,-150);
  atras6.vertex(0,-95);
  atras6.endShape();

  atras7 = createShape();
  atras7.beginShape();
  atras7.fill(0,184,182,150);
  atras7.noStroke();
  atras7.vertex(0, 0);
  atras7.vertex(-120,-80);
  atras7.vertex(-450,-80);
  atras7.vertex(-380,-150);
  atras7.vertex(-90,-150);
  atras7.vertex(0,-95);
  atras7.endShape();

  atras8 = createShape();
  atras8.beginShape();
  atras8.fill(0,184,182,200);
  atras8.noStroke();
  atras8.vertex(0, 0);
  atras8.vertex(-120,-80);
  atras8.vertex(-450,-80);
  atras8.vertex(-380,-150);
  atras8.vertex(-90,-150);
  atras8.vertex(0,-95);
  atras8.endShape();

  atras9 = createShape();
  atras9.beginShape();
  atras9.fill(0,184,182,150);
  atras9.noStroke();
  atras9.vertex(0, 0);
  atras9.vertex(-120,-80);
  atras9.vertex(-450,-80);
  atras9.vertex(-380,-150);
  atras9.vertex(-90,-150);
  atras9.vertex(0,-95);
  atras9.endShape();

  atras10 = createShape();
  atras10.beginShape();
  atras10.fill(0,184,182,200);
  atras10.noStroke();
  atras10.vertex(0, 0);
  atras10.vertex(-120,-80);
  atras10.vertex(-450,-80);
  atras10.vertex(-380,-150);
  atras10.vertex(-90,-150);
  atras10.vertex(0,-95);
  atras10.endShape();

  boton1 = createShape();
  boton1.beginShape();
  boton1.fill(0, 184, 182, 150);
  boton1.noStroke();
  boton1.vertex(10, 0);
  boton1.vertex(790, 0);
  boton1.vertex(730, 50);
  boton1.vertex(-60, 50);
  boton1.endShape();

  boton2 = createShape();
  boton2.beginShape();
  boton2.fill(0, 184, 182,200);
  boton2.noStroke();
  boton2.vertex(10, 0);
  boton2.vertex(790, 0);
  boton2.vertex(730, 50);
  boton2.vertex(-60, 50);
  boton2.endShape();

  etiquetaPractica = createShape();
  etiquetaPractica.beginShape();
  etiquetaPractica.fill(0,184,182,200);
  etiquetaPractica.stroke(0,184,182);
  etiquetaPractica.vertex(0,0);
  etiquetaPractica.vertex(70,100);
  etiquetaPractica.vertex(370,100);
  etiquetaPractica.vertex(440,0);
  etiquetaPractica.endShape();

  etiquetaAgente = createShape();
  etiquetaAgente.beginShape();
  etiquetaAgente.fill(0,184,182,200);
  etiquetaAgente.stroke(0,184,182);
  etiquetaAgente.vertex(0,0);
  etiquetaAgente.vertex(70,70);
  etiquetaAgente.vertex(400,70);
  etiquetaAgente.vertex(470,0);
  etiquetaAgente.endShape();

}

