require_relative './ZOrder'
require_relative './Dev'

require_relative './TitleScreen'
require_relative './CreditScreen'
require_relative './GameScreen'
require_relative './LevelScreen'
require_relative './ShopScreen'
require_relative './OptionScreen'

# Read through code and look for optimizations

# Option Screen

class ScreenManager < Gosu::Window
  def initialize
    super(800, 600, false)
    self.caption = "Don't Get Hit"
    @background_image = Gosu::Image.new(self, File.dirname(__FILE__)+"/../media/Space.png", true)

    @lastTime = @seconds = 0

    @enemyArray = Array.new()

    @titleScreen = TitleScreen.new(self)
    @creditScreen = CreditScreen.new(self)
    @gameScreen = GameScreen.new(self)
    @levelScreen = LevelScreen.new(self)
    @shopScreen = ShopScreen.new(self)
    @optionScreen = OptionScreen.new(self)

    @screenState = Hash[title: true, credit: false,
      game: false, level: false, shop: false, option: false]

    @screenArray = Hash[title: @titleScreen, credit: @creditScreen,
      game: @gameScreen, level: @levelScreen, shop: @shopScreen,
      option: @optionScreen]

    @money = 100
    @gun = "TRIDENT"
  end


  def draw
    @background_image.draw(0,0, ZOrder::Background)
    # Draw active element
    @screenState.each do |screenName, active|
      if active then
        @screenArray[screenName].draw
      end
    end
  end


  def button_down(id)
    # Do active element
    @screenState.each do |screenName, active|
      if active then
        @screenArray[screenName].button_down(id)
      end
    end

    case id
    when Gosu::KbEscape then
      if @seconds >= Dev::EscapeLag and @screenState[:title] then
        self.close
      end

      @screenState.each do |key, value|
        if value then
          @screenState[key] = false
        end
      end
      @screenState[:title] = true
    end
  end

# screen changes happen here
  def update
    if (Gosu::milliseconds - @lastTime)/1000 == 1 then
      @seconds += 1
      @lastTime = Gosu::milliseconds
    end

    # Update active screen
    @screenState.each do |screenName, active|
      if active then
        if screenName == :level then
          if @screenArray[:level].toGame then
            hash, filePath = @screenArray[screenName].update

            @screenState = @screenState.merge(hash)

            @screenArray[:game].levelFilePath = filePath
            @screenArray[:game].newGame = true
          elsif @screenArray[:level].toShop then
            @screenArray[:shop].shopMoney = @money
            @screenState = @screenState.merge(@screenArray[screenName].update)
          end
        elsif screenName == :game then
          # Get weapon to update
          @screenArray[:game].player.weaponType = @gun
          if !@screenArray[:game].moneyAdded then
            puts @screenArray[:game].money
            @money += @screenArray[:game].money
            @screenArray[:game].moneyAdded = true
          end

          @screenState = @screenState.merge(@screenArray[screenName].update)
        elsif screenName == :shop then
          if @screenArray[:shop].toLevel then
            puts @money
            @money = @screenArray[:shop].shopMoney
            @gun = @screenArray[:shop].gun
          end
          @screenState = @screenState.merge(@screenArray[screenName].update)
        else
          @screenState = @screenState.merge(@screenArray[screenName].update)
        end
      end
    end
  end

  def needs_cursor?
    !(@screenState[:game] and @screenArray[:game].isAlive)
  end
end
