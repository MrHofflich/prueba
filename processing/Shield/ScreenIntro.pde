class ScreenIntro extends Screen {
    private Button _objShield;

    public ScreenIntro() {
        super();

        this._objShield = new Button(width / 2, height / 2, 350, 0);

        this._blnPrintHeader = false;
        this._blnPrintFooter = false;
    }

    protected void render() {
        this._objShield.boton1();
        this._objShield.interact1();
    }
}