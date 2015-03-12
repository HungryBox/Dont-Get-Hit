require 'Weapon'
require 'Bullet'

class PrimeWeapon < Weapon

  def initialize(window,isPlayer)
    @isPlayer = isPlayer
    @window= window
  end

    def makeWeapon(x,y, weaponType)
      bullets = Array.new
      case weaponType
        when "basic" then
          @bullets.push(Bullet.new(x,y,0,Dev::PlayerBulletSpeed,@isPlayer))
        end
        when "trident" then
          @bullets.push(Bullet.new(x,y,-1,Dev::PlayerBulletSpeed,@isPlayer))
          @bullets.push(Bullet.new(x,y,0,Dev::PlayerBulletSpeed,@isPlayer))
          @bullets.push(Bullet.new(x,y,1,Dev::PlayerBulletSpeed,@isPlayer))
        end

        return bullets
      end



      # bStats = @@hash["#{weaponHashKey}"]
      #   # window, x, y, vel_x, vel_y, playerBullet
      # @bullets.push(Bullet.new(@window,x,y,bStats[0],bStats[1]))
      # if(bStats.size > 2) then
      #   @bullets.push(Bullet.new(@window,x,y,bStats[2],bStats[3]))
      # end
      # if(bStats.size > 4) then
      #   @bullets.push(Bullet.new(@window,x,y,bStats[4],bStats[5]))
      # end

]      super.shoot(x,y)
    end

end
