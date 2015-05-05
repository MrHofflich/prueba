class Arduino {
    private Serial  _objPort;
    private boolean _blnPortAvailable = false;
    private shield _objClass;

    public Arduino(shield objClass) {
        this._objClass = objClass;
    }

    public void configure() {
        if (!this._blnPortAvailable) {
            println(Serial.list());
            for (String strPort : Serial.list()) {
                println("strPort: " + strPort);
                try {
                    this._objPort = new Serial(this._objClass, strPort, 9600);
                    this._blnPortAvailable = true;
                    break;
                } catch (Exception e) {
                    this._blnPortAvailable = false;
                }
            }
        }
    }

    public int read() {
        int numReturn = 0;

        if (this._blnPortAvailable && this._objPort.available() > 0) {
            numReturn = this._objPort.read();
        }

        return numReturn;
    }

    public void write(int numData) {
        if (this._blnPortAvailable && this._objPort.available() > 0) {
            this._objPort.write(numData);
        } else {
            println("Port is not available: write");
        }
    }
}