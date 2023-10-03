public class Flipper extends Line{
  float angularVel;
  float angle;
  boolean up = false;
  
  public Flipper(Vec2 pos1, Vec2 pos2, int id, float angularVel, float angle) {
    super(id, pos1, pos2);
    this.angularVel = angularVel;
    this.angle = angle;
  }
  
  public Vec2 getTip() {
    return pos2;
  }
}

void createFlippers() {
  flippers[0] = new Flipper(new Vec2(200, 800), new Vec2(450, 800), 0, 0, (9.0/4.0) * PI);
  flippers[1] = new Flipper(new Vec2(800, 800), new Vec2(650, 800), 0, 0, (3.0/4.0) * PI);
  mag = flippers[0].getLength();
}

void updateFlippers(float dt){
  if (leftPressed && flippers[0].angle > (7.0/4.0) * PI) {
    flippers[0].angularVel = -10;
    flippers[0].up = true;
  }
  if (rightPressed && flippers[1].angle < (5.0/4.0) * PI) {
    flippers[1].angularVel = 10;
    flippers[1].up = true;
  }
  for (int i = 0; i < flippers.length; i++) {
    flippers[i].angle += flippers[i].angularVel * dt * 0.5;
    flippers[i].pos2.x = flippers[i].pos1.x + mag * cos(flippers[i].angle);
    flippers[i].pos2.y = flippers[i].pos1.y + mag * sin(flippers[i].angle);
  }
  if (flippers[0].angle < (7.0/4.0) * PI) {
    flippers[0].angularVel = 10;
    flippers[0].up = false;
  }
  if (flippers[1].angle > (5.0/4.0) * PI) {
    flippers[1].angularVel = -10;
    flippers[1].up = false;
  }
  if (flippers[0].angularVel > 0 && flippers[0].angle > (9.0/4.0) * PI) {
    flippers[0].angularVel = 0;
  }
  if (flippers[1].angularVel < 0 && flippers[1].angle < (3.0/4.0) * PI) {
    flippers[1].angularVel = 0;
  }
  for (int i = 0; i < currentBalls; i++) {
    flipperCollision(i, flippers[0], dt);
    flipperCollision(i, flippers[1], dt);
  }
}

void flipperCollision(int i, Flipper f, float dt) {
  Vec2 tip = f.pos2;
  Vec2 dir = tip.minus(f.pos1);
  Vec2 dir_norm = dir.normalized();
  float proj = dot(balls[i].pos.minus(f.pos1), dir_norm);
  Vec2 closest;
  if (proj < 0) {
    closest = f.pos1;
  } else if (proj > dir.length()) {
    closest = tip;
  } else {
    closest = f.pos1.plus(dir_norm.times(proj));
  }

  dir = balls[i].pos.minus(closest);
  float dist = dir.length();
  if (dist > balls[i].r + 2) {
    return;
  }
  Vec2 ball_dir = balls[i].pos.minus(closest);
  ball_dir.normalized();
  balls[i].pos.add(ball_dir.times(4));
  dir.mul(1.0 / dist);

  

  Vec2 radius = closest.minus(f.pos1);
  Vec2 vec = new Vec2(-radius.y, radius.x);
  Vec2 surfaceVel = vec.times(f.angularVel);
  
  if (f.up == true) {
    balls[i].pos = closest.plus(dir.times(balls[i].r)).plus(surfaceVel.times(0.01));
  } else {
    balls[i].pos = closest.plus(dir.times(balls[i].r)).minus(surfaceVel.times(0.01));
  }
  
  float v_ball = dot(vel[i], dir);
  float v_flip = dot(surfaceVel, dir);
  float m1 = ballMass;
  float m2 = 70;
  float new_v = (m1 * v_ball + m2 * v_flip - m2 * (v_ball - v_flip) * cor) / (m1 + m2);
  vel[i] = vel[i].plus(dir.times(new_v - v_ball));

}
