class BackButton {
    private PShape _objButton;

    final private String _strTitle = "Atrás";

    final private int _numFontSize = 35;

    public BackButton() {
        this._objButton = createShape();

        this._objButton.beginShape();
        this._objButton.fill(0,184,182,200);
        this._objButton.noStroke();
        this._objButton.vertex(0, 0);
        this._objButton.vertex(-120, -80);
        this._objButton.vertex(-450, -80);
        this._objButton.vertex(-380, -150);
        this._objButton.vertex(-90, -150);
        this._objButton.vertex(0, -95);
        this._objButton.endShape();
    }

    public void display() {
        shape(this._objButton, width, height - 50);
        fill(0);
        textSize(this._numFontSize);
        text(this._strTitle, width - 370, height - 150);

        if(mouseX >= width - 450 && mouseX <= width - 90 && mouseY <= height - 130 && mouseY >= height - 200) {
            shape(this._objButton, width, height - 50);
            textSize(this._numFontSize);
            text(this._strTitle, width - 370, height - 150);
            if(mousePressed) {
                numState = Screen.SCREEN_MENU;
            }
        }
    }
}