abstract class Screen {
    public static final int SCREEN_INTRO        = 1;
    public static final int SCREEN_MENU         = 2;
    public static final int SCREEN_AGENT_CREATE = 3;
    public static final int SCREEN_AGENT_VIEW   = 4;
    public static final int SCREEN_PRACTICE     = 5;
    public static final int SCREEN_TRAINING     = 6;
    public static final int SCREEN_STATISTICS   = 7;

    private Button _objButton;
    private PShape _objTitleShape;
    private String _strTitle;

    protected boolean _blnPrintHeader     = true;
    protected boolean _blnPrintFooter     = true;
    protected boolean _blnPrintBackground = true;

    public Screen() {
        this("");
    }

    public Screen(String strTitle) {
        this._strTitle = strTitle;

        this._objButton = new Button(width / 1.1, height / 12, 150, 150);

        this._objTitleShape = createShape();

        this._objTitleShape.beginShape();
        this._objTitleShape.fill(0, 184, 182, 150);
        this._objTitleShape.noStroke();
        this._objTitleShape.vertex(0, 0);
        this._objTitleShape.vertex(120, 0);
        this._objTitleShape.vertex(170, 50);
        this._objTitleShape.vertex(500, 50);
        this._objTitleShape.vertex(480, 110);
        this._objTitleShape.vertex(110, 110);
        this._objTitleShape.vertex(0, 0);
        this._objTitleShape.endShape();
    }

    abstract protected void render();

    public void display() {
        if (this._blnPrintBackground) {
            this.printBackground();
        }

        if (this._blnPrintHeader) {
            this.printHeader();
        }

        this.render();

        if (this._blnPrintFooter) {
            this.printFooter();
        }
    }

    protected void printBackground() {
        for (int x = 0; x <= width; x = x + 50) {
            for (int y = 0; y <= height; y = y + 50) {
                stroke(0, 184, 182, 100);
                strokeWeight(0.5);
                line (x, 0, x, width);
                line (0, y, width, y);
            }
        }
        fill(0);
        rect(0, 0, width, height);
    }

    protected void printFooter() {
        stroke(0, 184, 182, 100);
        strokeWeight(10);
        line(300, height - 80, width - 300, height - 80);

        stroke(0, 184, 182);
        strokeWeight(6);
        line(width, height, width - 300, height - 100);
        line(0, height, 300, height - 100);
        line(300, height - 100, width - 299, height - 100);
    }

    protected void printHeader() {
        shape(this._objTitleShape, 0, 0);
        fill(0);
        textSize(35);
        text(this._strTitle, 160, 100);

        this._objButton.boton1();
        this._objButton.interact1();
    }
}