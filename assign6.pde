class GameState
{
	static final int START = 0;
	static final int PLAYING = 1;
	static final int END = 2;
}
class Direction
{
	static final int LEFT = 0;
	static final int RIGHT = 1;
	static final int UP = 2;
	static final int DOWN = 3;
}
class EnemysShowingType
{
	static final int STRAIGHT = 0;
	static final int SLOPE = 1;
	static final int DIAMOND = 2;
	static final int STRONGLINE = 3;
}
class FlightType
{
	static final int FIGHTER = 0;
	static final int ENEMY = 1;
	static final int ENEMYSTRONG = 2;
}

int state = GameState.START;
int currentType = EnemysShowingType.STRAIGHT;
int enemyCount = 8;
int BossCount = 5;
int BossHp = 5;
int shootCount = 100;
Enemy[] enemys = new Enemy[enemyCount];
Boss[] Bosses = new Boss[BossCount];
Bullet[] bullets = new Bullet[shootCount];
Fighter fighter;
Background bg;
FlameMgr flameMgr;
Treasure treasure;
HPDisplay hpDisplay;




boolean isMovingUp;
boolean isMovingDown;
boolean isMovingLeft;
boolean isMovingRight;

int time;
int wait = 4000;


void setup () 
{
	size(640, 480);
	flameMgr = new FlameMgr();
	bg = new Background();
	treasure = new Treasure();
	hpDisplay = new HPDisplay();
  fighter = new Fighter(20);
  for(int i=0; i<shootCount; i++)
    bullets[i] = null;

}

void draw()
{
  if (state == GameState.START)
    bg.draw();	
  else if (state == GameState.PLAYING)
  {
    bg.draw();
    treasure.draw();
    flameMgr.draw();
    fighter.draw();
    
    //enemys
    if(millis() - time >= wait)
    {
      wait =4000;
      if(currentType==3)
      {
        wait =6000;
        for (int i = 0; i < 5; ++i)
        {
          Bosses[i] = new Boss(0, 40+ i * 85, BossHp);
        }
      }
      addEnemy(currentType++);
      currentType = currentType%4;
      
    }		
    for (int i = 0; i < enemyCount; ++i)
    {
      if (enemys[i]!= null)
      {
        enemys[i].move();
        enemys[i].draw();
        if (enemys[i].isCollideWithFighter()) 
        {
          fighter.hpValueChange(-20);
          flameMgr.addFlame(enemys[i].x, enemys[i].y);
          enemys[i]=null;
        }
        else if (enemys[i].isOutOfBorder()) 
          enemys[i]=null;
      }
    }
    
    for (int i = 0; i < BossCount; ++i)
    {
      if (Bosses[i]!= null)
      {
        Bosses[i].move();
        Bosses[i].draw();
        if (Bosses[i].isCollideWithFighter()) 
        {
          fighter.hpValueChange(-50);
          flameMgr.addFlame(Bosses[i].x, Bosses[i].y);
          Bosses[i]=null;
        }
        else if (Bosses[i].isOutOfBorder()) 
          Bosses[i]=null;
      }
    }
    hpDisplay.updateWithFighterHP(fighter.hp);                       //hp
    
    //shoot
    for(int i=0; i<shootCount; i++)
    {
      if(bullets[i]!=null)
      {
        bullets[i].move();
        bullets[i].draw();
        if (bullets[i].isCollideWithEnemy()) 
        {
          flameMgr.addFlame(enemys[bullets[i].DestoryWithEnemy()].x, enemys[bullets[i].DestoryWithEnemy()].y);
          enemys[bullets[i].DestoryWithEnemy()] = null;
          bullets[i] = null;
        }
        else if(bullets[i].isCollideWithBoss())
        {
          Bosses[bullets[i].DestoryWithBoss()].hp--;
          if(Bosses[bullets[i].DestoryWithBoss()].hp==0)
          {
            flameMgr.addFlame(Bosses[bullets[i].DestoryWithBoss()].x, Bosses[bullets[i].DestoryWithBoss()].y);
            Bosses[bullets[i].DestoryWithBoss()] = null;
            bullets[i] = null;
          }       
          bullets[i] = null;
        }
        else if(bullets[i].isOutOfBorder())
          bullets[i] = null;
      }
    }
  }
  else if (state == GameState.END)
    bg.draw();
}
boolean isHit(int ax, int ay, int aw, int ah, int bx, int by, int bw, int bh)
{
	// Collision x-axis?
  boolean collisionX = (ax + aw >= bx) && (bx + bw >= ax);
  // Collision y-axis?
  boolean collisionY = (ay + ah >= by) && (by + bh >= ay);
  return collisionX && collisionY;
}

void keyPressed()
{
  switch(keyCode)
  {
    case UP : isMovingUp = true ;break ;
    case DOWN : isMovingDown = true ; break ;
    case LEFT : isMovingLeft = true ; break ;
    case RIGHT : isMovingRight = true ; break ;
    default :break ;
  }
}
void keyReleased()
{
  switch(keyCode)
  {
    case UP : isMovingUp = false ;break ;
    case DOWN : isMovingDown = false ; break ;
    case LEFT : isMovingLeft = false ; break ;
    case RIGHT : isMovingRight = false ; break ;
    default :break ;
  }
  if (key == ' ') 
  {
    if (state == GameState.PLAYING) 
      fighter.shoot();
  }
  if (key == ENTER) 
  {
    switch(state) 
    {
      case GameState.START:
      case GameState.END:
        state = GameState.PLAYING;
        enemys = new Enemy[enemyCount];
        Bosses = new Boss[BossCount];
        flameMgr = new FlameMgr();
        treasure = new Treasure();
        fighter = new Fighter(20);
        bullets = new Bullet[100];
        for(int i=0; i<shootCount; i++)
          bullets[i] = null;
      default : break ;
    }
  }
}
