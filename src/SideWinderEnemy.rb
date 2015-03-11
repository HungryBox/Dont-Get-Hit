require './Enemy'

class SideWinderEnemy < Enemy
  def initialize(window, x, y, spawnTime)
    @image = Gosu::Image.new(window, "../media/Enemyship.bmp", false)
    # Initializes x,y, downward velocity, and ship angle
    @x, @y, @spawnTime = x, y, spawnTime
    @velx = Dev::SimpleEnemyVelocity
    @vely = 0
    @angle = 90

    # Stores window
    @window = window

    @lastTime = @milliseconds = 1000

    # Defines the distance between shots
    @SHOT_LAG = Dev::SimpleEnemyShotLag
  end

  def shoot
    if (Gosu::milliseconds - @lastTime) >= 1 then
      @milliseconds += 1
      @lastTime = Gosu::milliseconds()
    end

    if @milliseconds >= @SHOT_LAG then
      @milliseconds = 0
      return Bullet.new(@window, @x, @y, 0, @vely+Dev::SimpleEnemyAdditionalBulletSpeed, false)
    end
  end
end
