// Boss image is "img/enemy2.png" 
class Boss
{
  int x = 0;
  int y = 0;
  int hp;
  int speed = 5;

  PImage BossImg;
  Boss(int x, int y, int hp)
  {
    this.x = x;
    this.y = y;
    this.hp = hp;
    BossImg = loadImage("img/enemy2.png");
  }

  void move()
  {
    this.x+= 2;  
  }

  void draw()
  {
    image(BossImg, x, y);
  }

  boolean isCollideWithFighter()
  {
    if (isHit(this.x, this.y, this.BossImg.width, this.BossImg.height, fighter.x, fighter.y, fighter.fighterImg.width, fighter.fighterImg.height)) 
      return true;
    return false;
  }

  boolean isOutOfBorder()
  {
    if(this.x>=640)
      return true;
    return false;
  }
  
  
}
