require 'gosu'
require './ZOrder'

require './TitleScreen'
require './CreditScreen'
require './GameScreen'
# require './LevelScreen'
# require './ShopScreen'

# Need option screen

class DontGetHit < Gosu::Window
  def initialize
    super(800, 600, false)
    self.caption = "Don't Get Hit"
    @background_image = Gosu::Image.new(self, "../media/Space.png", true)

    @lastTime = @seconds = 0

    @screenState = {title: false, credit: false,
      game: true, level: false, shop: false}

    @titleScreen = TitleScreen.new(self)
    @creditScreen = CreditScreen.new(self)
    @gameScreen = GameScreen.new(self)

    # FUTURE SCREENS
    # @levelScreen = LevelScreen.new(self)
    # @shopScreen = ShopScreen.new(self)
  end

  def draw
    @background_image.draw(0,0, ZOrder::Background)

    if @screenState[:title] then
      @titleScreen.draw
    elsif @screenState[:credit] then
      @creditScreen.draw
    elsif @screenState[:game] then
      @gameScreen.draw
    elsif @screenState[:level] then
    elsif @screenState[:shop] then
    else
      self.close
    end
  end



  def update
    if button_down? Gosu::KbEscape then
      if !@screenState[:title] then
        @screenState.each_value {|value| value = false}
        @screenState[:title] = true
      end

      if (Gosu::milliseconds - @lastTime)/1000 >= 1 then
        @seconds += 1
        @lastTime = Gosu::milliseconds
      end

      if @seconds == 1 then
        if @screenState[:title] then
          self.close
        end
      end
    end

    if @screenState[:title] then
      @titleScreen.update
    elsif @screenState[:credit] then
      @creditScreen.update
    elsif @screenState[:game] then
      @gameScreen.update
    elsif @screenState[:level] then
    elsif @screenState[:shop] then
    end
  end

  def needs_cursor?
    true
  end
end

window = DontGetHit.new()
window.show
