public class WildBattle extends Battle{
  
  PImage battleback;
  
  public WildBattle(World world){
    super(world);
    battleback = loadImage("data\\battleback.png");
  }
  
  public void draw(){
    image(battleback, 0, 0);
  }
  
}
