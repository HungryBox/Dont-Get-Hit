require 'gosu'

class Test < Gosu::Window
  def initialize
    super(100, 100, false)

    self.caption = "Windows Test"

    @backgound_image = Gosu::Image.new(self, "Space.png")

    @song = Gosu::Song.new("music/kushmere.ogg")
    @song.play

    puts "This got to the end."
  end
end

object = Test.new
object.show
