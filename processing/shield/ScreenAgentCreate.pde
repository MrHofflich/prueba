class ScreenAgentCreate extends Screen {
    private BackButton _btnBack;

    public ScreenAgentCreate(String strTitle) {
        super(strTitle);

        this._btnBack = new BackButton();
    }

    protected void render() {
        stroke(0, 184, 182);
        fill(0,184,182);
        rect(100,200,500,650);
        fill(0);
        rect(110,210,480,320);
        this._btnBack.display();
    }
}