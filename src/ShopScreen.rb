require 'gosu'
require './ZOrder'
require './Dev'

require './Button'
class ShopScreen
  attr_accessor :money

  def initialize(window)
    @window = window
    @backButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      Dev::LineWidth/2, Dev::FontHeight/2, "Back", @window,
      ZOrder::UI)
    # Put in ship view
    # Put in vanity box
    # Put in mods box

    @moneyLabel = Gosu::Font.new(@window, Dev::FontName, Dev::FontHeight)

    @scrollBox = ScrollBox.new(Dev::LineWidth, Dev::FontHeight,
      Dev::LineWidth/2, Dev::FontHeight/2, "Back", @window,
      ZOrder::UI)
  end

  def draw
    @backButton.draw

    @moneyLabel.draw("Money: #{@money}", 500, 10, ZOrder::UI, 1.0, 1.0, Color::WHITE)
  end

  def button_down(id)
    case id
    when Gosu::MsLeft then
      if @backButton.isPushed(@window.mouse_x, @window.mouse_y) then
        @toLevel = true
      end
    end
  end

  def update
    if @toLevel then
      @toLevel = false
      return Hash[level: true, shop:false]
    else
      return Hash[shop:true]
    end
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
