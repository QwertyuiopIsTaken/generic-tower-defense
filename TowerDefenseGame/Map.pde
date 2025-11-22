class Map {
  int horizontal = 0;
  
  void setupTiles() {
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        grid[i][j] = new Tile(i * tileSize, j * tileSize);
      }
    }
    // The Paths
    if (menuScreen.difficultyLevel != 3) {
      defaultMap();
    } else {
      hardMap();
    }
  }
  
  void showTiles() {
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        grid[i][j].display();
      }
    }
    if (menuScreen.difficultyLevel != 3) {
      imageMode(CENTER);
      image(mountain1, height/2.9, height/2.1, width/9.7, height/4.8);
      image(mountain2, height/1.7, height/2, height/5.6, height/5);
      image(mountain3, height/0.9, height/2.5, height/7.6, height/8.5);
    }
  }
  
  void straightPath(int type, int x, int y, int chain, int turn, int direction) {
    if (type == horizontal) {
      for (int i = x; i * direction < x * direction + chain; i += direction) {
        grid[i][y].pathConvert(path_1);
      }
      
      if (turn == 3) {
        grid[x + chain * direction][y].pathConvert(path_3);
      } else if (turn == 4) {
        grid[x + chain * direction][y].pathConvert(path_4);
      } else if (turn == 5) {
        grid[x + chain * direction][y].pathConvert(path_5);
      } else if (turn == 6) {
        grid[x + chain * direction][y].pathConvert(path_6);
      }
    } else {
      for (int i = y; i * direction < y * direction + chain; i += direction) {
        grid[x][i].pathConvert(path_2);
      }
      
      if (turn == 3) {
        grid[x][y + chain * direction].pathConvert(path_3);
      } else if (turn == 4) {
        grid[x][y + chain * direction].pathConvert(path_4);
      } else if (turn == 5) {
        grid[x][y + chain * direction].pathConvert(path_5);
      } else if (turn == 6) {
        grid[x][y + chain * direction].pathConvert(path_6);
      }
    }
  }
  
  void defaultMap() {
    startingTileY = tileSize * 6;
    straightPath(0, 0, 6, 3, 5, 1);
    straightPath(1, 3, 5, 3, 3, -1);
    straightPath(0, 4, 2, 3, 4, 1);
    straightPath(1, 7, 3, 7, 5, 1);
    straightPath(0, 6, 10, 5, 3, -1);
    straightPath(1, 1, 11, 2, 6, 1);
    straightPath(0, 2, 13, 9, 5, 1);
    straightPath(1, 11, 12, 11, 3, -1);
    straightPath(0, 12, 1, 4, 4, 1);
    straightPath(1, 16, 2, 2, 5, 1);
    straightPath(0, 15, 4, 1, 3, -1);
    straightPath(1, 14, 5, 5, 6, 1);
    straightPath(0, 15, 10, 4, 5, 1);
    straightPath(1, 19, 9, 3, 3, -1);
    straightPath(0, 20, 6, 3, 0, 1);
  }
  
  void hardMap() {
    startingTileY = tileSize * 7;
    straightPath(0, 0, 7, 23, 0, 1);
  }
}
