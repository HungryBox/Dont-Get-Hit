require_relative'./ZOrder'
require_relative'./Dev'

require_relative'./Button'

class OptionScreen
  def initialize(window)
    @window = window
    @backButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width/2, @window.height/5*4, "Back", @window,
      ZOrder::UI)

    @toTitle = false
  end

  def draw
    @backButton.draw
  end

  def button_down(id)
    case id
    when Gosu::MsLeft then
      if @backButton.isPushed(@window.mouse_x, @window.mouse_y) then
        @toTitle = true
      end
    end
  end

  def update
    if @toTitle then
      @toTitle = false
      return Hash[title:true, option:false]
    else
      return Hash[option:true]
    end
  end
end
