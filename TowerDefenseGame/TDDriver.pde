// GAME SETTINGS
int baseHealth = 50;
int income = 500; // money earned per round
int reward = 120; // money earned each time an enemy dies
int maxTowers = 10;
int money = 600;

boolean menu = true;

// Sizes
int buttonSizeX;
int buttonSizeY;
float towerSizeX;
float towerSizeY;
int tileSize;

// Colors
color GREEN = #48bb78;
color BLUE = #4299e1;
color ORANGE = #ed8936;
color RED = #f56565;
color darkBLUE = #667eea;
color YELLOW = #ecc94b;
color PINK = #e500a4;
color CYAN = #00F5EF;
color yellowGREEN = #7EF007;
color brightPINK = #ff006e;
color darkRED = #e62314;

color backgroundColor = 15;
color textColor = 255;
color backgroundColor2 = 30;
color textColor2 = 220;

// Classes
MenuScreen menuScreen;
TowerSet towerSet;
ArrayList<Tower> tower;
EnemySet enemySet;
ArrayList<Enemy> enemy;
Map map;
Tile[][] grid;
GUI gui;

// Images
PImage coolBackground;
PImage grass1; // plain grass
PImage grass2; // bush
PImage grass3; // rocks
PImage grass4; // plants
PImage path1; // horizontal
PImage path2; // vertical
PImage path3; // left down
PImage path4; // right down
PImage path5; // right up
PImage path6; // left up
PImage mountain1;
PImage mountain2;
PImage mountain3;
PImage tower1;
PImage tower2;
PImage tower3;
PImage tower4;
PImage tower5;
PImage tower6;
PImage rifleman;
PImage grunt;
PImage apc;
PImage tank;
PImage bomber;
PImage terminator;

// Sounds
/*
import ddf.minim.*;
Minim Sound;
AudioPlayer menuMusic;
AudioPlayer backgroundMusic1;
AudioPlayer clickEffect;
AudioPlayer placeDown;
*/

// Fonts
PFont Corbel;
PFont SegoeBold;
PFont Trebuchet;
PFont Impact;

// Game Variables
int wave = 1;
int numTowers = 0;
int gameState = 0; // 0 in progress, 1 victory, 2 lose

// State Variables
int grass = 1;
int path_1 = 2;
int path_2 = 3;
int path_3 = 4;
int path_4 = 5;
int path_5 = 6;
int path_6 = 7;

// Other Variables
Tower selectedTower;
boolean selectingTower = false;
int startingTileY;
int pathAmount = 0;

void setup() {
  background(255);
  size(1260, 720);
  frameRate(30);
  buttonSizeX = width / 2;
  buttonSizeY = height / 12;
  towerSizeX = height / (64/3);
  towerSizeY = height / 16;
  tileSize = height / 16;
  
  coolBackground = loadImage("CoolBackground.png");
  grass1 = loadImage("Grass1.png");
  grass2 = loadImage("Grass2.png");
  grass3 = loadImage("Grass3.png");
  grass4 = loadImage("Grass4.png");
  path1 = loadImage("Path1.png");
  path2 = loadImage("Path2.png");
  path3 = loadImage("Path3.png");
  path4 = loadImage("Path4.png");
  path5 = loadImage("Path5.png");
  path6 = loadImage("Path6.png");
  mountain1 = loadImage("Mountain1.png");
  mountain2 = loadImage("Mountain2.png");
  mountain3 = loadImage("Mountain3.png");
  tower1 = loadImage("Tower1.png");
  tower2 = loadImage("Tower2.png");
  tower3 = loadImage("Tower3.png");
  tower4 = loadImage("Tower4.png");
  tower5 = loadImage("Tower5.png");
  tower6 = loadImage("Tower6.png");
  rifleman = loadImage("Rifleman.png");
  grunt = loadImage("Grunt.png");
  apc = loadImage("APC.png");
  tank = loadImage("Tank.png");
  bomber = loadImage("Bomber.png");
  terminator = loadImage("Terminator.png");
  
  SegoeBold = createFont("Segoe UI Bold.ttf", 50);
  Corbel = createFont("CORBEL.TTF", 50);
  Trebuchet = createFont("trebuc.ttf", 50);
  Impact = createFont("impact.ttf", 50);
  
  /*
  Sound = new Minim(this);
  menuMusic = Sound.loadFile("menu-music.mp3");
  backgroundMusic1 = Sound.loadFile("cool-music1.wav");
  menuMusic.play();
  menuMusic.loop();
  clickEffect = Sound.loadFile("Click.mp3");
  placeDown = Sound.loadFile("PlaceDown.mp3");
  */
  
  menuScreen = new MenuScreen();
  menuScreen.display();
  gui = new GUI();
}

void draw() {
  background(255);
  if (menu) {
    menuScreen.display();
  } else if (gameState == 0) {
    map.showTiles();
    gui.display();
    towerSet.showTowers();
    enemySet.showEnemies();
    if (selectingTower) {
      selectedTower.moveToMouse();
      selectedTower.placement();
      gui.selectText();
    }
    enemySet.drawLoop();
    textSize(32);
    fill(0);
    textAlign(LEFT);
    text("Wave: " + wave + "/6", 0, height - 32);
    checkGameState();
  } else if (gameState == 1 || gameState == 2) {
    checkGameState();
  }
}

void checkGameState() {
  textFont(Impact);
  textAlign(CENTER, CENTER);
  textSize(height/12);
  fill(0);
  if (gameState == 1) {
    background(BLUE);
    text("You win!", width/2, height/2);
  } else if (gameState == 2) {
    background(RED);
    text("You lose!", width/2, height/2);
  }
  
}

void keyPressed() {
  if (key == 'x') {
    if (selectingTower) {
      selectedTower.endSelection();
    }
  }
  
  if (key == 'm') {
    money += 10000; // gives free money to the player
  }
}

void mousePressed() {
  if (menu) {
    menuScreen.click();
  } else {
    gui.click();
    if (selectingTower) {
      selectedTower.click();
    }
  }
}
