require 'gosu'
require './ZOrder'
require './Dev'


require './TitleScreen'
require './CreditScreen'
require './GameScreen'
require './LevelScreen'
# require './ShopScreen'
require './OptionScreen'


# Need option screen
# Screen state object?

class DontGetHit < Gosu::Window
  def initialize
    super(800, 600, false)
    self.caption = "Don't Get Hit"
    @background_image = Gosu::Image.new(self, "../media/Space.png", true)

    @lastTime = @seconds = 0

    @screenState = Hash[title: true, credit: false,
      game: false, level: false, shop: false, option: false]

    @titleScreen = TitleScreen.new(self)
    @creditScreen = CreditScreen.new(self)
    @gameScreen = GameScreen.new(self)
    @levelScreen = LevelScreen.new(self)
    @optionScreen = OptionScreen.new(self)

    #@enemyGen = EnemyGen.new(self, "levelOne.txt")
    # this creates a class to read the file.
    # enemyGen.genNext will return an Enemy genarated from
    # the text file given to the object

    # FUTURE SCREENS
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
      @levelScreen.draw
    elsif @screenState[:shop] then
    elsif @screenState[:option] then
      @optionScreen.draw
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

      if @seconds == 1 then
        if @screenState[:title] then
          self.close
        end
      end

      if (Gosu::milliseconds - @lastTime)/1000 >= Dev::EscapeLag then
        @seconds += 1
        @lastTime = Gosu::milliseconds
      end
    end

    if @screenState[:title] then
      @screenState = @screenState.merge(@titleScreen.update)
    elsif @screenState[:credit] then
      @screenState = @screenState.merge(@creditScreen.update)
    elsif @screenState[:game] then
      @screenState = @screenState.merge(@gameScreen.update)
    elsif @screenState[:level] then
      @screenState = @screenState.merge(@levelScreen.update)
    elsif @screenState[:shop] then
    elsif @screenState[:option] then
    end
  end


  def needs_cursor?
    true
  end
end

window = DontGetHit.new()
window.show
