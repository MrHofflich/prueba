class MenuItem {
    private PShape _objMenuItem;
    private String _strMessage;
    private int    _numState;
    private int    _numIndex;

    final private int _numWidth     = 790;
    final private int _numHeight    = 60;
    final private int _numVariation = 40;

    final private int _numFontSize        = 35;
    final private int _numSeparationRatio = 80;

    public MenuItem(String _strMessage, int _numState, int _numIndex) {
        this._strMessage  = _strMessage;
        this._numState    = _numState;
        this._numIndex    = _numIndex;

        this._objMenuItem = createShape();

        this._objMenuItem.beginShape();
        this._objMenuItem.fill(0, 184, 182, 150);
        this._objMenuItem.noStroke();
        this._objMenuItem.vertex(0, 0);
        this._objMenuItem.vertex(this._numWidth, 0);
        this._objMenuItem.vertex(this._numWidth - this._numVariation, this._numHeight);
        this._objMenuItem.vertex(-this._numVariation, this._numHeight);
        this._objMenuItem.endShape();
    }

    public void display() {
        int xcoord = width / 4;
        int ycoord = (height / 4) + (this._numSeparationRatio * this._numIndex);

        shape(this._objMenuItem, xcoord, ycoord);
        fill(0);
        textSize(this._numFontSize);
        text(
            this._strMessage,
            xcoord + (this._numWidth - textWidth(this._strMessage)) / 2,
            ycoord + this._numHeight / 2 + 10
        );

        if (mouseX >= xcoord && mouseX <= xcoord + this._numWidth && mouseY >= ycoord && mouseY <= ycoord + this._numHeight) {
            shape(this._objMenuItem, xcoord, ycoord);
            fill(0);
            textSize(this._numFontSize);
            text(
                this._strMessage,
                xcoord + (this._numWidth - textWidth(this._strMessage)) / 2,
                ycoord + this._numHeight / 2 + 10
            );
            if(mousePressed) {
                numState = this._numState;
            }
        }
    }
}