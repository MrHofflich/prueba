import java.util.Map;

class Arduino {
    private Shield _objClass;
    private Serial _objPort;

    private boolean _blnPortAvailable  = false;

    private ArrayList<String> _objListOfPorts;

    private String _strCurrentPort;

    private MessageHandler _objMessageHandler;

    //=====[ PROTOCOL ]=======================
    public static final char PROTOCOL_START_SEQUENCE = '~';
    public static final char PROTOCOL_START_HEADER   = 'H';
    public static final char PROTOCOL_START_ECHO     = 'E';

    public static final char PROTOCOL_TYPE_MESSAGE   = 'M';
    public static final char PROTOCOL_TYPE_ANSWER    = 'A';
    public static final char PROTOCOL_TYPE_REQUEST   = 'R';
    public static final char PROTOCOL_TYPE_SEND      = 'S';
    public static final char PROTOCOL_TYPE_COMMAND   = 'C';
    public static final char PROTOCOL_TYPE_MULTIPLE  = 'P';

    public static final char PROTOCOL_ELEMENT_LED    = 'L';
    public static final char PROTOCOL_ELEMENT_SENSOR = 'S';

    public static final char PROTOCOL_SEPARATOR      = ',';

    public static final int PROTOCOL_MESSAGE_LENGTH = 13;

    //=====[ TIMERS ]=======================
    public static final int SECOND = 1000;
    public static final int MINUTE = 60000;

    public static final int TIMEOUT_CONNECTION = 5 * SECOND;
    public static final int TIMEOUT_PRACTICE   = 500;

    private long _numTimerConnection = 0;
    private long _numTimerPractice   = 0;

    Map<String, String> _strMessages = new HashMap<String, String>();

    public Arduino(Shield objClass) {
        this._objClass = objClass;
        this._objListOfPorts = new ArrayList<String>();
        this._objMessageHandler = new MessageHandler();

        // for (String strPort : Serial.list()) {
        //     this._objListOfPorts.add(strPort);
        // }
        this._objListOfPorts.add("/dev/cu.usbmodem1d11411");
        // this._objListOfPorts.add("/dev/cu.usbmodem1d1111");
        // this._objListOfPorts.add("/dev/cu.usbmodem1d11311");
        println(Serial.list());
    }

    public void loop() {
        this.configure();

        if (millis() - _numTimerConnection >= TIMEOUT_CONNECTION) {
            this.sendHeloMessage();
            _numTimerConnection = millis();
        }
    }

    protected void configure() {
        if (!this._blnPortAvailable) {
            for (int i = 0; i < this._objListOfPorts.size(); i++) {
                this._strCurrentPort = this._objListOfPorts.get(i);
                println("Trying: " + this._strCurrentPort);
                try {
                    this._objPort = new Serial(this._objClass, this._strCurrentPort, 9600);
                    this.toogglePort(true);
                    this.sendHeloMessage();
                    _numTimerConnection = millis();
                } catch (Exception e) {
                    e.printStackTrace();
                    this._blnPortAvailable  = false;
                    this._objListOfPorts.remove(i);
                }
            }
        }
    }

    public void serialEvent(Serial objSerial) {
        try {
            String strMessage = objSerial.readStringUntil('\n');

            if (strMessage != null) {
                print("Getting: ");
                println(strMessage);
                String[] arrMessage = this.unpkg(strMessage);
                if (arrMessage.length == 4) {
                    String strType = arrMessage[0];
                    char chrMessageType = strType.charAt(0);
                    // We have a valid message
                    if (chrMessageType == 'M') {
                        if (arrMessage[3].equals("0H")) {
                            this.toogglePort(true);
                            this.sendHeloMessage();
                        }
                    }

                    if (chrMessageType == 'S') {
                        this._strMessages.put(arrMessage[2], arrMessage[3]);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void write(String strMessage) {
        if (this._blnPortAvailable) {
            for (int i = 0; i < strMessage.length(); i++) {
                this._objPort.write(strMessage.charAt(i));
            }
            this._objPort.write(10);
            println("Sending: " + strMessage);
        } else {
            println("Port is not available: write");
        }
    }

    public void toogglePort(boolean blnStatus) {
        this._blnPortAvailable = blnStatus;
    }

    /**
     * Send a HELO message
     *
     * ~H,M,0,00,0H,\n
     *
     * @return void
     */
    public void sendHeloMessage() {
        if (this._blnPortAvailable) {
            String strMessage = this.pkg('M', 0, "00", "0H");
            this.write(strMessage);
        }
    }

    /**
     * Request a sensor value
     *
     * ~H,R,0,S1,00,\n
     *
     * @return void
     */
    // public void requestSensorValue(int numSensor) {
    //     if (millis() - _numTimerPractice >= TIMEOUT_PRACTICE) {
    //         String strCurrentValue = this._strMessages.get("S" + numSensor);
    //         if (strCurrentValue != null) {
    //             this._strMessages.put("S" + numSensor, strCurrentValue);
    //         } else {
    //             this._strMessages.put("S" + numSensor, "00");
    //         }
    //         String strMessage = this.pkg('R', 0, "S" + numSensor, "00");
    //         println(strMessage);
    //         this.write(strMessage);
    //         _numTimerPractice = millis();
    //     }
    // }
    public void requestSensorValue(int numSensor) {
        if (millis() - _numTimerPractice >= TIMEOUT_PRACTICE) {
            String strMessage = this.pkg('R', 0, "S" + numSensor, "00");
            Message objMessage = this._objMessageHandler.get(strMessage);
            if (objMessage == null) {
                objMessage = new Message.MessageBuilder(strMessage)
                    .type("R")
                    .index(0)
                    .element("S" + numSensor)
                    .build();
            }
            if (!objMessage.inQueue()) {
                objMessage.setInQueue(true);
                this._objMessageHandler.put(objMessage);
                this.write(strMessage);
            }
            _numTimerPractice = millis();
        }
    }

    public String readSensorValue(int numSensor) {
        return this._strMessages.get("S" + 1);
    }

    protected String pkg(char chrType, int numIndex, String strElement, String strValue) {
        StringBuilder objBuilder = new StringBuilder();
        objBuilder.append('~');
        objBuilder.append('H');
        objBuilder.append(',');
        objBuilder.append(chrType);
        objBuilder.append(',');
        objBuilder.append(numIndex);
        objBuilder.append(',');
        objBuilder.append(strElement);
        objBuilder.append(',');
        objBuilder.append(strValue);
        objBuilder.append(',');
        return objBuilder.toString();
    }

    protected String[] unpkg(String strMessage) {
        ArrayList<String> arrList = new ArrayList<String>();

        if (strMessage.getBytes().length >= PROTOCOL_MESSAGE_LENGTH) {
            String[] arrMessage = strMessage.split(",");
            String strMessageHeaderSent = arrMessage[0];
            if (strMessageHeaderSent.equals("~H")) {
                for (int i = 1; i < arrMessage.length - 1; i++) {
                    arrList.add(arrMessage[i]);
                }
            }
        }

        String[] arrReturn = new String[arrList.size()];
        arrReturn = arrList.toArray(arrReturn);
        return arrReturn;
    }

    public void printBinary(String strString) {
        byte[] arrBytes         = strString.getBytes();
        StringBuilder objBinary = new StringBuilder();

        for (byte bByte : arrBytes) {
            int numVal = bByte;
            for (int i = 0; i < 8; i++) {
                objBinary.append((numVal & 128) == 0 ? 0 : 1);
                numVal <<= 1;
            }
            objBinary.append(' ');
        }
        println("'" + strString + "' to binary: " + objBinary);
    }
}