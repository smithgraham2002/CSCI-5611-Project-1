void ballBall(int i, int j){
  Vec2 delta = balls[i].pos.minus(balls[j].pos);
  float dist = delta.length();
  if(dist < balls[i].r + balls[j].r){
    float overlap = 0.5f * (dist - balls[i].r - balls[j].r);
    balls[i].pos.subtract(delta.normalized().times(overlap));
    balls[j].pos.add(delta.normalized().times(overlap));
    
    //Collision
    Vec2 dir = delta.normalized();
    float v1 = dot(vel[i], dir);
    float v2 = dot(vel[j], dir);
    float m1 = ballMass;
    float m2 = ballMass;
    
    float new_v1 = (m1 * v1 + m2 * v2 - m2 * (v1 - v2) * cor) / (m1 + m2);
    float new_v2 = (m1 * v1 + m2 * v2 - m1 * (v2 - v1) * cor) / (m1 + m2);
    vel[i] = vel[i].plus(dir.times(new_v1 - v1));
    vel[j] = vel[j].plus(dir.times(new_v2 - v2));
  }
}

void ballObstacleCircle(int i, int circle){
  Vec2 delta = balls[i].pos.minus(circles[circle].pos);
  float dist = delta.length();
  float overlap = dist - balls[i].r - circles[circle].r;
  if(overlap < 0){
    balls[i].pos.subtract(delta.normalized().times(overlap));
    Vec2 dir = delta.normalized();
    float v1 = dot(vel[i], delta.normalized());
    float v2 = 0;
    float m1 = ballMass;
    float m_obs = 1000000;
    float new_v1 = (m1 * v1 + m_obs * v2 - m_obs * (v1 - v2) * cor) / (m1 + m_obs);
    vel[i] = vel[i].plus(dir.times(new_v1 - v1));
      if(circles[circle].id != 0)score += 40 * scoreMultiplyer;
      circles[circle].id *= -1;
  }
}

void ballWall(int i){
  if(balls[i].pos.x < balls[i].r){
    balls[i].pos.x = balls[i].r;
    vel[i].x *= -cor;
  }
  if(balls[i].pos.x > width - balls[i].r){
    balls[i].pos.x = width - balls[i].r;
    vel[i].x *= -cor;
  }
  if(balls[i].pos.y < balls[i].r){
    balls[i].pos.y = balls[i].r;
    vel[i].y *= -cor;
  }
  if(balls[i].pos.y > height - balls[i].r){
    balls[i].pos.y = height - balls[i].r;
    vel[i].y *= - cor;
    loseBall(i);
  }
}

void ballLine(int i, int j) {
  Vec2 toCircle = balls[i].pos.minus(lines[j].pos1);
  Vec2 l_dir = lines[j].pos2.minus(lines[j].pos1);
  float l_len = l_dir.length();
  l_dir.normalize();
  
  float a = 1;
  float b = -2*dot(l_dir, toCircle);
  float c = toCircle.lengthSqr() - (balls[i].r) * (balls[i].r);
  
  float d = b*b - 4*a*c;
  
  if(d >= 0){
    float t1 = (-b - sqrt(d))/(2*a);
    if(t1 > 0 && t1 < l_len && t1 < 9999999){
      if(lines[j].pos1.y == lines[j].pos2.y){
        if(vel[i].y < 0){
          balls[i].pos.y += balls[i].r/2;
        }
        else{
          balls[i].pos.y -= balls[i].r/2;
        }
        vel[i].y *= -cor; 
      }
      if(lines[j].pos1.x == lines[j].pos2.x){
        if(vel[i].x < 0){
          balls[i].pos.x += balls[i].r/2;
        }
        else{
          balls[i].pos.x -= balls[i].r/2;
        }
        vel[i].x *= -cor;
      }
    }
  }
  else if(isInside(balls[i].pos.x, balls[i].pos.y, balls[i].r, lines[j].pos1.x, lines[j].pos1.y) || 
    isInside(balls[i].pos.x, balls[i].pos.y, balls[i].r, lines[j].pos2.x, lines[j].pos2.y)){
     if(vel[i].y < 0){
       balls[i].pos.y += balls[i].r/2;
     }
     else{
       balls[i].pos.y -= balls[i].r/2;
     }
     
    if(vel[i].x < 0){
       balls[i].pos.x += balls[i].r/2;
      }
    else{
       balls[i].pos.x -= balls[i].r/2;
      }
      vel[i].x *= -cor;
      vel[i].y *= -cor; 
  }
}


//Provided by GeeksForGeeks
boolean isInside(float circle_x, float circle_y, float rad, float x, float y){
    if ((x - circle_x) * (x - circle_x) + (y - circle_y) * (y - circle_y) <= rad * rad)
        return true;
    else
        return false;
}

//Shape classes

class Circle {
  int id;
  Vec2 pos;
  float r;
  //Constructor
  Circle(int iD, Vec2 Pos, float radius){
    id = iD;
    pos = Pos;
    r = radius;
  }
}

class Box {
  int id;
  Vec2 pos;
  float w;
  float l;
  //Constructor
  Box(int iD, Vec2 Pos, float W, float L){
    id = iD;
    pos = Pos;
    w = W;
    l = L;
  }
}

class Line {
  int id;
  Vec2 pos1;
  Vec2 pos2;
  //Constructor
  Line(int iD, Vec2 Pos1, Vec2 Pos2){
    id = iD;
    pos1 = Pos1;
    pos2 = Pos2;
  }
  
  public float getLength(){
    return pos1.distanceTo(pos2);
  }
}

//Comparison functions
