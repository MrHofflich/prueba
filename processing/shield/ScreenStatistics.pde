class ScreenStatistics extends Screen {
    private BackButton _btnBack;

    public ScreenStatistics(String strTitle) {
        super(strTitle);

        this._btnBack = new BackButton();
    }

    protected void render() {
        this._btnBack.display();
    }
}