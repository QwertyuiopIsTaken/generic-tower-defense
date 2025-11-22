class TowerSet {
  void roundSetup() {
    tower = new ArrayList<Tower>(maxTowers);
  }
  
  void showTowers() {
    for (int i = 0; i < tower.size(); i++) {
      tower.get(i).target();
    }
  }
  
  int giveValue(int towerSelection, int mode) {
    int value;
    if (towerSelection == 1) {
      value = 250;
    } else if (towerSelection == 2) {
      value = 450;
    } else if (towerSelection == 3) {
      value = 850;
    } else if (towerSelection == 4) {
      value = 800;
    } else if (towerSelection == 5) {
      value = 1500;
    } else {
      value = 2000;
    }
    if (mode == 1) { // Selling mode
      value = value / 2;
    }
    return value;
  }
  
  float giveRange(int towerSelection) {
    int range;
    if (towerSelection == 1) {
      range = 10;
    } else if (towerSelection == 2) {
      range = 26;
    } else if (towerSelection == 3) {
      range = 12;
    } else if (towerSelection == 4) {
      range = 8;
    } else if (towerSelection == 5) {
      range = 32;
    } else {
      range = 25;
    }
    return(8 / 26.0 * tileSize * range);
  }
  
  float giveDamage(int towerSelection) {
    float dmg;
    if (towerSelection == 1) {
      dmg = 0.05;
    } else if (towerSelection == 2) {
      dmg = 0.03;
    } else if (towerSelection == 3) {
      dmg = 0.08;
    } else if (towerSelection == 4) {
      dmg = 0.1;
    } else if (towerSelection == 5) {
      dmg = 0.08;
    } else {
      dmg = 0.1;
    }
    return(dmg);
  }
}
