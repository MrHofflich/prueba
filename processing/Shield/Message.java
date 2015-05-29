// ~H,M,0,00,0H,\n // Send a helo message
// ~H,C,0,L1,01,\n // Turn on led 1
class Message {
    private final String _strRawMessage;
    private final String _strHeader;
    private final String _strType;
    private final int    _numIndex;
    private final String _strElement;

    private String  _strValue;
    private boolean _blnInQueue;

    private Message(MessageBuilder objMessageBuilder) {
        this._strRawMessage = objMessageBuilder._strRawMessage;
        this._strType       = objMessageBuilder._strType;
        this._numIndex      = objMessageBuilder._numIndex;
        this._strElement    = objMessageBuilder._strElement;

        this._strHeader  = "~H";
        this._strValue   = "00";
        this._blnInQueue = false;
    }

    public String getRawMessage() {
        return this._strRawMessage;
    }

    public String getHeader() {
        return this._strHeader;
    }

    public String getType() {
        return this._strType;
    }

    public int getIndex() {
        return this._numIndex;
    }

    public String getElement() {
        return this._strElement;
    }

    public String getValue() {
        return this._strValue;
    }

    public void setValue(String strValue) {
        this._strValue = strValue;
    }

    public boolean inQueue() {
        return this._blnInQueue;
    }

    public void setInQueue(boolean blnInQueue) {
        this._blnInQueue = blnInQueue;
    }

    public static class MessageBuilder {
        private final String _strRawMessage;

        private String _strType;
        private int    _numIndex;
        private String _strElement;

        public MessageBuilder(String strRequestMessage) {
            this._strRawMessage = strRequestMessage;
        }

        public MessageBuilder type(String strType) {
            this._strType = strType;
            return this;
        }

        public MessageBuilder index(int numIndex) {
            this._numIndex = numIndex;
            return this;
        }

        public MessageBuilder element(String strElement) {
            this._strElement = strElement;
            return this;
        }

        public Message build() {
            return new Message(this);
        }
    }
}