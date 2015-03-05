require 'gosu'
require './ZOrder'
require './Dev'

require './Button'

class CreditScreen
  def initialize(window)
    @window = window
    @credits = Gosu::Image.from_text(@window, "Ty Ian, David, George",
     Dev::FontName, 50, 50, 500, :center)
    @backButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width/2, @window.height/7*6, "Back", @window,
      ZOrder::UI)
  end

  def draw
    @credits.draw(@window.width/4, @window.height/4, ZOrder::UI)
    @backButton.draw
  end

  def update
    if @window.button_down? Gosu::MsLeft then
      if @backButton.isPushed(@window.mouse_x, @window.mouse_y) then
        return Hash[title:true, credit:false]
      end
    end
    return Hash[credit:true]
  end
end
