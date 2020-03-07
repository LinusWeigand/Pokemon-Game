class Sign{
  
  String text;
  boolean visible;
  World world;
  
  Sign(World world){
    this.world = world;
    visible = false;
    text = "";
  }
  
  void draw(){
    if(visible){
      fill(255);
      rectMode(CENTER);
      strokeWeight(5);
      stroke(100, 200, 100);
      rect(width/2, height - 70, width - 40, 100, 5);
      text(text, width/2, height - 70);
    }
  }
  
  void setText(String text){
    this.text = text;
  }
  
  void visible(boolean visible){
    this.visible = visible;
  }
  
  boolean getVisible(){
    return visible;
  }
  
}
