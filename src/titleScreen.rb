require 'gosu'
require './ZOrder'
require './Dev'


class TitleScreen
  def initialize(window)
    @window = window
    @title = Gosu::Image.from_text(@window, "Dont Get Hit by HungryBox",
     Dev::FontName, 50, 50, 500, :center)
    @playButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width/2, @window.height/2+10, "Play", @window,
      ZOrder::UI)
    @optionButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width/2, @window.height/2+80, "Option", @window,
      ZOrder::UI)
    @creditButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width/2, @window.height/2+150, "Credits", @window,
      ZOrder::UI)

    @toLevel = @toOption = @toCredit = false
  end


  def draw
    x_center = @window.width / 2.0
    @title.draw(x_center-@title.width/2.0,
     @window.height/4.0-@title.height/2.0, ZOrder::UI)

    @playButton.draw
    @optionButton.draw
    @creditButton.draw
  end


  def button_down(id)
    case id
    when Gosu::MsLeft then
      if @playButton.isPushed(@window.mouse_x, @window.mouse_y) then
        @toLevel = true
      elsif @optionButton.isPushed(@window.mouse_x, @window.mouse_y) then
        @toOption = true
      elsif @creditButton.isPushed(@window.mouse_x, @window.mouse_y) then
        @toCredit = true
      end
    end
  end


  def update
    if @toLevel then
      @toLevel = false
      return Hash[title:false, level:true]
    elsif @toOption then
      @toOption = false
      return Hash[title:false, option:true]
    elsif @toCredit then
      @toCredit = false
      return Hash[title:false, credit:true]
    else
      return Hash[title: true]
    end
  end
end
