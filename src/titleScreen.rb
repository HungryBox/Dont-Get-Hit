require 'gosu'
require './ZOrder'
require './Dev'


class TitleScreen
  def initialize(window)
    @window = window
    @title = Gosu::Image.from_text(@window, "Dont Get Hit by Armada",
     Dev::FontName, 50, 50, 500, :center)
    @playButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width/2, @window.height/2-20, "Play", @window,
      ZOrder::UI)
    @creditButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width/2, @window.height/2+80, "Credits", @window,
      ZOrder::UI)
  end

  def draw
    x_center = @window.width / 2.0
    @title.draw(x_center-@title.width/2.0,
     @window.height/4.0-@title.height/2.0, ZOrder::UI)

    @playButton.draw
    @creditButton.draw
  end

  def update
    if @window.button_down? Gosu::MsLeft then
      if @playButton.isPushed(@window.mouse_x, @window.mouse_y) then
        return Hash[title:false, game:true]
      elsif @creditButton.isPushed(@window.mouse_x, @window.mouse_y) then
        return Hash[title:false, credit:true]
      end
    end
    return Hash[title:true, game:false, credit:false]
  end
end
