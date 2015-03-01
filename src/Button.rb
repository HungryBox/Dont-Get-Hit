require 'gosu'

require_relative './Dev'
require_relative './ZOrder'

# Incorporate feature to allow for polymorphism if i pass an image or text

class Button
  def initialize(width, height, xcenter, ycenter, text, window, zorder)
    @width = width
    @height = height
    @xcenter = xcenter
    @ycenter = ycenter
    @text = text
    @font = Dev::FontSize
    @window = window

    @image = Gosu::Image.from_text(@window, @text,
      Dev::FontName, Dev::FontHeight, Dev::LineSpacing,
      Dev::LineWidth, Dev::TextAlign)

    @zorder = zorder
  end

  def draw
    @window.draw_quad(@xcenter-@width,@ycenter-@height,Dev::ButtonColor,
      @xcenter+@width,@ycenter-@height,Dev::ButtonColor,
      @xcenter-@width,@ycenter+@height,Dev::ButtonColor,
      @xcenter+@width,@ycenter+@height,Dev::ButtonColor,
      ZOrder::ButtonBacker)
    @image.draw(@xcenter-@width/2, @ycenter-@height/2, @zorder)
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
