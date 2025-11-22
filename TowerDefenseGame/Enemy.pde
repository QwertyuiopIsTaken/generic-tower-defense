class Enemy {
  int x;
  int y;
  float rot;
  int enemyNum;
  PImage enemyImg;
  int passedPathNum = 0;
  Tile walkTo;
  boolean horizontal = true;
  float hitpoint;
  float startingHitpoint;
  
  Enemy(int _enemyNum, int _x, int _y) {
    x = _x;
    y = _y;
    rot = 0;
    enemyNum = _enemyNum;
    hitpoint = enemySet.giveHitpoint(enemyNum);
    startingHitpoint = hitpoint;
    matchImg();
  }
  
  void takeDamage(float dmg) {
    hitpoint -= dmg;
  }
  
  void move() {
    int closestPathNum = pathAmount + 1;
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        Tile THEtile = grid[i][j];
        if ((THEtile.endpoint || THEtile.pathNum == pathAmount) && THEtile.pathNum > passedPathNum && closestPathNum > THEtile.pathNum) {
          closestPathNum = THEtile.pathNum;
          walkTo = THEtile;
        }
      }
    }
    
    int xDirection = 0;
    int yDirection = 0;
    if (horizontal) {
      if (walkTo.x + tileSize/2 > x) {
        xDirection = 1;
        yDirection = 0;
      } else {
        xDirection = -1;
        yDirection = 0;
      }
    } else {
      if (walkTo.y + tileSize/2 > y) {
        yDirection = 1;
        xDirection = 0;
      } else {
        yDirection = -1;
        xDirection = 0;
      }
    }
    x += enemySet.giveSpeed(enemyNum) * xDirection;
    y += enemySet.giveSpeed(enemyNum) * yDirection;
    
    imageMode(CENTER);
    if (xDirection * (walkTo.x + tileSize/2) < xDirection * x) {
      x = walkTo.x + tileSize / 2;
      rotateImg();
      horizontal = false;
      passedPathNum = closestPathNum;
    } else if (yDirection * (walkTo.y + tileSize/2) < yDirection * y) {
      y = walkTo.y + tileSize / 2;
      rotateImg();
      horizontal = true;
      passedPathNum = closestPathNum;
    }
    if (passedPathNum == pathAmount) {
      hitpoint = 0;
      baseHealth -= 10;
      if (enemyNum == 6) {
        baseHealth -= 100;
      }
      if (baseHealth <= 0) {
        gameState = 2;
        baseHealth = 0;
      }
      checkGameState();
    }
    pushMatrix();
    translate(x, y);
    rotate(rot);
    image(enemyImg, 0, 0, enemySet.giveSize(enemyNum), enemySet.giveSize(enemyNum));
    popMatrix();
    //println(closestPathNum + " " + passedPathNum);
    textSize(16);
    textAlign(CENTER);
    fill(0);
    text((int)Math.ceil(hitpoint * 10) + "/" + (int)Math.ceil(startingHitpoint * 10), x, y);
  }
  
  void rotateImg() {
    int state = walkTo.state;
    if (horizontal) {
      if (state == path_5 || state == path_3) {
        rot = radians(-90) + rot;
      } else {
        rot = radians(90) + rot;
      }
    } else {
      if (state == path_4 || state == path_6) {
        rot = radians(-90) + rot;
      } else {
        rot = radians(90) + rot;
      }
    }
  }
  
  void matchImg() {
    if (enemyNum == 1) {
      enemyImg = rifleman;
    } else if (enemyNum == 2) {
      enemyImg = grunt;
    } else if (enemyNum == 3) {
      enemyImg = apc;
    } else if (enemyNum == 4) {
      enemyImg = tank;
    } else if (enemyNum == 5) {
      enemyImg = bomber;
    } else {
      enemyImg = terminator;
    }
  }
}
