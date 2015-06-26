pprequire_relative './ZOrder'
require_relative './Color'

require_relative './SpacePlayer'
require_relative './Enemy'
require_relative './Bullet'
require_relative './Coin'
require_relative './EnemyGen'

class GameScreen
  attr_accessor :moneyAdded

  attr_reader :stagedEnemies
  attr_reader :money
  attr_reader :isWon
  attr_reader :isAlive
  attr_reader :toLevel
  attr_reader :player

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

    @deathImage = Gosu::Image.new(@window, File.dirname(__FILE__)+"/../media/deathMessage.png", false)
    @playAgainButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width/2, @window.height/2, "Play Again", @window,
      ZOrder::UI)
    @exitButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width/2, @window.height/4*3, "Exit", @window,
      ZOrder::UI)

    @moneyLabel = Gosu::Font.new(@window, Dev::FontName, Dev::FontHeight)

    @enemyCount = Dev::EnemyCount

    @newGame = true

    @isWon = false

    @isAlive = true

    @moneyAdded = false

    @startTime = @time = 0
    @money = 0

    @finishStartTime = @finishEndTime = 0
  end

  def levelStart
    @player = SpacePlayer.new(@window, @window.width/2.0, @window.height/2.0)
    @activeEnemies = Array.new
    @playerBullets = Array.new
    @enemyBullets = Array.new
    @coins = Array.new
    # Enemy Generation
    @stagedEnemies = EnemyGen.new(@window, @levelFilePath).enemies

    @startTime = Gosu::milliseconds
    @time = 0
    @money = 0

    @finishStartTime = @finishEndTime = 0

    @isWon = false

    @moneyAdded = false
  end

  def draw
    if !@player.isKill then
      @player.draw
    end

    @moneyLabel.draw("Money: #{@money}", 10, 10, ZOrder::UI, 1.0, 1.0, Color::WHITE)

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
    @isAlive = !@player.isKill

    @time = Gosu::milliseconds - @startTime

    if @newGame == true then
      levelStart
      @newGame = false
    end

    if @toLevel then
      @toLevel = false
      @newGame = true
      return Hash[level:true, game:false]
    end

    if @stagedEnemies.empty? and @activeEnemies.empty? and !@player.isKill then
      @finishStartTime = Gosu::milliseconds
      if !@isWon then
        @finishEndTime = @finishStartTime + Dev::FinishDuration
        @isWon = true
      end

      if @finishStartTime >= @finishEndTime then
        return Hash[level:true, game:false]
      end
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
    @stagedEnemies.each do |enemy|
      if enemy.spawnTime.to_i <= @time then
        @activeEnemies.push(enemy)
        @stagedEnemies.delete(enemy)
      end
    end

    @activeEnemies.delete_if do |enemy|
      if enemy.checkCollide(@playerBullets) then
        coin = Coin.new(@window, enemy.x, enemy.y)
        @coins.push(coin)
      end
    end

    @activeEnemies.delete_if do |enemy|
      enemy.outofBounds
    end

    @coins.delete_if do |coin|
      if coin.checkCollide(@player) then
        @money += Dev::CoinValue
      end
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
    return Hash[game:true]
  end

end

