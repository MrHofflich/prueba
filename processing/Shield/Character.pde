class Character {

    public static final float GRAVITY = 0.1;

    protected float _numSpeed = 5;

    protected float _numXCoord;
    protected float _numYCoord;
    protected float _numMaxXCoord;
    protected float _numMaxYCoord;

    protected float _numWidth;
    protected String _strImage;

    protected float _numXPosition;
    protected float _numYPosition;

    protected PImage _objImage;

    public Character (String strImage, float numWidth) {
        this._objImage = loadImage(strImage);
        this._numWidth = numWidth;
    }

    public void setLimits(float numXCoord, float numYCoord, float numMaxXCoord, float numMaxYCoord) {
        this._numXCoord    = numXCoord;
        this._numYCoord    = numYCoord;
        this._numMaxXCoord = numMaxXCoord;
        this._numMaxYCoord = numMaxYCoord;

        this._numXPosition = numXCoord + (this._numWidth * 4);
        this._numYPosition = (numMaxYCoord - numYCoord) / 2;
    }

    public void display() {
        noStroke();
        fill(33, 254, 237);
        image(
            this._objImage,     // PImage
            this._numXPosition, // Float X Coordinate
            this._numYPosition, // Float Y Coordinate
            this._numWidth * 2, // Float Width
            this._numWidth      // Float height
        );
    }

    void setYPosition(float numYPosition) {
        int numStart = 0;
        int numEnd   = 255;

        if (numYPosition > 255) {
            numEnd = 1023;
        }

        this._numYPosition = (int) map(numYPosition, numStart, numEnd, this._numYCoord, this._numMaxYCoord);
    }

    /**
     * A function that returns true or fals base on whether
     * two circles intersect. If distance is less than the sum
     * radii the circles touch
     */
    public boolean intersect (objeto o) {
        float distance = dist(this._numXPosition, this._numYPosition, o.xArcReactor, o.yArcReactor);
        if (distance < this._numWidth + o.r) {  //comparala con la suma de los radios
            return true;
        }
        return false;
    }

    public void update() {
        this._numYPosition += (this._numSpeed / 5);
        this._numSpeed = this._numSpeed + Character.GRAVITY;

        if (this._numYPosition <= this._numYCoord) {
            this._numYPosition = this._numYCoord;
            this._numSpeed = 10;
        }

        if (this._numYPosition >= this._numMaxYCoord) {
            this._numYPosition = this._numMaxYCoord;
            this._numSpeed = 10;
        }

        /*
        if(keyPressed == true) {
            if(keyCode == UP) {
                _numHeight = _numHeight - this._numSpeed;
            }
        }

        if(keyCode == DOWN) {
            _numHeight += this._numSpeed;
        }

        if(_numHeight <= 0) {
            _numHeight = 0;
        }
        */
    }
}