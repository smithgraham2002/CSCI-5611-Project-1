//Global variables

//Flipper variables
Flipper[] flippers = new Flipper[2];
float mag;

//GameStuff
PImage bg;
int score = 0;
int lives = 3;
float launcherVel = - 400;
boolean canLaunch;
float scoreMultiplyer = 1;

//Ball information
int currentBalls = 1;
int maxBalls = 3;
Circle[] balls = new Circle[maxBalls];
Vec2 vel[] = new Vec2[maxBalls];
float ballRadius = 15;
float cor = 0.95f;
float ballMass = (ballRadius * ballRadius + 10);
float speed = .75;
float gravity = 15;



//Shape arrays
Circle[] circles;
Box[] boxes;
Line[] lines;
int[] collisions;
int location = 0;
PrintWriter output;

//Setup the start of the game
void startGame(){
  canLaunch = true;
  makeBalls();
  makeShapes();
  
  bg = loadImage("pinballBackground.png");
}

void makeBalls(){
  for(int i = 0; i < currentBalls; i++){
    balls[i] = new Circle(0, new Vec2(870 + i * 40, 180), ballRadius);
    vel[i] = new Vec2(0, 0);
  }
  for(int i = currentBalls; i < maxBalls; i++){
    balls[i] = new Circle(-1, new Vec2(0 + random(800), 170), ballRadius);
    vel[i] = new Vec2(200, -200);
  }
}

void launchBalls(){
  for(int i = 0; i < currentBalls; i++){
    vel[i].x += launcherVel;
  }
}



//Executes functions to complete task
void setup(){
  size(1000, 1000);
  smooth();
  createFlippers();
  mag = flippers[0].getLength();
  startGame();
}

void update(float dt){
  //Update ball positions
  checkMultiplyer();
  updateFlippers(dt);
  for(int i = 0; i < balls.length; i++){
    if(balls[i].id == 0){
      balls[i].pos.add((vel[i].times(dt)).times(speed));
      vel[i].y += gravity;
      ballWall(i);
      for (int j = 0; j < circles.length; j++){
        ballObstacleCircle(i, j);
      }
      for (int j = 0; j < lines.length; j++){
        ballLine(i, j);
      }
      for (int j = i + 1; j < maxBalls; j++){
        if (balls[j].id == 0){
          ballBall(i, j);
        }
      }
    }
  }
}


void draw(){
  if(lives > 0){
    update(1/frameRate);
    background(bg);
    fill(179, 169, 161);
    stroke(0, 0, 0);
    strokeWeight(1);
    for (int i = 0; i < maxBalls; i++){
      if(balls[i].id == 0){
        ellipse(balls[i].pos.x, balls[i].pos.y, balls[i].r * 2, balls[i].r * 2);
      }
    }
    noStroke();
    
    //Rectangle images created around the bounds of lines
    
    
    for(int i = 0; i < circles.length; i++){
      if(circles[i].id == 1){
        fill(255, 50, 0);
        ellipse(circles[i].pos.x, circles[i].pos.y, circles[i].r * 2, circles[i].r * 2);
      }
      else if(circles[i].id == 0){
        noFill();
        ellipse(circles[i].pos.x, circles[i].pos.y, circles[i].r * 2, circles[i].r * 2);
      }
      else{
        fill(255, 0, 255);
        ellipse(circles[i].pos.x, circles[i].pos.y, circles[i].r * 2, circles[i].r * 2);
      }
    }

    fill(0, 50, 255);
    rect(600, 450, 200, 50);
    rect(0, 500, 50, 500);
    rect(950, 500, 50, 500);
    rect(0, 0, 1000, 135);
    rect(850, 195, 150, 20);
    fill(179, 169, 161);
    
    for(int i = 0; i < lines.length; i++){
      line(lines[i].pos1.x, lines[i].pos1.y, lines[i].pos2.x, lines[i].pos2.y);
    }
    
    fill(0, 0, 0);
    textSize(60);
    textAlign(LEFT);
    text("ScoreX" + scoreMultiplyer + ": " + score, 60, 50, 500, 500);
    textAlign(RIGHT);
    text("Lives: " + lives, 400, 50, 500, 500);
    textSize(30);
    textAlign(CENTER);
    text("Press P to launch", 250, 0, 500, 500);
    
    //Flippers
    stroke(0, 0, 0);
    strokeWeight(17);
    line(flippers[0].pos1.x, flippers[0].pos1.y, flippers[0].pos2.x, flippers[0].pos2.y);
    line(flippers[1].pos1.x, flippers[1].pos1.y, flippers[1].pos2.x, flippers[1].pos2.y);
    
    
  }
  
  else{
    background(0);
    fill(255);
    textSize(60);
    text("Game Over", 300, 300, 400, 200);
    textSize(30);
    text("Press R for Replay", 300, 400, 400, 500);
    textSize(80);
    textAlign(CENTER);
    text("Score: " + score, 200, 500, 600, 600);
  }
}

void loseBall(int i){
  boolean hasBalls = false;
  balls[i].id = -1;
  for(int j = 0; j < balls.length; j++){
    if(balls[j].id == 0){
      hasBalls = true;
    }
  }
  if(!hasBalls){
    loseLife();
  }
}

void loseLife(){
  lives--;
  if(lives > 0){
    startGame();
  }
}

void checkMultiplyer(){
  if(circles[0].id == -1 && circles[1].id == -1 && circles[2].id == -1){
    scoreMultiplyer = 2;
  }
  else{ 
    scoreMultiplyer = 1;
  }
    if(circles[0].id == -1 && circles[1].id == -1 && circles[2].id == -1 && circles[3].id == -1 && circles[4].id == -1 && circles[5].id == -1){
    addBalls();
  }
}

void addBalls(){
  if(currentBalls < maxBalls){
    for(int i = 0; i < maxBalls; i++){
      if(balls[i].id == -1){
        balls[i].id = 0;
        balls[i].pos = new Vec2(870 + i * 40, 160);
        vel[i].x = -400;
      }
    }
  }
}

boolean leftPressed, rightPressed;
void keyPressed() {
  if (keyCode == LEFT) {
    leftPressed = true;
  }
  if (keyCode == RIGHT) {
    rightPressed = true;
  }
}


void keyReleased(){
  if (key == 'r'){
    lives = 3;
    score = 0;
    startGame();
  }
  if (key == 'p'){
    if(canLaunch)
    launchBalls();
    canLaunch = false;
  }
  if (keyCode == LEFT) {
    leftPressed = false;
  }
  if (keyCode == RIGHT) {
    rightPressed = false;
  }
  
}
