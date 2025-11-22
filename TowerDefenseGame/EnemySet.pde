class EnemySet {
  boolean spawn = true;
  int waveDuration = 18000;
  int wavePause = 2000;
  boolean bossSpawned = false;
  
  Wait wait1; // Starts a new wave
  Wait wait2; // Spawns enemy
  Wait wait3; // Spawns nothing (pauses between waves)
  
  void roundSetup() {
    enemy = new ArrayList<Enemy>();
    wait1 = new Wait(waveDuration, this, 1);
    wait2 = new Wait(wavePause, this, 2);
  }
  
  void roundEnd() {
    money += income;
    wait3 = new Wait(5000, this, 3);
    spawn = false;
  }
  
  void removeDead() {
    for (int i = 0; i < enemy.size(); i++) {
      if (enemy.get(i).hitpoint <= 0) {
        if (enemy.get(i).enemyNum == 6) {
          gameState = 1;
          checkGameState();
        }
        enemy.remove(i);
        money += reward;
      }
    }
  }
  
  void drawLoop() {
    wait1.looping();
    wait2.looping();
    if (wait3 != null) {
      wait3.looping();
    }
    finalWave();
  }
  
  void finalWave() {
    if (wave == 6 && !bossSpawned) {
      enemy.add(new Enemy(6, -giveSize(6)/2, startingTileY + tileSize/2));
      bossSpawned = true;
    }
  }
  void sendEnemy() {
    if (spawn) {
      if (wave == 1) {
        enemy.add(new Enemy(1, -giveSize(1)/2, startingTileY + tileSize/2));
      } else if (wave == 2) {
        int rand = int(random(0, 2));
        if (rand == 1) {
          enemy.add(new Enemy(2, -giveSize(2)/2, startingTileY + tileSize/2));
        } else {
          enemy.add(new Enemy(1, -giveSize(1)/2, startingTileY + tileSize/2));
        }
      } else if (wave == 3) {
          int rand = int(random(1, 6));
          if (rand == 1) {
            enemy.add(new Enemy(3, -giveSize(3)/2, startingTileY + tileSize/2));
          } else {
            rand = int(random(0, 3));
            if (rand == 1) {
              enemy.add(new Enemy(2, -giveSize(2)/2, startingTileY + tileSize/2));
            } else {
              enemy.add(new Enemy(1, -giveSize(1)/2, startingTileY + tileSize/2));
            }
          }
      } else if (wave == 4) {
          int rand = int(random(1, 8));
          if (rand == 1) {
            enemy.add(new Enemy(4, -giveSize(4)/2, startingTileY + tileSize/2));
          } else {
            rand = int(random(0, 3));
            if (rand == 1) {
              enemy.add(new Enemy(2, -giveSize(2)/2, startingTileY + tileSize/2));
            } else {
              enemy.add(new Enemy(1, -giveSize(1)/2, startingTileY + tileSize/2));
            }
          }
      } else if (wave == 5) {
          int rand = int(random(1, 8));
          if (rand == 1) {
            enemy.add(new Enemy(3, -giveSize(3)/2, startingTileY + tileSize/2));
          } else if (rand == 2) {
            enemy.add(new Enemy(2, -giveSize(2)/2, startingTileY + tileSize/2));
          } else {
            rand = int(random(0, 3));
            if (rand == 1) {
              enemy.add(new Enemy(5, -giveSize(5)/2, startingTileY + tileSize/2));
            } else {
              enemy.add(new Enemy(2, -giveSize(2)/2, startingTileY + tileSize/2));
            }
          }
      }
    }
  }
  
  void showEnemies() {
    removeDead();
    for (int i = 0; i < enemy.size(); i++) {
      enemy.get(i).move();
    }
  }
  
  int giveSize(int enemyNum) {
    float size;
    if (enemyNum == 1) {
      size = tileSize;
    } else if (enemyNum == 2) {
      size = tileSize;
    } else if (enemyNum == 3) {
      size = tileSize * 1.8;
    } else if (enemyNum == 4) {
      size = tileSize * 2.4;
    } else if (enemyNum == 5) {
      size = tileSize * 1.5;
    } else {
      size = tileSize * 2.5;
    }
    return(int(size));
  }
  
  int giveHitpoint(int enemyNum) {
    int hp;
    if (enemyNum == 1) {
      hp = 5;
    } else if (enemyNum == 2) {
      hp = 12;
    } else if (enemyNum == 3) {
      hp = 60;
    } else if (enemyNum == 4) {
      hp = 120;
    } else if (enemyNum == 5) {
      hp = 40;
    } else {
      hp = 450;
    }
    return(hp);
  }
  
  int giveSpeed(int enemyNum) {
    int speed;
    if (enemyNum == 1) {
      speed = 3;
    } else if (enemyNum == 2) {
      speed = 2;
    } else if (enemyNum == 3) {
      speed = 2;
    } else if (enemyNum == 4) {
      speed = 1;
    } else if (enemyNum == 5) {
      speed = 5;
    } else {
      speed = 1;
    }
    return(speed);
  }
}
