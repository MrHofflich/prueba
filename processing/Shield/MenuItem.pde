class MenuItem {
    private PShape _objMenuItem;
    private String _strMessage;
    private int    _numState;
    private int    _numIndex;

    private int _numXCoord;
    private int _numYCoord;

    private boolean _blnPressed = false;

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

        this._numXCoord = width / 4;
        this._numYCoord = (height / 4) + (this._numSeparationRatio * this._numIndex);
    }

    public void display() {
        shape(this._objMenuItem, this._numXCoord, this._numYCoord);
        fill(0);
        textSize(this._numFontSize);
        text(
            this._strMessage,
            this._numXCoord + (this._numWidth - textWidth(this._strMessage)) / 2,
            this._numYCoord + this._numHeight / 2 + 10
        );

        if (this.isOver()) {
            shape(this._objMenuItem, this._numXCoord, this._numYCoord);
            fill(0);
            textSize(this._numFontSize);
            text(
                this._strMessage,
                this._numXCoord + (this._numWidth - textWidth(this._strMessage)) / 2,
                this._numYCoord + this._numHeight / 2 + 10
            );
            if(mousePressed) {
                if (!this._blnPressed) {
                    this._blnPressed = true;
                    numState = this._numState;
                }
            }
        } else {
            this._blnPressed = false;
        }
    }

    protected boolean isOver() {
        if (mouseX >= this._numXCoord
                && mouseX <= this._numXCoord + this._numWidth
                && mouseY >= this._numYCoord
                && mouseY <= this._numYCoord + this._numHeight) {
            return true;
        }
        return false;
    }
}