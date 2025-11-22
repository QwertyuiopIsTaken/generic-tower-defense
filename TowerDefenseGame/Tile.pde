class Tile {
  int x;
  int y;
  int state;
  int pathNum;
  int randRot;
  PImage img;
  boolean endpoint = false;

  Tile(int _x, int _y) {
    x = _x;
    y = _y;
    state = grass;
    pathNum = 0;
    randRot = int(random(0, 5));
    
    int rand = int(random(1, 8));
    if (rand != 1) {
      img = grass1;
    } else {
      rand = int(random(2, 5));
      if (rand == 2) {
        img = grass2;
      } else if (rand == 3) {
        img = grass3;
      } else {
        img = grass4;
      }
    }
  }

  void display() {
    if (state == grass) {
      imageMode(CENTER);
      pushMatrix();
      translate(x + tileSize / 2, y + tileSize / 2);
      rotate(radians(randRot * 90));
      image(img, 0, 0, tileSize + 1, tileSize + 1);
      popMatrix();
    } else {
      imageMode(CENTER);
      pushMatrix();
      translate(x + tileSize / 2, y + tileSize / 2);
      image(img, 0, 0, tileSize + 1, tileSize + 1);
      popMatrix();
    }
  }

  void pathConvert(int newState) {
    state = newState;
    if (newState == path_1) {
      img = path1;
    } else if (newState == path_2) {
      img = path2;
    } else if (newState == path_3) {
      img = path3;
      endpoint = true;
    } else if (newState == path_4) {
      img = path4;
      endpoint = true;
    } else if (newState == path_5) {
      img = path5;
      endpoint = true;
    } else {
      img = path6;
      endpoint = true;
    }
    pathAmount++;
    pathNum = pathAmount;
  }
}
