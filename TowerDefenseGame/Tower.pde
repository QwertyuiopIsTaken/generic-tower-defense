class Tower {
  int x;
  int y;
  float rot = 0;
  int towerSelection;
  PImage towerImg;
  float range;
  
  Tower(int _towerSelection, int _x, int _y) {
    x = _x;
    y = _y;
    towerSelection = _towerSelection;
    range = towerSet.giveRange(towerSelection);
    matchImg();
  }
  
  void placement() {
    imageMode(CENTER);
    strokeWeight(0);
    fill(255, 0, 0, 150);
    for (int i = 0; i < tower.size(); i++) {
      Tower otherTower = tower.get(i);
      square(otherTower.x - towerSizeY, otherTower.y - towerSizeY, towerSizeY * 2);
    }
    fill(102, 153, 204, 150);
    circle(x, y, range * 2);
    image(towerImg, x, y, towerSizeX, towerSizeY);
  }
  
  void click() {
    if (numTowers < maxTowers && validSpot()) {
      int value = towerSet.giveValue(towerSelection, 0);
      if (money >= value) {
        money -= value;
        tower.add(this);
        /*
        placeDown.rewind();
        placeDown.play();
        */
        numTowers++;
      }
      endSelection();
    }
  }
  
  void endSelection() {
    selectingTower = false;
    selectedTower = null;
  }
  
  void matchImg() {
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
  }
  
  void moveToMouse() {
    x = mouseX;
    y = mouseY;
  }
  
  boolean validSpot() {
    if (mouseX < (width - tileSize*5 + width)/2 - tileSize*5/2 - towerSizeX/2) {
      for (int i = 0; i < tower.size(); i++) {
        Tower otherTower = tower.get(i);
        if (dist(x, y, otherTower.x, otherTower.y) <= towerSizeY) {
          return false;
        }
      }
      for (int i = 0; i < grid.length; i++) {
        for (int j = 0; j < grid[i].length; j++) {
          if (grid[i][j].state != grass) {
            int xvar = x;
            int yvar = y;
            if (x < grid[i][j].x) {
              xvar = grid[i][j].x;
            } else if (x > grid[i][j].x + tileSize) {
              xvar = grid[i][j].x + tileSize;
            }
            if (y < grid[i][j].y) {
              yvar = grid[i][j].y;
            } else if (y > grid[i][j].y + tileSize) {
              yvar = grid[i][j].y + tileSize;
            }
            if (dist(x, y, xvar, yvar) <= towerSizeY/2) {
              return false;
            }
          }
        }
      }
      return true;
    }
    return false;
  }
  
  void target() {
    if(inRange() != null) {
      if (y - inRange().y > 0) {
        rot = atan((inRange().x - x) / (float(y - inRange().y)));
      } else {
        rot = PI + atan((inRange().x - x) / (float(y - inRange().y)));
      }
      inRange().takeDamage(towerSet.giveDamage(towerSelection));
    }
    imageMode(CENTER);
    pushMatrix();
    translate(x, y);
    rotate(rot);
    image(towerImg, 0, 0, towerSizeX, towerSizeY);
    popMatrix();
  }
  
  /*
  int passedPathNum = 0;
  Tile walkTo;
  */
  Enemy inRange() {
    Enemy nearestEnemy = null;
    for (int i = 0; i < enemy.size(); i++) {
      if (enemy.get(i) != null) {
        Enemy enemyVar = enemy.get(i);
        if (dist(enemyVar.x, enemyVar.y, x, y) <= range) {
          if (nearestEnemy == null) {
            nearestEnemy = enemyVar;
          }
          if (enemyVar.passedPathNum > nearestEnemy.passedPathNum) {
            if (dist(enemyVar.walkTo.x, enemyVar.walkTo.y, enemyVar.x, enemyVar.y)
            < dist(nearestEnemy.walkTo.x, nearestEnemy.walkTo.y, nearestEnemy.x, nearestEnemy.y)) {
              enemyVar = nearestEnemy;
            }
          }
        }
      }
    }
    return(nearestEnemy);
  }
}
