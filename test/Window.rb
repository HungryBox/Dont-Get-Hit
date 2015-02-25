require 'gosu'
require_relative '../src/Dev'
require_relative '../src/Button'

class Window < Gosu::Window
  def initialize
    super(500, 500, false)

    @last_time = @seconds = 1

    @ship1 = Gosu::Image.new(self, "../media/Enemyship.bmp", false)
    @ship2 = Gosu::Image.new(self, "../media/StarFighter.bmp", false)

    @shipSwitch = true

    @button = Button.new(100,100,50,50,"Hello", self, ZOrder::UI)

    self.caption = "Button Testing"
  end

  def draw
    @button.draw

    if @shipSwitch then
      @ship1.draw(self.width/2, self.height/2, 1)
    else
      @ship2.draw(self.width/2, self.height/2, 1)
    end
  end

  def update
    if button_down? Gosu::KbEscape then
      self.close
    end

    # timer test
    if button_down? Gosu::MsLeft then
      if @button.isPushed(self.mouse_x, self.mouse_y) then
        if (Gosu::milliseconds - @last_time) / 1000 >= 0.5
          @seconds += 1
          @last_time = Gosu::milliseconds()
        end

        if @seconds >= 1 then
          @shipSwitch = !@shipSwitch
          @seconds = 0
        end
      end
    end
  end

  def needs_cursor?
    true
  end
end

window = Window.new
window.show


