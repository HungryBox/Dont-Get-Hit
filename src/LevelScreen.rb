require 'gosu'
require './ZOrder'
require './Dev'

require './Button'

# Have a personal function that changes the level information
# UPDATE BUTTON CLICKING BY CREATING A VARIABLE THAT WILL TELL IF THE MOUSE
# BUTTON HAS BEEN UP BEFORE REGISTERING THE NEXT CLICK

class LevelScreen
  def initialize(window)
    @window = window
    @levelButtonArray = Array.new
    # Make a header
    # @header = Gosu::Image.new()
    @backButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      Dev::LineWidth/2, Dev::FontHeight/2, "Back", @window,
      ZOrder::UI)

    for i in 1..5
      levelButton = LevelButton.new(Dev::NumberWidth, Dev::NumberWidth,
        @window.width*(i+2)/10, @window.height/3, "#{i}", @window,
        ZOrder::UI, i)
      @levelButtonArray.push(levelButton)
    end

    @shopButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width-Dev::LineWidth/2, Dev::FontHeight/2, "Shop", @window,
      ZOrder::UI)
  end

  def draw
    @backButton.draw

    @shopButton.draw

    @levelButtonArray.each do |button|
      button.draw
    end
  end

  def button_down(id)
    case id
    when Gosu::MsLeft then
      if @backButton.isPushed(@window.mouse_x, @window.mouse_y) then
        @toTitle = true
      elsif @shopButton.isPushed(@window.mouse_x, @window.mouse_y) then
        @toShop = true
      end

      @levelButtonArray.each do |button|
        if button.isPushed(@window.mouse_x, @window.mouse_y) then
          # LOAD LEVEL CORRESPONDING TO NUM
          # button.num
          # if(button.num == 1)
          # spawn enimys
          return Hash[game:true, level: false]
        end
      end
    end
  end

  def update
    if @toTitle then
      @toTitle = false
      return Hash[title:true, level:false]
    elsif @toShop then
      @toShop = false
      return Hash[shop:true, level:false]
    elsif @toGame then
      @toGame = false
      return Hash[game:true, level: false]
    else
      return Hash[level:true]
    end
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
