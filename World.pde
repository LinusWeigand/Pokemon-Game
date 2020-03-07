import java.io.*;

class World {

  PImage[] jotho;
  Player player;
  Sign sign;
  WildBattle wildBattle;

  int x, y;
  int pastX, pastY;
  int playerx, playery;
  int speed;
  int mapX, mapY;
  int frame;
  int moment;

  boolean moveUp, moveDown, moveLeft, moveRight;
  boolean disabled;
  boolean wildbattle;

  char[][] map;
  String location;


  World() {
    jotho = new PImage[2];
    player = new Player(this, 88*7, 88*5);
    sign = new Sign(this);
    wildBattle = new WildBattle(this);

    speed = 4;
    frame = 0;

    location = "Jotho";
    disabled = false;
    wildbattle = false;
    moveUp = false;
    moveDown = false;
    moveLeft = false;
    moveRight = false;

    loadMap(location);
  }

  void draw() {
    
    if(!wildbattle){
    frame++;

    if (!disabled) {

      if (moveUp  && isPassable(playerx, playery-1)) {
        moveUp();
      } else {
        moveUp = false;
      }
      if (moveDown && isPassable(playerx, playery+1)) {
        moveDown();
      } else {
        moveDown = false;
      }
      if (moveLeft && isPassable(playerx-1, playery)) {
        moveLeft();
      } else {
        moveLeft = false;
      }
      if (moveRight && isPassable(playerx+1, playery)) {
        moveRight();
      } else {
        moveRight = false;
      }
    }
    image(jotho[0], x, y);
    player.draw();
    image(jotho[1], x, y);
    sign.draw();
    waitForImageToMove();

//println(disabled);
    //println("isMoving: " + "   disabled: " + disabled + "   moveUp: " + moveUp + "   moveDown: " + moveDown + "   moveRight: " + moveRight + "   moveLeft: " + moveLeft + "   playerx: "
    // + playerx + "   playery: " + playery + "   x: " + x + "   y: " + y + "   pastX: " + pastX + "   pastY: " + pastY + "   imgIndex: " + player.getImgIndex());
    }else{
     wildBattle.draw(); 
    }
  }

  void keyPressed() {

    player.keyPressed();

    switch(keyCode) {

    case UP:
      if (!moveDown && !moveLeft && !moveRight) {
        moveUp = true;
        moveDown = false;
        moveLeft = false;
        moveRight = false;
        player.resetFrame();
        println("lol");
      }
      break;

    case DOWN:
      if (!moveUp && !moveLeft && !moveRight) {
        moveDown = true;
        moveUp = false;
        moveLeft = false;
        moveRight = false;
        player.resetFrame();
      }
      break;

    case LEFT:
      if (!moveUp && !moveDown && !moveRight) {
        moveLeft = true;
        moveUp = false;
        moveDown = false;
        moveRight = false;
        player.resetFrame();
      }
      break;

    case RIGHT:
      if (!moveUp && !moveDown && !moveRight) {
        moveRight = true;
        moveLeft = false;
        moveUp = false;
        moveDown = false;
        player.resetFrame();
      }
      break;

    case ENTER:
      readSign();
      break;
    }
  }

  void keyReleased() {

    switch(keyCode) {

    case UP:
      break;

    case DOWN:
      break;

    case LEFT:
      break;

    case RIGHT:
      break;
    }
  }

  void moveUp() {

    if (y >= pastY + 88) {
      moveUp = false;
      playery--;
      pastY = y;
      checkForEvent();
    } else {
      y += speed;
    }
  }
  void moveDown() {
    if (y <= pastY - 88) {
      moveDown = false;
      playery++;
      pastY = y;
      checkForEvent();
    } else {
      y -= speed;
    }
  }
  void moveLeft() {
    if (x >= pastX + 88) {
      moveLeft = false;
      playerx--;
      pastX = x;
      checkForEvent();
    } else {
      x += speed;
    }
  }
  void moveRight() {
    if (x <= pastX - 88) {
      moveRight = false;
      playerx++;
      pastX = x;
      checkForEvent();
    } else {
      x -= speed;
    }
  }

  void waitForImageToMove() {
    if (jotho[0].width == 0 || jotho[1].width == 0) {
      disabled = true;
    } else {
      disabled = false;
    }
  }

  void loadMap(String mapName) {

    for (int i = 0; i < jotho.length; i++) {
      jotho[i] = requestImage("data\\map\\" + mapName + i+ ".png");
    }
    try {
      BufferedReader bufReader = new BufferedReader(new FileReader(dataPath(mapName + ".txt")));
      //Erste Zeile
      String[] line1 = bufReader.readLine().split(" ");
      mapX = parseInt(line1[0]);
      mapY = parseInt(line1[1]);
      map = new char[mapX][mapY];
      //Zweite Zeile
      String[] line2 = bufReader.readLine().split(" ");
      playerx = parseInt(line2[0]);
      playery = parseInt(line2[1]);
      x = -(playerx - 7)*88;
      y = -(playery - 5)*88;
      pastY = y;
      pastX = x;
      //Andere Zeilen
      String[] lines = new String[48];
      for (int i = 0; i < mapY; i++) {
        lines[i] = bufReader.readLine();
        for (int n = 0; n < mapX; n++) {
          map[n][i] = lines[i].charAt(n);
        }
      }
      bufReader.close();
    }
    catch(IOException e) {
      print(e);
    }
    location = mapName;
  }

  void checkForDoor() {
    if (isOnDoor(playerx, playery)) {
      switch(location) {

      case "Jotho":
        loadMap("Home");
        break;

      case "Home":
        loadMap("Jotho");
        break;
      }
    }
  }

  void readSign() {
    if (map[playerx][playery - 1] == 'S' && player.getDirection() == Direction.up) {
      if(sign.getVisible()){
        sign.visible(false);
        disabled = true;
      }else{
       sign.visible(true); 
       disabled = true;
      }
    }
  }
  
  void checkForEvent(){
    checkForDoor();
    checkForBattle();
  }
  
  void checkForBattle(){
   int random = (int)random(1,5);
   //println(random);
   if(isOnGrass(playerx, playery) && random == 4){
     wildbattle = true;
   }
  }
  
  

  boolean isPassable(int x, int y) {
    if (x >=0 && x < mapX && y >= 0 && y < mapY) {
      return (map[x][y] == '#' || map[x][y] == 'D' || map[x][y] == 'f');
    } else {
      return false;
    }
  }
  
  boolean isOnGrass(int x, int y){
    if (x >= 0 && x < mapX && y >= 0 && y < mapY) {
      return(map[x][y] == 'f');
    } else {
      return false;
    }
  }

  boolean isOnDoor(int x, int y) {
    if (x >= 0 && x < mapX && y >= 0 && y < mapY) {
      return(map[x][y] == 'D');
    } else {
      return false;
    }
  }

  boolean getDisabled() {
    return disabled;
  }

  boolean isMoving() {
    return(moveUp || moveDown || moveLeft || moveRight);
  }

  boolean getMoveUp() {
    return moveUp;
  }

  boolean getMoveDown() {
    return moveDown;
  }
  boolean getMoveLeft() {
    return moveLeft;
  }
  boolean getMoveRight() {
    return moveRight;
  }
}
