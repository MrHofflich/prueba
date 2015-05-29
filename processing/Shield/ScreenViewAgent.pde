class ScreenViewAgent extends Screen {
    private PImage[] _objProfilePhoto = new PImage[3];

    private Table _objTable;
    private TableRow _objTableRow;

    private String[] _strName      = new String[100];
    private String[] _strNick      = new String[100];
    private int[]    _numAge       = new int[100];
    private String[] _strAdmission = new String[100];
    private String[] _strStatus    = new String[100];

    private int _numTotalAgents = 0;
    private int _numIndex       = 0;

    private int _numXcoord     = 180;
    private int _numYCoord     = 550;
    private int _numSeparation = 60;

    private BackButton _btnBack;

    public ScreenViewAgent(String strTitle) {
        super(strTitle);

        // Load profile photos
        for (int i = 0; i < this._objProfilePhoto.length; i++) {
            this._objProfilePhoto[i] = loadImage( i + ".jpg" ); // make sure images "0.jpg" to "11.jpg" exist
        }

        this._objTable       = loadTable("datos.csv","header");
        this._numTotalAgents = this._objTable.getRowCount();

        this._btnBack = new BackButton();
    }

    protected void render() {
        for (int i = 0; i < this._numTotalAgents; i++) {
            this._objTableRow     = this._objTable.getRow(i);
            this._strName[i]      = this._objTableRow.getString("Nombre");
            this._strNick[i]      = this._objTableRow.getString("Nick");
            this._numAge[i]       = this._objTableRow.getInt("Edad");
            this._strAdmission[i] = this._objTableRow.getString ("Ingreso");
            this._strStatus[i]    = this._objTableRow.getString("Estatus");
        }

        stroke(0,184,182);
        fill(0,190,180,120);
        rect(130,180,500,700);
        fill(255,180);
        text("Nombre:" + this._strName[this._numIndex], this._numXcoord, this._numYCoord + this._numSeparation * 0);
        text("Alias: " + this._strNick[this._numIndex], this._numXcoord, this._numYCoord + this._numSeparation * 1);
        text("Edad: " + this._numAge[this._numIndex], this._numXcoord, this._numYCoord + this._numSeparation * 2);
        text("Fecha de Ingreso: " + this._strAdmission[this._numIndex], this._numXcoord, this._numYCoord + this._numSeparation * 3);
        text("Estatus: " + this._strStatus[this._numIndex], this._numXcoord, this._numYCoord + this._numSeparation * 4);
        image(this._objProfilePhoto[this._numIndex], this._numXcoord, 200, 400, 300);

        this._btnBack.display();
    }

    public void keyPressed() {
        if (keyCode == LEFT) {
            this._numIndex--;

            if (this._numIndex < 0) {
                this._numIndex = 0;
            }
        }

        if (keyCode == RIGHT) {
            this._numIndex++;
            if (this._numIndex >= (this._numTotalAgents - 1)) {
                this._numIndex = this._numTotalAgents - 1;
            }
        }
    }
}