require 'gosu'
require './ZOrder'

require './SpacePlayer'
require './Enemy'
require './Bullet'

class GameScreen
  def initialize(window)
    @window = window
    @player = SpacePlayer.new(@window, @window.width/2.0, @window.height/2.0)
    @enemies = Array.new
    @playerBullets = Array.new
    @enemyBullets = Array.new

    @deathImage = Gosu::Image.new(@window, "../media/deathMessage.png", false)
    @playAgainButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width/2, @window.height/2, "Play Again", @window,
      ZOrder::UI)
    @exitButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width/2, @window.height/4*3, "Exit", @window,
      ZOrder::UI)
    end

  def restart
    @player = SpacePlayer.new(@window, @window.width/2.0, @window.height/2.0)
    @enemies = Array.new
    @playerBullets = Array.new
    @enemyBullets = Array.new
  end

  def draw
    if !@player.isKill then
      @player.draw
    end

    @enemies.each { |enemy| enemy.draw }
    @playerBullets.each {|bullet| bullet.draw}
    @enemyBullets.each {|bullet| bullet.draw}

    x_center = @window.width/2
    y_center = @window.height/2

    if @player.isKill then
      @deathImage.draw(x_center-@deathImage.width/2.0, y_center-250, ZOrder::UI)
      @playAgainButton.draw
      @exitButton.draw
    end
  end

  def update
    if !@player.isKill then
      if @window.button_down? Gosu::KbLeft then
        @player.accelLeft
      end
      if @window.button_down? Gosu::KbRight then
        @player.accelRight
      end
      if @window.button_down? Gosu::KbUp then
        @player.accelForward
      end
      if @window.button_down? Gosu::KbDown then
        @player.accelBackward
      end

      @player.move
      @player.checkCollide(@enemyBullets)
    else
      if @window.button_down? Gosu::MsLeft then
        if @playAgainButton.isPushed(@window.mouse_x, @window.mouse_y) then
          restart
        end
        if @exitButton.isPushed(@window.mouse_x, @window.mouse_y) then
          return Hash[title:true, game:false]
        end
      end
    end

    @enemies.delete_if do |enemy|
      enemy.outofBounds or
      enemy.checkCollide(@playerBullets)
    end

    @playerBullets.delete_if { |bullet| bullet.outofBounds }
    @enemyBullets.delete_if { |bullet| bullet.outofBounds }

    if !@player.isKill then
      bullet = @player.shoot
      if bullet.is_a?(Bullet) then
        @playerBullets.push(bullet)
      end
    end

    @enemies.each do |enemy|
      enemy.move
      bullet = enemy.shoot
      if bullet.is_a?(Bullet) then
        @enemyBullets.push(bullet)
      end
    end

    @playerBullets.each {|bullet| bullet.move}
    @enemyBullets.each {|bullet| bullet.move}

    # Spawn enemies
    if @enemies.size < 5 then
      @enemies.push(Enemy.new(@window, rand(@window.width), 0))
    end

    return Hash[game:true]
  end
end


# Death Screen update

# if button_down? Gosu::MsLeft then
#   if self.mouse_x >= self.width/2.0-@playAgainImage.width/2.0 and
#     self.mouse_x <= self.width/2.0+@playAgainImage.width/2.0 then
#     if self.mouse_y >= self.height/2.0+50 - @playAgainImage.height/2.0 and
#     self.mouse_y <= self.height/2.0+50 + @playAgainImage.height/2.0 then
#       @replay = true


#       @isDeathWindow = false
#       @isPlayWindow = true
#     end
#   end
#   if self.mouse_x >= self.width/2.0-@exitImage.width/2.0 and
#     self.mouse_x <= self.width/2.0+@exitImage.width/2.0 then
#     if self.mouse_y >= self.height/2.0+130 - @exitImage.height/2.0 and
#     self.mouse_y <= self.height/2.0+130 + @exitImage.height/2.0 then
#       @isDeathWindow = false
#       @isTitleWindow = true
#     end
#   end
# end






