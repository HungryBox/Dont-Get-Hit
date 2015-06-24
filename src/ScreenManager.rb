require_relative './Init'
require_relative './TitleScreen'
require_relative './Gun'

class ScreenManager < Gosu::Window
  def initialize
    super(Init::WINDOW_WIDTH, Init::WINDOW_HEIGHT, false)
    self.caption = "Don't Get Hit"

    @backgound_image = Gosu::Image.new(self, Init::FILE+"media/Space.png")
    @title = TitleScreen.new(self)

    @currentScreen = "title"

    @screenHash = Hash[title: @title]

    @song = Init::TITLE_SONG
    @song.play

    # Global/Save Variables
    @money = 0
    @gun = Gun.new
  end
end
