require 'gosu'
require './ZOrder'
require './Dev'

require './Button'

class OptionScreen
  def initialize(window)
    @window = window
    @backButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width/2, @window.height/5*4, "Back", @window,
      ZOrder::UI)
  end

  def draw
    @backButton.draw
  end

  def update
    if @window.button_down? Gosu::MsLeft then
      if @backButton.isPushed(@window.mouse_x, @window.mouse_y) then
        return Hash[title:true, option:false]
      end
    end
    return Hash[option:true]
  end
end
