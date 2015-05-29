class ScreenTraining extends Screen {
    private objeto[]  _objReactor;
    // private arcR      IronMan;
    private Character _objCharacter;

    private boolean _blnRun;

    private int _numTotalDrops      = 0;
    private int _numTotalDropCaught = 0;
    private int _numXTraining       = 100;
    private int _numYTraining       = 210;
    private int _numWidthTraining   = 1700;
    private int _numHeightTraining  = 600;
    private int _numIronManWidth    = 110;

    private int _numSensorValue     = 0;

    private PImage _objBackground;

    private Timer _objTimer;

    private BackButton _btnBack;

    private Arduino _objArduino;

    //Variables de datos
    // Table     logPracticaAlejandro;
    // Table     table;
    // TableRow  row;

    public ScreenTraining(String strTitle) {
        super(strTitle);
        // logPracticaAlejandro = loadTable("logPracticaAlejandro.csv", "header");

        // this.IronMan = new arcR(
        //     this._numXTraining + this._numIronManWidth / 2,
        //     this._numYTraining,
        //     this._numIronManWidth,
        //     this._numYTraining,
        //     this._numHeightTraining
        // );

        this._objCharacter = new Character("image10.png", this._numIronManWidth);
        this._objCharacter.setLimits(
            this._numXTraining,
            this._numYTraining,
            this._numXTraining + this._numWidthTraining,
            this._numYTraining + this._numHeightTraining
        );

        this._objReactor    = new objeto[50];
        this._objTimer      = new Timer(800);
        this._objBackground = loadImage("avengers_wallpaper_city_background_by_thewolfmonster-d4y8job.png");
        this._btnBack       = new BackButton();
    }

    protected void render() {
        if (this.isRunning()) {
            stroke(0,184,182);
            fill(20,20,20,120);
            rect(this._numXTraining, this._numYTraining, this._numWidthTraining, this._numHeightTraining);

            image(this._objBackground, this._numXTraining, this._numYTraining, this._numWidthTraining, this._numHeightTraining);

            this._objCharacter.display();
            this._objCharacter.update();

            // this.IronMan.display();
            // this.IronMan.update();

            this._objArduino.requestSensorValue(1);
            this._numSensorValue = int(this._objArduino.readSensorValue(1));

            // this.IronMan.setAltura(this._numSensorValue);
            this._objCharacter.setYPosition(this._numSensorValue);

            // TableRow row = logPracticaAlejandro.addRow();
            // row.setString("Fecha", dia +"/" + mes +"/" + year);
            // row.setString("Agente", "Alejandro");
            // row.setString("Tipo de ejercicio","Entrenamiento");
            // row.setString("Musculo","Biceps" );
            // row.setString("Sensor", "Mioelectrico");
            // row.setInt("Valor de Sensor", altura);
            // row.setInt("Tiempo", tiempoPasado);

            if (this._objTimer.isFinished()) {
                //ahora siguen las gotas
                //initialize one drop
                this._objReactor[this._numTotalDrops] = new objeto(this._numXTraining, this._numYTraining, this._numHeightTraining, this._numWidthTraining);
                //increment total drops
                this._numTotalDrops++;
                // If we hit the end of the array
                if (this._numTotalDrops >= this._objReactor.length) {
                    this._numTotalDrops = 0; //lo reinicias
                }
                this._objTimer.start();
            }

            // Move and display all drops
            for (int i= 0 ; i < this._numTotalDrops ; i++) {
                this._objReactor[i].move();
                this._objReactor[i].display();
                // if (this.IronMan.intersect(this._objReactor[i])) {
                //     this._objReactor[i].caught();
                //     this._numTotalDropCaught++;
                // }
                if (this._objCharacter.intersect(this._objReactor[i])) {
                    this._objReactor[i].caught();
                    this._numTotalDropCaught++;
                }
            }

            if (this._numTotalDropCaught >= 20) {
                background(0);
                textSize(50);
                stroke(255);
                fill(255);
                text("Perfecto Sr. Stark",width/2-100,height/2);
                this.stop();
            }
        }

        this._btnBack.display();
    }

    public void keyPressed() {
        if (key=='e') {
            this.start();
            // logPracticaAlejandro = loadTable("data/logPracticaAlejandro.csv","header");
        }

        if (key == 'd') {
            this.stop();
            // saveTable(logPracticaAlejandro, "data/logPracticaAlejandro.csv");
        }
    }

    protected void start() {
        this._blnRun = true;
    }

    protected void stop() {
        this._blnRun = false;
    }

    protected boolean isRunning() {
        return this._blnRun;
    }

    public void setArduino(Arduino objArduino) {
        this._objArduino = objArduino;
    }
}