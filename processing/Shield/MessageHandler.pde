import java.util.HashMap;

class MessageHandler {
    Map<String, Message> _mapMessages = new HashMap<String, Message>();

    public void put(Message objMessage) {
        Message objCurrentMessage = this._mapMessages.get(objMessage.getRawMessage());

        if (objCurrentMessage != null && !objCurrentMessage.inQueue()) {
            objMessage.setInQueue(true);
            this._mapMessages.put(objMessage.getRawMessage(), objMessage);
        }
    }

    public Message get(String strMessage) {
        return this._mapMessages.get(strMessage);
    }

    public void delivered(String strMessage) {
        Message objMessage = this._mapMessages.get(strMessage);
        if (objMessage != null) {
            objMessage.setInQueue(false);
        }
    }
}