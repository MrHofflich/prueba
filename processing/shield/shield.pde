// Libraries
import processing.serial.*;

// Menu
final int STATE_INTRO        = 1;
final int STATE_MENU         = 2;
final int STATE_AGENT_CREATE = 3;
final int STATE_AGENT_VIEW   = 4;
final int STATE_PRACTICE     = 5;
final int STATE_TRAINING     = 6;
final int STATE_STATISTICS   = 7;
int numState                 = 1; // Initial state

// MenuItems
MenuItem menuItemAgentCreate;
MenuItem menuItemAgentView;
MenuItem menuItemPractice;
MenuItem menuItemTraining;
MenuItem menuItemStatistics;

// Arduino
Arduino objArduino;

// Navigation
BackButton btnBack;

// Objetos
Serial    serialPort;
objeto[]  objetos;
arcR      IronMan;
Button    b;
Button    b2;
Timer     timer;

//Serial
// int       sentData = 'C';
// int       receivedData, encender, xValue, altura;

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
PShape objTitleShape, boton1, boton2, foco, etiquetaPractica, etiquetaAgente;

/**
 * Always run the application in full screen.
 */
boolean sketchFullScreen() {
    return true;
}

void setup() {

    size(displayWidth, displayHeight, P3D);

    b = new Button(width/2, height/2, 350, 0);
    b2 = new Button(width/1.1, height/12,150,150);

    objArduino = new Arduino(this);

    table = loadTable("datos.csv","header");
    for ( int i = 0; i< images.length; i++ ) {
        images[i] = loadImage( i + ".jpg" );   // make sure images "0.jpg" to "11.jpg" exist
    }

    foco = loadShape("light-bulb-7.svg");
    formas();

    logPracticaAlejandro = loadTable("logPracticaAlejandro.csv", "header");

    IronMan = new arcR(xEntrenamiento +anchoIronMan/2, yEntrenamiento, anchoIronMan);
    objetos= new objeto[50];

    timer = new Timer(800);

    menuItemAgentCreate = new MenuItem("Crear Agente", STATE_AGENT_CREATE, 0);
    menuItemAgentView   = new MenuItem("Ver Agentes", STATE_AGENT_VIEW, 1);
    menuItemPractice    = new MenuItem("Practica", STATE_PRACTICE, 2);
    menuItemTraining    = new MenuItem("Entrenamiento", STATE_TRAINING, 3);
    menuItemStatistics  = new MenuItem("Estadisticas", STATE_STATISTICS, 4);

    btnBack = new BackButton();

    objTitleShape = createShape();
    objTitleShape.beginShape();
    objTitleShape.fill(0, 184, 182, 150);
    objTitleShape.noStroke();
    objTitleShape.vertex(0, 0);
    objTitleShape.vertex(120, 0);
    objTitleShape.vertex(170, 50);
    objTitleShape.vertex(500, 50);
    objTitleShape.vertex(480, 110);
    objTitleShape.vertex(110, 110);
    objTitleShape.vertex(0, 0);
    objTitleShape.endShape();
}


void draw() {
    tiempoPasado = millis();

    // Try to identify where arduino is plugged
    objArduino.configure();

    noStroke();
    printSquareBackground();

    switch (numState) {
        case STATE_INTRO:
            drawIntro();
            break;
        case  STATE_MENU:
            drawMenu();
            break;
        case STATE_AGENT_CREATE:
            drawAgentCreate();
            break;
        case STATE_AGENT_VIEW:
            verAgente();
            break;
        case STATE_PRACTICE:
            drawPractice();
            break;
        case STATE_TRAINING:
            drawTraining();
            break;
        case STATE_STATISTICS:
            drawStatistics();
            break;
    }
}

void drawIntro() {
    b.boton1();
    b.interact1();
}

void drawMenu() {
    b2.boton1();
    b2.interact1();

    printHeader("S.H.I.E.L.D.");

    // Menu
    menuItemAgentCreate.display();
    menuItemAgentView.display();
    menuItemPractice.display();
    menuItemTraining.display();
    menuItemStatistics.display();

    printFooter();
}

void drawStatistics() {
    b2.boton1();
    b2.interact1();
    printHeader("Estadisticas");
    btnBack.display();
    printFooter();
}

void drawTraining() {
    b2.boton1();
    b2.interact1();

    printHeader("Entrenamiento");

    if(iniciarEntrenamiento) {
        // sentData = 'X';
        stroke(0,184,182);
        fill(20,20,20,120);
        rect(xEntrenamiento,yEntrenamiento,anchoEntrenamiento,altoEntrenamiento);

        PImage fondoEntrenamiento = loadImage("avengers_wallpaper_city_background_by_thewolfmonster-d4y8job.png");
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
        // row.setInt("Valor de Sensor", altura);
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

    btnBack.display();
    printFooter();
}

void verAgente() {
    b2.boton1();
    b2.interact1();

    printHeader("Ver Agente");

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

    btnBack.display();
    printFooter();
}

void drawPractice() {
    b2.boton1();
    b2.interact1();

    printHeader("Practica");

    if(practicaSeleccionada == 1) {
        // sentData = 'P';
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
            // TableRow row = logPracticaAlejandro.addRow();
            // row.setString("Fecha", dia +"/" + mes +"/" + year);
            // row.setString("Agente", "Alejandro");
            // row.setString("Tipo de ejercicio","Practica");
            // row.setInt("Numero de practica",numeroDePractica);
            // row.setString("Musculo","Biceps" );
            // row.setString("Sensor", "Mioelectrico");
            // row.setInt("Valor de Sensor", encender);
            // row.setInt("Tiempo", tiempoPasado);

            // if(encender >= 30) {
            //     fill(0,190,180,260);
            //     stroke(0,184,182);
            //     rect(150,600,600,172);
            //     fill(255);
            //     textSize(90);
            //     text("ON",375,730);
            //     fill(247,148,30);
            //     stroke(247,148,30);
            //     shape(foco, 800,580,300,370);
            // } else {
            //         fill(255);
            //         stroke(247,148,30);
            //         shape(foco, 800,580,300,370);
            //         stroke(0,184,182);
            //         fill(0,190,180,260);
            //         rect(150,778,600,175);
            //         fill(255);
            //         textSize(90);
            //         text("OFF",375,900);
            // }
        }
    }

    btnBack.display();
    printFooter();
}

void drawAgentCreate() {
    b2.boton1();
    b2.interact1();

    printHeader("Crear Agente");

    stroke(0, 184, 182);
    fill(0,184,182);
    rect(100,200,500,650);
    fill(0);
    rect(110,210,480,320);

    btnBack.display();
    printFooter();
}

// void serialEvent(Serial serialPort) {
//     receivedData = serialPort.read();

//     if(sentData == 'C') {
//         int conectado = receivedData;
//         if(conectado =='C'){
//          println("Conectado y en espera");
//             serialPort.write(sentData);
//      }
//     }

//     if(sentData == 'P') {
//         encender = receivedData;
//         sentData = 'P';
//      println(encender);
//         serialPort.write(sentData);
//     }

//     if(sentData == 'X') {
//         altura = receivedData;
//         println(receivedData);
//         IronMan.altura = (int)map(altura, 0, 255,yEntrenamiento, yEntrenamiento+altoEntrenamiento);
//         serialPort.write(sentData);
//     }

// }

void keyPressed() {
    if (keyPressed) {
        if (keyCode == LEFT) {
            if (index<=0) {
                index = 0;
            } else if (index >= 0 && index <= totalAgentes) {
                index--;
            }
        }

        if (keyCode == RIGHT) {
            if (index >=0 && index <= totalAgentes) {
                index++;
            }

            if (index >= totalAgentes) {
                index = totalAgentes;
            }
        }

        if (key == '1') {
            practicaSeleccionada = 1;
            agenteSeleccionado = 0;
        }

        if (key == 'i') {
            iniciarPractica = true;
            logPracticaAlejandro = loadTable("data/logPracticaAlejandro.csv","header");
        }

        if (key == 's') {
            iniciarPractica = false;
            saveTable(logPracticaAlejandro, "data/logPracticaAlejandro.csv");
            numeroDePractica++;
        }

        if (key=='e') {
            iniciarEntrenamiento = true;
            logPracticaAlejandro = loadTable("data/logPracticaAlejandro.csv","header");
        }

        if (key == 'd') {
            iniciarEntrenamiento = false;
            saveTable(logPracticaAlejandro, "data/logPracticaAlejandro.csv");
            numeroDeEntrenamiento++;
        }
    }
}

void formas() {
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

void printSquareBackground() {
    for (int x = 0; x <= width; x = x + 50) {
        for (int y = 0; y <= height; y = y + 50) {
            stroke(0, 184, 182, 100);
            strokeWeight(0.5);
            line (x, 0, x, width);
            line (0, y, width, y);
        }
    }
    fill(0);
    rect(0, 0, width, height);
}

void printFooter() {
    stroke(0, 184, 182, 100);
    strokeWeight(10);
    line(300, height - 80, width - 300, height - 80);

    stroke(0, 184, 182);
    strokeWeight(6);
    line(width, height, width - 300, height - 100);
    line(0, height, 300, height - 100);
    line(300, height - 100, width - 299, height - 100);
}

void printHeader(String strTitle) {
    shape(objTitleShape, 0, 0);
    fill(0);
    textSize(35);
    text(strTitle, 160, 100);
}