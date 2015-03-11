require 'gosu'
require './ZOrder'

require './SpacePlayer'
require './Enemy'
require './Bullet'
require './Coin'
require './EnemyGen'

class GameScreen
  attr_reader :stagedEnemies
  attr_writer :levelFilePath
  attr_writer :newGame

  def initialize(window)
    @window = window
    @player = SpacePlayer.new(@window, @window.width/2.0, @window.height/2.0)
    @activeEnemies = Array.new
    @stagedEnemies = Array.new

    @playerBullets = Array.new
    @enemyBullets = Array.new
    @coins = Array.new

    @deathImage = Gosu::Image.new(@window, "../media/deathMessage.png", false)
    @playAgainButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width/2, @window.height/2, "Play Again", @window,
      ZOrder::UI)
    @exitButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width/2, @window.height/4*3, "Exit", @window,
      ZOrder::UI)
    @enemyCount = Dev::EnemyCount

    @newGame = true
  end

  def levelStart
    @player = SpacePlayer.new(@window, @window.width/2.0, @window.height/2.0)
    @activeEnemies = Array.new
    @playerBullets = Array.new
    @enemyBullets = Array.new
    @coins = Array.new
    # Enemy Generation
    @stagedEnemies = EnemyGen.new(@window, @levelFilePath).enemies

    @enemyCount = Dev::EnemyCount
  end

  def draw
    if !@player.isKill then
      @player.draw
    end

    @activeEnemies.each {|enemy| enemy.draw }
    @playerBullets.each {|bullet| bullet.draw}
    @enemyBullets.each {|bullet| bullet.draw}
    @coins.each {|coin| coin.draw}

    x_center = @window.width/2
    y_center = @window.height/2

    if @player.isKill then
      @deathImage.draw(x_center-@deathImage.width/2.0, y_center-250, ZOrder::UI)
      @playAgainButton.draw
      @exitButton.draw
    end
  end

  def button_down(id)
    if @player.isKill then
      case id
      when Gosu::MsLeft then
        if @playAgainButton.isPushed(@window.mouse_x, @window.mouse_y) then
          @newGame = true
        end
        if @exitButton.isPushed(@window.mouse_x, @window.mouse_y) then
          @toLevel = true
        end
      end
    end
  end

  def update
    if @toLevel then
      @toLevel = false
      @newGame = true
      return Hash[level:true, game:false]
    end

    if @newGame == true then
      levelStart
      @newGame = false
    end

    if !@player.isKill then
      if !Dev::MouseEnabled then
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
      else
        @player.warp(@window.mouse_x, @window.mouse_y)
      end

      @player.checkCollide(@enemyBullets)
      @player.checkCoinCollide(@coins)

      bulletArray = @player.shoot
      if bulletArray.is_a?(Array) then
        bulletArray.each do |bullet|
          if bullet.is_a?(Bullet) then
            @playerBullets.push(bullet)
          end
        end
      end
    end

    # check each enemy in staged enemy against their time value and timer
    # started from levelstart
    # if timer time is greater than or equal to enemy time
    # then push that enemy to activeenemy array and delete from staged enemy

    @activeEnemies.delete_if do |enemy|
      if enemy.checkCollide(@playerBullets) then
        coin = Coin.new(@window, enemy.x, enemy.y)
        @coins.push(coin)
        @enemyCount -= 1
      end
    end

    @activeEnemies.delete_if do |enemy|
      enemy.outofBounds
    end

    @coins.delete_if do |coin|
      coin.checkCollide(@player)
    end

    @playerBullets.delete_if { |bullet| bullet.outofBounds }
    @enemyBullets.delete_if { |bullet| bullet.outofBounds }
    @coins.delete_if { |coin| coin.outofBounds }

    @activeEnemies.each do |enemy|
      enemy.move
      bullet = enemy.shoot
      if bullet.is_a?(Bullet) then
        @enemyBullets.push(bullet)
      end
    end

    @playerBullets.each {|bullet| bullet.move}
    @enemyBullets.each {|bullet| bullet.move}
    @coins.each {|coin| coin.move}

    # Spawn activeEnemies
    # Load the information from a level file
    # if @activeEnemies.size < @enemyCount then
    #   @activeEnemies.push(Enemy.new(@window, rand(@window.width), 0))
    # end

    # puts " i got here "
    # @enemyGen = EnemyGen.new(@window, "#{@levelName}")
    # puts "148"
    # @enemyGen.attr:activeEnemies.each do |curE|
    #   puts "i work"
    #   puts @enemyGen.attr:activeEnemies[curE]
    #   @activeEnemies[curE] = @enemyGen.attr:activeEnemies[curE]
    # end



    return Hash[game:true]
  end

  def setLevel(levelName)
    @levelName = levelName
  end


end

