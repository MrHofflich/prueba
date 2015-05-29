// Libraries
import processing.serial.*;

// Menu (initial state)
int numState = Screen.SCREEN_INTRO;

// Arduino
Arduino objArduino;

// Screens
ScreenIntro       objScreenIntro;
ScreenMenu        objScreenMenu;
ScreenPractice    objScreenPractice;
ScreenAgentCreate objScreenAgentCreate;
ScreenViewAgent   objScreenViewAgent;
ScreenTraining    objScreenTraining;
ScreenStatistics  objScreenStatistics;

void setup() {
    size(displayWidth, displayHeight, P3D);

    objArduino = new Arduino(this);

    objScreenIntro       = new ScreenIntro();
    objScreenMenu        = new ScreenMenu("S.H.I.E.L.D.");
    objScreenStatistics  = new ScreenStatistics("Estadisticas");
    objScreenPractice    = new ScreenPractice("Practica");
    objScreenAgentCreate = new ScreenAgentCreate("Crear Agente");
    objScreenViewAgent   = new ScreenViewAgent("Ver Agente");
    objScreenTraining    = new ScreenTraining("Entrenamiento");
}

void draw() {
    noStroke();

    switch (numState) {
        case Screen.SCREEN_INTRO:
            objScreenIntro.display();
            break;
        case Screen.SCREEN_MENU:
            objScreenMenu.display();
            break;
        case Screen.SCREEN_AGENT_CREATE:
            objScreenAgentCreate.display();
            break;
        case Screen.SCREEN_AGENT_VIEW:
            objScreenViewAgent.display();
            break;
        case Screen.SCREEN_PRACTICE:
            objScreenPractice.display();
            objScreenPractice.setArduino(objArduino);
            break;
        case Screen.SCREEN_TRAINING:
            objScreenTraining.display();
            objScreenTraining.setArduino(objArduino);
            break;
        case Screen.SCREEN_STATISTICS:
            objScreenStatistics.display();
            break;
    }

    // Try to identify where arduino is plugged
    objArduino.loop();
}

/**
 * Map serial event to Arduino instance.
 *
 * @param  Serial objPort
 * @return void
 */
void serialEvent(Serial objPort) {
    objArduino.serialEvent(objPort);
}

/**
 * Map the event keyPressed() to the required view.
 *
 * @return void
 */
void keyPressed() {
    if (keyPressed) {
        switch (numState) {
            case Screen.SCREEN_AGENT_VIEW:
                objScreenViewAgent.keyPressed();
                break;
            case Screen.SCREEN_PRACTICE:
                objScreenPractice.keyPressed();
                break;
            case Screen.SCREEN_TRAINING:
                objScreenTraining.keyPressed();
                break;
        }
    }
}

/**
 * Always run the application in full screen.
 *
 * @return boolean
 */
boolean sketchFullScreen() {
    return true;
}