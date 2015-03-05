require 'gosu'
require './ZOrder'
require './Dev'

require './Button'

class ShopScreen
  def initialize(window)
    @window = window
    @backButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      Dev::LineWidth/2, Dev::FontHeight/2, "Back", @window,
      ZOrder::UI)
    # Put in ship view
    # Put in vanity box
    # Put in mods box

    @scrollBox = ScrollBox.new(Dev::LineWidth, Dev::FontHeight,
      Dev::LineWidth/2, Dev::FontHeight/2, "Back", @window,
      ZOrder::UI)
  end

  def draw
    @backButton.draw
  end

  def update
    if @window.button_down? Gosu::MsLeft then
      if @backButton.isPushed(@window.mouse_x, @window.mouse_y) then
        return Hash[level: true, shop:false]
      end
    end
    return Hash[shop:true]
  end
end

class ScrollBox
  def initialize(width, height, xcenter, ycenter, text, window, zorder)
  end

  def draw()
  end

  def update()
  end
end
