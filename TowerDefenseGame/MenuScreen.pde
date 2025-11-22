class MenuScreen {
  int centerX;
  float x;
  float y;
  float easyY;
  float hardY;
  int difficultyLevel;

  MenuScreen() {
    centerX = width / 2;
    x = centerX - buttonSizeX/2;
    y = height / 2 - buttonSizeY/2;
    hardY = y + buttonSizeY * 3/2;
    easyY = y - buttonSizeY * 3/2;

    difficultyLevel = 1;
  }

  void display() {
    // Background
    imageMode(CENTER);
    image(coolBackground, width / 2, height / 2, width, height);
    
    // Buttons
    strokeWeight(2);
    fill(YELLOW);
    rect(x, y, buttonSizeX, buttonSizeY); // Medium mode
    fill(RED);
    rect(x, hardY, buttonSizeX, buttonSizeY); // Hard Mode
    fill(GREEN);
    rect(x, easyY, buttonSizeX, buttonSizeY); // Easy Mode

    fill(0);
    textAlign(CENTER, CENTER);
    textFont(Corbel);
    textSize(height / 24); // 30
    text("Easy", centerX, y - buttonSizeY * 3/2 + buttonSizeY/2);
    text("Medium", centerX, y + buttonSizeY / 2);
    text("Hard", centerX, y + buttonSizeY * 3/2 + buttonSizeY/2);
    
    // Banner
    strokeWeight(0);
    fill(30, 30, 30, 150);
    rect(0, y - buttonSizeY * 3.5, width, buttonSizeY);
    textSize(height / 18); // 40
    fill(255);
    textFont(Trebuchet);
    text("Choose your difficulty", centerX, y - buttonSizeY * 3.5 + buttonSizeY/2);
    
    // Game title
    fill(darkRED);
    textFont(SegoeBold);
    textSize(height / 10.3); // 70
    String line1 = "generic tower";
    String line2 = "defense game.";
    text(line1 + "\n" + line2, centerX, height / 1.2 - buttonSizeY/4);
  }

  void click() {
    if ((mouseY > easyY && mouseY < easyY + buttonSizeY) && (mouseX > centerX - buttonSizeX/2 && mouseX < centerX + buttonSizeX/2)) {
      difficultyLevel = 1;
    } else if ((mouseY > hardY && mouseY < hardY + buttonSizeY) && (mouseX > centerX - buttonSizeX/2 && mouseX < centerX + buttonSizeX/2)) {
      difficultyLevel = 3;
    } else if ((mouseY > y && mouseY < y + buttonSizeY) && (mouseX > centerX - buttonSizeX/2 && mouseX < centerX + buttonSizeX/2)) {
      difficultyLevel = 2;
    } else {
      return;
    }
    decided();
  }

  void decided() {
    if (difficultyLevel == 1) {
      // Use default values
    } else if (difficultyLevel == 2) {
      income *= 0.75;
      reward *= 0.5;
    } else {
      income *= 0.5;
      reward = 0;
    }
    
    menu = false;
    /*
    menuMusic.pause();
    clickEffect.play();
    backgroundMusic1.play();
    backgroundMusic1.loop();
    */
    roundSetup();
  }
  
  void roundSetup() {
    grid = new Tile[width / tileSize][height / tileSize];
    map = new Map();
    map.setupTiles();
    towerSet = new TowerSet();
    towerSet.roundSetup();
    enemySet = new EnemySet();
    enemySet.roundSetup();
  }
}
