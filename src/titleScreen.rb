require 'gosu'
require './ZOrder'

# SO I CAN MOVE ELEMENTS TO A CLASS TO BE INITIALIZED AND DRAWN
# BUT I NEED TO MAKE A BUTTON CHECK FUNCTIO

class TitleScreen
  def initialize(window)
    @window = window
    @title = Gosu::Image.from_text(@window, "Dont Get Hit by Armada",
     Gosu::default_font_name, 50, 50, 500, :center)
    # Sets playbutton image
    @playImage = Gosu::Image.new(@window, "../media/PlayButton.png", false)
    # Sets creditbutton image
    @creditImage = Gosu::Image.new(@window, "../media/CreditButton.png", false)
  end

  def draw
    x_center = @window.width / 2.0
    y_center = @window.height / 2.0
   # Draws the title image
    @title.draw(x_center-@title.width/2.0,
     @window.height/4.0-@title.height/2.0, ZOrder::UI)
    # Draws the playButton image
    @playImage.draw(x_center-@playImage.width/2.0,
     y_center-20, ZOrder::UI)
    # Draws the creditButton image
    @creditImage.draw(x_center-@creditImage.width/2.0,
     y_center+80, ZOrder::UI)
  end

  # def update
  #   if button_down? Gosu::MsLeft then
  #       #Mouse is down and on @playImage
  #       if @window.mouse_x >= @window.width/2.0-@playImage.width/2.0 and
  #         @window.mouse_x <= @window.width/2.0+@playImage.width/2.0 then
  #         if @window.mouse_y >= @window.height/2.0-20 and
  #         @window.mouse_y <= @window.height/2.0-20+@playImage.height then
  #           @titleWindow = false
  #           @playWindow = true
  #           @replay = true
  #         end
  #       end

  #       # Mouse is down and on @creditImage
  #       # Mouse is on the correct x-axis
  #       if @window.mouse_x >= @window.width/2.0-@creditImage.width/2.0 and
  #         @window.mouse_x <= @window.width/2.0+@creditImage.width/2.0 then
  #         # Mouse is on the correct y-axis
  #         if @window.mouse_y >= @window.height/2.0+80 and
  #         @window.mouse_y <= @window.height/2.0+80+@creditImage.height/2.0 then
  #           # No longer title window
  #           @titleWindow = false
  #           # Now it's the credits window
  #           @creditWindow = true
  #         end
  #       end
  #   end
  # end
end
