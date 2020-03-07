World world;
Player player;

void setup() {
  size(1280, 768);
  frameRate(100);

  world = new World();
}

void draw() {
  background(0);
  world.draw();
}

void keyPressed() {
  world.keyPressed();
}

void keyReleased() {
  world.keyReleased();
}
