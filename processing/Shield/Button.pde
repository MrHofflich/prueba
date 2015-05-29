class Button {
  private String strShield = "S.H.I.E.L.D.";
  private PFont objKelsonFont;
  private PShape objLogo;
  private float xcoord, ycoord, height, width;

  public Button(float xcoord, float ycoord, float width, float height) {
    this.xcoord   = xcoord;
    this.ycoord   = ycoord;
    this.height   = height;
    this.width    = width;

    this.objLogo       = loadShape("agents_of_s_h_i_e_l_d_logo_vector_by_dachterm7622-d7jgi14.svg");
    this.objKelsonFont = loadFont("Kartika-48.vlw");
  }


  public void boton1() {
    //Circulo principal
    noFill();
    stroke(0, 184, 182, 80);
    strokeWeight(this.width / 15);
    ellipse(this.xcoord, this.ycoord, this.width - 15, this.width - 15);

    //Arco exterior
    noFill();
    strokeCap(SQUARE);
    strokeWeight(this.width / 20);
    stroke(0, 184, 182, 150);
    arc(this.xcoord, this.ycoord, this.width + this.width / 12, this.width + this.width / 12, radians(this.height + 110), radians(this.height + 300));

    //Arco interior
    noFill();
    strokeCap(SQUARE);
    strokeWeight(this.width / 20);
    stroke(0, 204, 182, 200);
    arc(this.xcoord, this.ycoord, this.width - this.width / 6, this.width - this.width / 6, radians(-this.height - 100), radians(-this.height - 20));

    //IMAGEN
    this.objLogo.disableStyle();
    fill(0, 184, 182, 150);
    shape(this.objLogo, this.xcoord - this.width / 2.3, this.ycoord - this.width / 2.5, this.width - this.width / 3.5, this.width - this.width / 2.5);

    // TEXTO
    fill(0, 184, 182, 150);
    textFont(this.objKelsonFont, this.width / 6);
    text(this.strShield, this.xcoord - this.width / 2.5, this.ycoord + this.width / 1.4);
  }


  public void interact1() {
    this.height = this.height + 2;

    if (dist(this.xcoord, this.ycoord, mouseX, mouseY) <= this.width / 2 && mousePressed) {
      numState = Screen.SCREEN_MENU;
      // serialPort.write(sentData);
    }
  }
}