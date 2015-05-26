class ScreenMenu extends Screen {
    // MenuItems
    MenuItem _menuItemAgentCreate;
    MenuItem _menuItemAgentView;
    MenuItem _menuItemPractice;
    MenuItem _menuItemTraining;
    MenuItem _menuItemStatistics;

    public ScreenMenu(String strTitle) {
        super(strTitle);
        this._menuItemAgentCreate = new MenuItem("Crear Agente",  Screen.SCREEN_AGENT_CREATE, 0);
        this._menuItemAgentView   = new MenuItem("Ver Agentes",   Screen.SCREEN_AGENT_VIEW,   1);
        this._menuItemPractice    = new MenuItem("Practica",      Screen.SCREEN_PRACTICE,     2);
        this._menuItemTraining    = new MenuItem("Entrenamiento", Screen.SCREEN_TRAINING,     3);
        this._menuItemStatistics  = new MenuItem("Estadisticas",  Screen.SCREEN_STATISTICS,   4);
    }

    protected void render() {
        this._menuItemAgentCreate.display();
        this._menuItemAgentView.display();
        this._menuItemPractice.display();
        this._menuItemTraining.display();
        this._menuItemStatistics.display();
    }
}