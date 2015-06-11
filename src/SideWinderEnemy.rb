require_relative './Enemy'

class SideWinderEnemy < Enemy
  def initialize(window, x, y, spawnTime)
    @image = Gosu::Image.new(window, File.dirname(__FILE__)+"/../media/Enemyship.bmp", false)
    # Initializes x,y, downward velocity, and ship angle
    @x, @y, @spawnTime = x, y, spawnTime

    if @x == 0 then
      @velx = Dev::SimpleEnemyVelocity
    else
      @velx = -Dev::SimpleEnemyVelocity
    end
    @vely = 0

    if @x == 0 then
      @angle = 90
    else
      @angle = 270
    end

    # Stores window
    @window = window

    @lastTime = @milliseconds = 1000

    # Defines the distance between shots
    @SHOT_LAG = Dev::SimpleEnemyShotLag
  end

  def shoot
    xvel = 0
    if (Gosu::milliseconds - @lastTime) >= 1 then
      @milliseconds += 1
      @lastTime = Gosu::milliseconds()
    end

    if @milliseconds >= @SHOT_LAG then
      @milliseconds = 0
      if @angle == 90 then
        xvel = (@velx+Dev::SimpleEnemyAdditionalBulletSpeed)
      elsif @angle == 270
        xvel = (@velx-Dev::SimpleEnemyAdditionalBulletSpeed)
      end

      return Bullet.new(@window, @x, @y, xvel, @vely+Dev::SimpleEnemyAdditionalBulletSpeed, false)
    end
  end
end
