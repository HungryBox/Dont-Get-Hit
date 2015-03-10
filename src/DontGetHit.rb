require 'gosu'
require './ZOrder'
require './Dev'

require './TitleScreen'
require './CreditScreen'
require './GameScreen'
require './LevelScreen'
require './ShopScreen'
require './OptionScreen'

class DontGetHit < Gosu::Window
  def initialize
    super(800, 600, false)
    self.caption = "Don't Get Hit"
    @background_image = Gosu::Image.new(self, "../media/Space.png", true)

    @lastTime = @seconds = 0

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
        @screenState = @screenState.merge(@screenArray[screenName].update)
      end
    end
  end

  # def genEnimy file
  #   gameFile = IO.read("#{file}")
  #   s = StringScanner.new(gameFile)
  #   eType = s.scan()
  #   ex = s.scan(/(\d\d{2}?)/)
  #   ey = s.scan(/(\d\d{2}?)/)
  #   if(eType == 'E') then
  #     Enemy.new(this,ex,ey)
  #   end
  # end

  def needs_cursor?
    true
  end
end

window = DontGetHit.new()
window.show
