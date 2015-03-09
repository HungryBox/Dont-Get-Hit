require 'gosu'
require './ZOrder'
require './Dev'

require './Button'

class CreditScreen
  def initialize(window)
    @window = window
    @credits = Gosu::Image.from_text(@window, "Ty Ian and George",
     Dev::FontName, 50, 50, 500, :center)
    @backButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width/2, @window.height/7*6, "Back", @window,
      ZOrder::UI)

    @toTitle = false
  end

  def draw
    @credits.draw(@window.width/4, @window.height/4, ZOrder::UI)
    @backButton.draw
  end

  def button_down(id)
    case id
    when Gosu::MsLeft then
      if @backButton.isPushed(@window.mouse_x, @window.mouse_y) then
        @toTitle = true
      end
    end
  end

  def update
    if @toTitle then
      @toTitle = false
      return Hash[title:true, credit:false]
    else
      return Hash[credit:true]
    end
  end
end
