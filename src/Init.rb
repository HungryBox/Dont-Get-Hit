module Init
  WINDOW_HEIGHT = 400
  WINDOW_WIDTH = 400
  FILE = File.dirname(__FILE__)+"/../"

  TITLE_SONG = Gosu::Song.new(FILE+"media/jojo.m4a")
  CREDIT_SONG = Gosu::Song.new(FILE+"media/3.m4a")
end

