require 'gosu'

require './Dev'
require './ZOrder'

class Button
  def initialize(width, height, xcenter, ycenter, text, window, zorder)
    @width = width
    @height = height
    @xcenter = xcenter
    @ycenter = ycenter
    # @image = image?
    @text = text
    @font = Dev::FontSize
    @window = window

    @image = Gosu::Image.from_text(@window, @text,
      Dev::FontName, Dev::FontHeight)

    @zorder = zorder
  end

  def draw
    @image.draw(@xcenter, @ycenter, @zorder)
  end

  def isPushed(mx, my)
    if mx >= @xcenter - @width/2.0 and mx <= @xcenter + @width/2.0 then
      if my >= @ycenter - @height/2.0 and my <= @ycenter + @height/2.0 then
        return true
      end
    end
    return false
  end
end
