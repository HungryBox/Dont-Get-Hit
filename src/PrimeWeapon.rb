require './Dev'
require './Bullet'

class PrimeWeapon

  def initialize(window,isPlayer)
    @isPlayer = isPlayer
    @window= window
    @speed = Dev::PlayerBulletSpeed
  end

  def shootWeapon(x,y, weaponType)
    bullets = Array.new
    case weaponType
      when "basic" then
        bullets.push(Bullet.new(@window,x,y,0,@speed,@isPlayer))
      when "trident" then
        bullets.push(Bullet.new(@window,x,y,-@speed,@speed,@isPlayer))
        bullets.push(Bullet.new(@window,x,y,0,@speed,@isPlayer))
        bullets.push(Bullet.new(@window,x,y,@speed,@speed,@isPlayer))
      when "star"
        bullets.push(Bullet.new(@window,x,y,0,@speed,@isPlayer))
        bullets.push(Bullet.new(@window,x,y,-@speed,@speed,@isPlayer))
        bullets.push(Bullet.new(@window,x,y,-@speed,0,@isPlayer))
        bullets.push(Bullet.new(@window,x,y,-@speed,-@speed,@isPlayer))
        bullets.push(Bullet.new(@window,x,y,0,-@speed,@isPlayer))
        bullets.push(Bullet.new(@window,x,y,@speed,-@speed,@isPlayer))
        bullets.push(Bullet.new(@window,x,y,@speed,0,@isPlayer))
        bullets.push(Bullet.new(@window,x,y,@speed,@speed,@isPlayer))
      end

    return bullets



      # bStats = @@hash["#{weaponHashKey}"]
      #   # window, x, y, vel_x, vel_y, playerBullet
      # @bullets.push(Bullet.new(@window,x,y,bStats[0],bStats[1]))
      # if(bStats.size > 2) then
      #   @bullets.push(Bullet.new(@window,x,y,bStats[2],bStats[3]))
      # end
      # if(bStats.size > 4) then
      #   @bullets.push(Bullet.new(@window,x,y,bStats[4],bStats[5]))
      # end
    end

end
