class GUI {
  float startingBaseHealth;
  int centerX;
  int towerSelection;
  float row1Y;
  float row2Y;
  float row3Y;
  float column1X;
  float column2X;
  
  GUI() {
    startingBaseHealth = baseHealth;
    centerX = (width - tileSize*5 + width) / 2;
    row1Y = 2*height/20.6 + height/24 + 10*11;
    row2Y = 2*height/20.6 + height/24 + 10*11 + tileSize*3/2 + 10;
    row3Y = 2*height/20.6 + height/24 + 10*11 + tileSize*3/2*2 + 10*2;
    column1X = centerX - tileSize - tileSize*3/4;
    column2X = centerX + tileSize - tileSize*3/4;
  }
  
  void display() {
    strokeWeight(0);
    fill(0, 0, 0, 140);
    rect(centerX - tileSize*5/2 - 1, 0, width, height);
    fill(255);
    textAlign(CENTER, TOP);
    textFont(Trebuchet);
    textSize(height / 20.6); // 35
    text("Wave " + wave, centerX, 10);
    healthBar();
    textAlign(CENTER, TOP);
    textSize(height / 20.6);
    text("Towers:", centerX, height/20.6 + height/24 + 10*6);
    textSize(height / 28.8); // 25
    text(numTowers + "/" + maxTowers, centerX, 2*height/20.6 + height/24 + 10*6);
    towerColumn();
    fill(0, 255, 0);
    textAlign(RIGHT, BOTTOM);
    textSize( height / 24); // 30
    text("Money: " + money, width, height);
  }
  
  void healthBar() {
    fill(#191617);
    rect(centerX - tileSize*5/2 + 10, height/20.6 + 10*3, tileSize*5 - 20, height / 24);
    float partLost = (startingBaseHealth - baseHealth) / startingBaseHealth * (tileSize*5 - 20);
    fill(0, 255, 0);
    rect(centerX - tileSize*5/2 + 10, height/20.6 + 10*3, tileSize*5 - 20 - partLost, height / 24);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(height / 24); // 20
    text(baseHealth + "/" + int(startingBaseHealth), centerX, height/20.6 + 10*3 + (height/24)/2);
  }
  
  PImage matchImg(int towerSelection) {
    PImage towerImg;
    if (towerSelection == 1) {
      towerImg = tower1;
    } else if (towerSelection == 2) {
      towerImg = tower2;
    } else if (towerSelection == 3) {
      towerImg = tower3;
    } else if (towerSelection == 4) {
      towerImg = tower4;
    } else if (towerSelection == 5) {
      towerImg = tower5;
    } else {
      towerImg = tower6;
    }
    return towerImg;
  }
  
  void towerColumn() {
    int count = 1;
    for (int i = 0; i < 3; i++) {
      for (int j = -1; j <= 1; j+=2) {
        float y = 2*height/20.6 + height/24 + 10*11 + tileSize*3/2*i + 10*i;
        imageMode(CORNER);
        image(matchImg(count), centerX + j*tileSize - tileSize*3/4, y, tileSize*3/2, tileSize*3/2);
        fill(50);
        textAlign(CENTER, BOTTOM);
        textSize(height / 48); // 15
        text("$" + towerSet.giveValue(count, 0), centerX + j*tileSize, y + tileSize*3/2);
        fill(255);
        textAlign(LEFT, TOP);
        text(count, centerX + j*tileSize - tileSize*3/4, y);
        count++;
      }
    }
  }
  
  void click() {
    if ((mouseY > row1Y && mouseY < row1Y + tileSize*3/2) && (mouseX > column1X && mouseX < column1X + tileSize*3/2)) {
      towerSelection = 1;
    } else if ((mouseY > row1Y && mouseY < row1Y + tileSize*3/2) && (mouseX > column2X && mouseX < column2X + tileSize*3/2)) {
      towerSelection = 2;
    } else if ((mouseY > row2Y && mouseY < row2Y + tileSize*3/2) && (mouseX > column1X && mouseX < column1X + tileSize*3/2)) {
      towerSelection = 3;
    } else if ((mouseY > row2Y && mouseY < row2Y + tileSize*3/2) && (mouseX > column2X && mouseX < column2X + tileSize*3/2)) {
      towerSelection = 4;
    } else if ((mouseY > row3Y && mouseY < row3Y + tileSize*3/2) && (mouseX > column1X && mouseX < column1X + tileSize*3/2)) {
      towerSelection = 5;
    } else if ((mouseY > row3Y && mouseY < row3Y + tileSize*3/2) && (mouseX > column2X && mouseX < column2X + tileSize*3/2)) {
      towerSelection = 6;
    } else {
      return;
    }
    selectedTower = new Tower(towerSelection, mouseX, mouseY);
    selectedTower.placement();
    selectingTower = true;
  }
  
  void selectText() {
    textAlign(LEFT, BOTTOM);
    fill(255);
    textFont(Corbel);
    textSize(height / 24);
    text("Press X to end selection", 0, height);
  }
}
