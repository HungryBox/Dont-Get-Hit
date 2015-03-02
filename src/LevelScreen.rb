require 'gosu'
require './ZOrder'
require './Dev'

require './Button'

# Have a personal function that changes the level information

class LevelScreen
  def initialize(window)
    @window = window
    @levelButtonArray = Array.new
    # Make a header
    # @header = Gosu::Image.new()

    for i in 1..5
      levelButton = LevelButton.new(Dev::NumberWidth, Dev::NumberWidth,
        @window.width*(i+2)/10, @window.height/2, "#{i}", @window,
        ZOrder::UI, i)
      @levelButtonArray.push(levelButton)
    end

    @shopButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width-Dev::LineWidth/2, Dev::FontHeight/2, "Shop", @window,
      ZOrder::UI)
  end

  def draw
    @shopButton.draw

    @levelButtonArray.each do |button|
      button.draw
    end
  end

  def update
    if @window.button_down? Gosu::MsLeft then
      if @shopButton.isPushed(@window.mouse_x, @window.mouse_y) then
        return Hash[shop:true, level:false]
      end

      @levelButtonArray.each do |button|
        if button.isPushed(@window.mouse_x, @window.mouse_y) then
          # LOAD LEVEL CORRESPONDING TO NUM
          # button.num

          return Hash[game:true, level: false]
        end
      end
    end

    return Hash[level:true, title:false, game:false]
  end
end



class LevelButton < Button
  attr_reader :num
  def initialize(width, height, xcenter, ycenter, text, window, zorder, num)
    @width = width
    @height = height
    @xcenter = xcenter
    @ycenter = ycenter
    @text = text
    @window = window

    @num = num

    @image = Gosu::Image.from_text(@window, @text,
      Dev::FontName, Dev::FontHeight, Dev::LineSpacing,
      Dev::NumberLineWidth, Dev::TextAlign)

    @zorder = zorder
  end
end
