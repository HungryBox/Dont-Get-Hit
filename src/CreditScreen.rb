require 'gosu'
require './ZOrder'
require './Dev'

class CreditScreen
  def initialize(window)
    @window = window
    @credits = Gosu::Image.from_text(@window, "Ty Ian, David, George",
     Dev::FontName, 50, 50, 500, :center)
  end

  def draw

  end

  def update

  end
end
