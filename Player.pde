class Player {

  World world;
  Direction direction;

  //PImage[] imgs;
  PImage[] left, right, up, down;
  int frame;
  int x, y;
  //int imgDirectionIndex, imgMoveIndex;
  int index;
  int indexLeft, indexRight, indexUp, indexDown;
  boolean disabled;
  boolean u, d, l, r;
  String[] pokemon;

  Player(World world, int x, int y) {
    this.world = world;
    this.x = x;
    this.y = y;

    //imgs = new PImage[16];
    left = new PImage[4];
    right = new PImage[4];
    up = new PImage[4];
    down = new PImage[4];
    
    direction = Direction.down;
    index = 0;
    frame = 0;
    d =  world.getMoveDown();
    u = world.getMoveUp();
    l = world.getMoveLeft();
    r = world.getMoveRight();

    for (int i = 0; i < 4; i++) {
      left[i] = loadImage("data\\player\\" + (i+5) + ".png");
      right[i] = loadImage("data\\player\\" + (i+9) + ".png");
      up[i] = loadImage("data\\player\\" + (i+13) + ".png");
      down[i] = loadImage("data\\player\\" + (i+1) + ".png");
    }
    readPokemon();
  }

  void draw() {
  //println(index);
    frame++;

    if (!world.getDisabled()) {

      if (world.moveUp) {
        move();
        direction = Direction.up;
      } else
        if (world.getMoveDown()) {
          move();
          direction = Direction.down;
        } else
          if (world.getMoveLeft()) {
            move();
            direction = Direction.left;
          } else
            if (world.getMoveRight()) {
              move();
              direction = Direction.right;
            } else {
              switch(direction) {

              case up:
                break;

              case right:
                break;

              case down:
                break;

              case left:
              }
            }
    }
    
    switch(direction){
      
      case up:
      image(up[index], x + 14.5, y);
      break;
      
      case down:
      image(down[index], x + 14.5, y);
      break;
      
      case right:
      image(right[index], x + 14.5, y);
      break;
      
      case left:
      image(left[index], x + 14.5, y);
      break;
    }

    
    //println("frame: " + frame + "   imgDirectionIndex: " + imgDirectionIndex + "   imgMoveIndex: " + imgMoveIndex);
    
  }

  void keyPressed() {

    switch(keyCode) {

    case UP:
      direction = Direction.up;
      break;

    case DOWN:
      direction = Direction.down;

    case LEFT:
      direction = Direction.left;
      break;

    case RIGHT:
      direction = Direction.right;
      break;
    }
  }
  
  void move(){
    println(frame);
    if(index < 3){
      switch(frame){
        
        case 1:
        index++;
        break;
        
        case 10:
        index++;
        break;
        
        case 20:
        index++;
        break;
      }
    }else{
      index = 0;
    }
      
  }
  
  String[] readPokemon(){
    String[] pokemon = new String[6];
     try{
       BufferedReader reader = new BufferedReader(new FileReader(dataPath("pokemon.txt")));
       for(int i = 0; i < pokemon.length; i++){
         pokemon[i] = reader.readLine();
         println(pokemon[i]);
       }
       reader.close();
     }catch(IOException e){
       println(e);
     }
     return pokemon;
  }
  
  int getImgIndex(){
    return index;
  }
  
  void resetFrame(){
    frame = 0;
  }
  
  Direction getDirection(){
    return direction;
  }
  
  String[] getPokemon(){
    return pokemon;
  }
}
