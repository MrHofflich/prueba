#include "RGB.h"
#include "SerialComm.h"


//=====[ DEBUG ]==========================
#define DEBUG 0

//=====[ PINS ]===========================
const byte _pin_red   = 3;
const byte _pin_green = 5;
const byte _pin_blue  = 6;

const byte _pin_potentiometer = A2;

//=====[ PROTOCOL ]=======================
const char PROTOCOL_START_SEQUENCE = '~';
const char PROTOCOL_START_HEADER   = 'H';
const char PROTOCOL_START_ECHO     = 'E';

const char PROTOCOL_TYPE_MESSAGE   = 'M';
const char PROTOCOL_TYPE_ANSWER    = 'A';
const char PROTOCOL_TYPE_REQUEST   = 'R';
const char PROTOCOL_TYPE_SEND      = 'S';
const char PROTOCOL_TYPE_COMMAND   = 'C';
const char PROTOCOL_TYPE_MULTIPLE  = 'P';

const char PROTOCOL_ELEMENT_LED    = 'L';
const char PROTOCOL_ELEMENT_SENSOR = 'S';

const char PROTOCOL_SEPARATOR      = ',';

const int PROTOCOL_MESSAGE_LENGTH  = 13;

//=====[ VARIABLES ] =====================
unsigned int _num_potentiometer = 0;

boolean _blnConnectionEstablished = false;

RGB rgb(_pin_red, _pin_green, _pin_blue);

SerialComm objPackage = SerialComm();

//=====[ TIMERS ] ========================
const int SECOND = 1000;
const int MINUTE = 60000;

const int TIMEOUT_CONNECTION = 10 * SECOND;

unsigned long _num_timer_connection = 0;

//=====[ MESSAGE ] =======================
char charBuffer[PROTOCOL_MESSAGE_LENGTH];

//=====[ BEGIN ] =======================
void setup() {
    Serial.begin(9600);
    rgb.color(0, 0, 0);
}

void loop() {
    // Waiting for commands
    if (!_blnConnectionEstablished) {
        rgb.blink(0, 255, 0, 500);
    }

    if (millis() - _num_timer_connection >= TIMEOUT_CONNECTION) {
        _blnConnectionEstablished = false;
    }
}

void serialEvent() {
    int numBytes = serialParser();

    if (numBytes  > 0) {
        sendEcho();

        // We have a valid message
        if (String(objPackage.getHeader()).equals("~H")) {
            switch (objPackage.getType()[0]) {
                case 'M':
                    if (objPackage.getValue()[1] == 'H') {
                        _blnConnectionEstablished = true;
                        _num_timer_connection = millis();
                        rgb.color(0, 255, 0);
                    }
                    break;
                case 'R':
                    _num_potentiometer = analogRead(_pin_potentiometer);
                    sendSensorMessage(objPackage.getElement()[1] - '0', _num_potentiometer);
                break;
            }
        }
        numBytes = 0;
    }
}

//~H,S,0,S1,11,\n // Send the value of sensor 1
void sendSensorMessage(int numSensor, int numValue) {
    Serial.print(PROTOCOL_START_SEQUENCE);
    Serial.print(PROTOCOL_START_HEADER);
    Serial.print(PROTOCOL_SEPARATOR);
    Serial.print(PROTOCOL_TYPE_SEND);
    Serial.print(PROTOCOL_SEPARATOR);
    Serial.print(0);
    Serial.print(PROTOCOL_SEPARATOR);
    Serial.print('S');
    Serial.print(numSensor);
    Serial.print(PROTOCOL_SEPARATOR);
    Serial.print(numValue);
    Serial.print(PROTOCOL_SEPARATOR);
    Serial.println(); // send cr/lf
}

void sendEcho() {
    Serial.print(PROTOCOL_START_SEQUENCE);
    Serial.print(PROTOCOL_START_ECHO);
    Serial.print(PROTOCOL_SEPARATOR);
    Serial.print(objPackage.getType());
    Serial.print(PROTOCOL_SEPARATOR);
    Serial.print(objPackage.getIndex());
    Serial.print(PROTOCOL_SEPARATOR);
    Serial.print(objPackage.getElement());
    Serial.print(PROTOCOL_SEPARATOR);
    Serial.print(objPackage.getValue());
    Serial.print(PROTOCOL_SEPARATOR);
    Serial.println(); // send cr/lf
}

int serialParser() {
    int numByteCount = 0;
    numByteCount =  Serial.readBytesUntil('\n', charBuffer, PROTOCOL_MESSAGE_LENGTH);
    if (DEBUG) {
        Serial.print("Buffer size: ");
        Serial.println(numByteCount);
    }
    if (numByteCount  == PROTOCOL_MESSAGE_LENGTH) {
        objPackage.setBuffer(charBuffer);
    }
    memset(charBuffer, 0, sizeof(charBuffer));
    Serial.flush();
    return numByteCount;
}