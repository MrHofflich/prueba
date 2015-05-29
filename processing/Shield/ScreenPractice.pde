class ScreenPractice extends Screen {
    private PShape _objBulb;
    private PShape _objPracticeLabel;
    private PShape _objAgentLabel;
    private BackButton _btnBack;
    private Arduino _objArduino;

    private int _numSensorValue       = 0;
    private int _numThreashold        = 255;
    private boolean _blnStartPractice = false;

    // Table     logPracticaAlejandro;
    // Table     table;
    // TableRow  row;
    // int dia = day();
    // int mes = month();
    // int year = year();

    public ScreenPractice(String strTitle) {
        super(strTitle);

        this._objPracticeLabel = createShape();

        this._objPracticeLabel.beginShape();
        this._objPracticeLabel.fill(0,184,182,200);
        this._objPracticeLabel.stroke(0,184,182);
        this._objPracticeLabel.vertex(0,0);
        this._objPracticeLabel.vertex(70,100);
        this._objPracticeLabel.vertex(370,100);
        this._objPracticeLabel.vertex(440,0);
        this._objPracticeLabel.endShape();

        this._objAgentLabel = createShape();

        this._objAgentLabel.beginShape();
        this._objAgentLabel.fill(0,184,182,200);
        this._objAgentLabel.stroke(0,184,182);
        this._objAgentLabel.vertex(0,0);
        this._objAgentLabel.vertex(70,70);
        this._objAgentLabel.vertex(400,70);
        this._objAgentLabel.vertex(470,0);
        this._objAgentLabel.endShape();

        this._objBulb = loadShape("light-bulb-7.svg");

        this._btnBack = new BackButton();
        // logPracticaAlejandro = loadTable("logPracticaAlejandro.csv", "header");
    }

    protected void render() {
        textSize(15);
        stroke(0, 184, 182);
        fill(255);
        shape(this._objPracticeLabel, 650, 0);
        shape(this._objAgentLabel, 1100, 0);
        textSize(90);
        text("Biceps", 730, 80);
        textSize(60);
        text("Alejandro", 1200, 50);
        stroke(0, 184, 182);
        fill(0, 190, 180, 120);
        rect(150, 600, 600, 350);
        stroke(255);
        strokeWeight(3);
        line(180, 775, 730, 775);
        strokeWeight(1);
        this._objBulb.disableStyle();
        fill(255);
        shape(this._objBulb, 800, 580, 300, 370);
        fill(255);
        textSize(90);
        text("ON", 375, 730);
        text("OFF", 375, 900);

        if (this._blnStartPractice) {
            // TableRow row = logPracticaAlejandro.addRow();
            // row.setString("Fecha", dia +"/" + mes +"/" + year);
            // row.setString("Agente", "Alejandro");
            // row.setString("Tipo de ejercicio","Practica");
            // row.setInt("Numero de practica",numeroDePractica);
            // row.setString("Musculo","Biceps" );
            // row.setString("Sensor", "Mioelectrico");
            // row.setInt("Valor de Sensor", encender);

            this._objArduino.requestSensorValue(1);

            try {
                this._numSensorValue = int(this._objArduino.readSensorValue(1));
            } catch (Exception e) {
                this._numSensorValue = 0;
            }

            if (this._numSensorValue  >= this._numThreashold) {
                fill(0,190,180,260);
                stroke(0,184,182);
                rect(150,600,600,172);
                fill(255);
                textSize(90);
                text("ON",375,730);
                fill(247,148,30);
                stroke(247,148,30);
                shape(this._objBulb, 800,580,300,370);
            } else {
                fill(255);
                stroke(247,148,30);
                shape(this._objBulb, 800,580,300,370);
                stroke(0,184,182);
                fill(0,190,180,260);
                rect(150,778,600,175);
                fill(255);
                textSize(90);
                text("OFF",375,900);
            }
        }

        this._btnBack.display();
    }

    public void keyPressed() {
        if (key == 'i') {
            this._blnStartPractice = true;
            // logPracticaAlejandro = loadTable("data/logPracticaAlejandro.csv","header");
        }

        if (key == 's') {
            this._blnStartPractice = false;
            // saveTable(logPracticaAlejandro, "data/logPracticaAlejandro.csv");
        }
    }

    public void setArduino(Arduino objArduino) {
        this._objArduino = objArduino;
    }
}