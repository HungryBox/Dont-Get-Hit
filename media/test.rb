require 'gosu'

# This entire file should be in the media folder to make sure that the issues aren't being caused by an issue with the "__FILE__" or Init class
# If all this executes correctly then I'll need to reformat the tests to better reflect problems with __FILE__ or Init
class Test < Gosu::Window
  def initialize
    super(100, 100, false)

    self.caption = "Windows Test"

    # Testing this line of code on windows for a file type error
    # Something along the lines of a to_blob error
    @backgound_image = Gosu::Image.new(self, "Space.png")

    # Testing this line for a file type error
    # Tested an mp3, m4a, and wav and gt the same errors
    @song = Gosu::Song.new("music/kushmere.ogg")
    @song.play

    # This line is just here to make sure that everything executes is the song doesn't play and because the background is hard to see
    puts "This got to the end."
  end
end

# Actually executes the test class
object = Test.new
object.show
