class Bullet
{
	int x = 0;
	int y = 0;

  PImage shootImg;
  
  Bullet(int x, int y) 
  {
    this.x = x;
    this.y = y;
    shootImg = loadImage("img/shoot.png");
	}

   void move()
  {
    this.x-= 5;  
  }
  
  void draw()
  {
    image(shootImg, x, y);
  }
  
  boolean isCollideWithEnemy()
  {
    for(int i=0; i<enemyCount; i++)
    {
      if(enemys[i]!=null)
        if (isHit(this.x, this.y, this.shootImg.width, this.shootImg.height, enemys[i].x, enemys[i].y, enemys[i].enemyImg.width, enemys[i].enemyImg.height)) 
          return true;
    }
    return false;
  }
  
  int DestoryWithEnemy()
  {
    for(int i=0; i<enemyCount; i++)
    {
      if(enemys[i]!=null)
        if (isHit(this.x, this.y, this.shootImg.width, this.shootImg.height, enemys[i].x, enemys[i].y, enemys[i].enemyImg.width, enemys[i].enemyImg.height)) 
          return i;
    }
    return -1;
  }
  
  boolean isCollideWithBoss()
  {
    for(int i=0; i<BossCount; i++)
    {
      if(Bosses[i]!=null)
        if (isHit(this.x, this.y, this.shootImg.width, this.shootImg.height, Bosses[i].x, Bosses[i].y, Bosses[i].BossImg.width, Bosses[i].BossImg.height)) 
          return true;
    }
    return false;
  }
  
  int DestoryWithBoss()
  {
    for(int i=0; i<enemyCount; i++)
    {
      if(Bosses[i]!=null)
        if (isHit(this.x, this.y, this.shootImg.width, this.shootImg.height, Bosses[i].x, Bosses[i].y, Bosses[i].BossImg.width, Bosses[i].BossImg.height)) 
        {
          return i;
        }
    }
    return -1;
  }
  boolean isOutOfBorder()
  {
    if(this.x<0)
      return true;
    return false;
  }
}
