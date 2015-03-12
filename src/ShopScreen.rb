require 'gosu'
require './ZOrder'
require './Dev'

require './Button'
class ShopScreen
  attr_accessor :money

# GET MONEY TO DECREASE WHEN BUTTON IS PRESSED

  def initialize(window)
    @window = window
    @backButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      Dev::LineWidth/2, Dev::FontHeight/2, "Back", @window,
      ZOrder::UI)
    # Put in ship view
    # Put in vanity box
    # Put in mods box

    @moneyLabel = Gosu::Font.new(@window, Dev::FontName, Dev::FontHeight)

    @weaponScrollBox = ScrollBox.new(Dev::LineWidth, Dev::FontHeight,
      Dev::LineWidth/2, Dev::FontHeight/2, 3, @window,
      ZOrder::UI)

    @money = 0
  end

  def draw
    @backButton.draw

    @moneyLabel.draw("Money: #{@money}", 500, 10, ZOrder::UI, 1.0, 1.0, Color::WHITE)

    @weaponScrollBox.draw
  end

  def button_down(id)
    case id
    when Gosu::MsLeft then
      if @backButton.isPushed(@window.mouse_x, @window.mouse_y) then
        @toLevel = true
      end
      @weaponScrollBox.button_down(id)
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
  def initialize(width, height, xcenter, ycenter, itemCount, window, zorder)
    @width, @height = width, height
    @xcenter, @ycenter = xcenter, ycenter
    @window, @zorder = window, zorder

    @buttonArray = Array.new

    for i in 1..itemCount
      @buttonArray.push(Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width/4, Dev::FontHeight*1.5*(i+2), "Gun #{i}", @window,
      ZOrder::UI))
    end
  end

  def button_down(id)
    @buttonArray.each do |button|
      if button.isPushed(@window.mouse_x, @window.mouse_y) then
        # TEST TO SEE IF YOU CAN BUY THE PRODUCT
        @money = @money.to_i - 10
      end
    end
  end

  def draw()
    @buttonArray.each {|button| button.draw}
  end

  def update()
  end
end
