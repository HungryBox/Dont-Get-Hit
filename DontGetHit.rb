# Optimize requires once program functions in its final alpha form
require 'gosu'
require './ZOrder'
require './Color'
require './SpacePlayer'
require './Enemy'
require './Bullet'

# Becomes core for program/ Rename to DGH
class TitleWindow < Gosu::Window
  # Initializes the program
  def initialize
    # Establishes window size
    super(800, 600, false)
    # Titles the window
    self.caption = "Don't Get Hit"
    # Sets background image
    @background_image = Gosu::Image.new(self, "media/Space.png", true)
    # Creates the game title a placeholder for an image
# TITLE WINDOW INIT
    @title = Gosu::Image.from_text(self, "Dont Get Hit by Armada",
     Gosu::default_font_name, 50, 50, 500, :center)
    # Sets playbutton image
    @playImage = Gosu::Image.new(self, "media/PlayButton.png", false)
    # Sets creditbutton image
    @creditImage = Gosu::Image.new(self, "media/CreditButton.png", false)

    # Sets elements to be displayed as titleWindow
    @titleWindow = true
    # Sets all other window types to false
    @creditWindow = @playWindow = @deathWindow = false


# GAME WINDOW INIT
    @player = SpacePlayer.new(self, self.width/2.0, self.height/2.0)
    @enemies = Array.new
    @playerBullets = Array.new
    @enemyBullets = Array.new


# DEATH WINDOW INIT
    @deathImage = Gosu::Image.new(self, "media/deathMessage.png", false)
    @playAgainImage = Gosu::Image.new(self, "media/playAgainButton.png", false)
    @exitImage = Gosu::Image.new(self, "media/exitButton.png", false)

# CREDITS WINDOW INIT
    @credits = Gosu::Image.from_text(self, "Ian is the best, David, George sux",
     Gosu::default_font_name, 50, 50, 500, :center)
  end

  # Draws the programs elements
  def draw
    # Draws the background elements for the entire program
    @background_image.draw(0,0, ZOrder::Background)

    # Values for aligning elements on screen in draw operations
    x_center = self.width / 2.0
    y_center = self.height / 2.0

    # If the current window is a title window then the titleWindow
    # elements are drawn
    if @titleWindow then
      # Draws the title image
      @title.draw(x_center-@title.width/2.0,
       self.height/4.0-@title.height/2.0, ZOrder::UI)
      # Draws the playButton image
      @playImage.draw(x_center-@playImage.width/2.0,
       y_center-20, ZOrder::UI)
      # Draws the creditButton image
      @creditImage.draw(x_center-@creditImage.width/2.0,
       y_center+80, ZOrder::UI)
    elsif @creditWindow then #Draws credit window elements
      @credits.draw(0,0,ZOrder::UI)
# BUG_2: Hitting the play button takes a couple seconds to load the game
# BUG_3: Hitting play after losing a game wont allow for a new game to happen
    elsif @playWindow then #Draws play window elements
      @player.draw
      @enemies.each { |enemy| enemy.draw }
      @playerBullets.each { |bullet| bullet.draw }
      @enemyBullets.each { |bullet| bullet.draw }
    elsif @deathWindow then #Draws death window elements
      @enemies.each { |enemy| enemy.draw }
      @playerBullets.each { |bullet| bullet.draw }
      @enemyBullets.each { |bullet| bullet.draw }

      @deathImage.draw(x_center-@deathImage.width/2.0, y_center-250, ZOrder::UI)
      @playAgainImage.draw(x_center-@playAgainImage.width/2.0, y_center+50, ZOrder::UI)
      @exitImage.draw(x_center-@exitImage.width/2.0, y_center+130, ZOrder::UI)
    else #If an exception is thrown and no windows should be shown, program closes
      self.close
    end
  end

  def update
    # If the user presses esc brings back to title, otherwise exits
# BUG_1: Pressing esc happens so fast that it always ends up exiting
# Potential Fix: Put a timer on reading next command i.e. cooldown
    if button_down? Gosu::KbEscape then
      # if !@titleWindow then
      #   @creditWindow = @playWindow = @deathWindow = false
      #   @titleWindow = true
      # else
        self.close
      # end
    end

# Temporary workaround to BUG_1
    if button_down? Gosu::KbTab then
      if !@titleWindow then
        @creditWindow = @playWindow = @deathWindow = false
        @titleWindow = true
      end
    end

    # Reads these inputs and changes values iff the current window is
    # a title window
    if @titleWindow then
      if button_down? Gosu::MsLeft then
        #Mouse is down and on @playImage
        if self.mouse_x >= self.width/2.0-@playImage.width/2.0 and
          self.mouse_x <= self.width/2.0+@playImage.width/2.0 then
          if self.mouse_y >= self.height/2.0-20 and
          self.mouse_y <= self.height/2.0-20+@playImage.height then
            @titleWindow = false
            @playWindow = true
            @replay = true
          end
        end

        # Mouse is down and on @creditImage
        # Mouse is on the correct x-axis
        if self.mouse_x >= self.width/2.0-@creditImage.width/2.0 and
          self.mouse_x <= self.width/2.0+@creditImage.width/2.0 then
          # Mouse is on the correct y-axis
          if self.mouse_y >= self.height/2.0+80 and
          self.mouse_y <= self.height/2.0+80+@creditImage.height/2.0 then
            # No longer title window
            @titleWindow = false
            # Now it's the credits window
            @creditWindow = true
          end
        end
      end
    elsif @playWindow then
      if @replay then
        @player = SpacePlayer.new(self, self.width/2.0, self.height/2.0)
        @enemies = Array.new
        @playerBullets = Array.new
        @enemyBullets = Array.new
        @replay = false
      end

      if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
        @player.accelLeft
      end
      if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
        @player.accelRight
      end
      if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
        @player.accelForward
      end
      if button_down? Gosu::KbDown or button_down? Gosu::GpButton1 then
        @player.accelBackward
      end
      if button_down? Gosu::KbSpace or button_down? Gosu::GpButton2 then
        @playerBullets.push(@player.shoot)
      end

      @player.move
      @player.checkCollide(@enemyBullets)

      if @player.isKill then
        @playWindow = false
        @deathWindow = true
      end

      @enemies.delete_if do |enemy|
        enemy.outofBounds or
        enemy.checkCollide(@playerBullets)
      end

      @playerBullets.delete_if { |bullet| bullet.outofBounds }
      @enemyBullets.delete_if { |bullet| bullet.outofBounds }

      @enemies.each do |enemy|
        enemy.move
        bullet = enemy.shoot
        if bullet.is_a?(Bullet) then
          @enemyBullets.push(bullet)
        end
      end

      @playerBullets.each { |bullet| bullet.move }
      @enemyBullets.each { |bullet| bullet.move }





      #old code for random Enemies
      # if @enemies.size < 100 then
      #   @enemies.push(Enemy.new(self, rand(self.width), 0))
      # end

    elsif @deathWindow then
      @enemies.delete_if do |enemy|
        enemy.outofBounds or
        enemy.checkCollide(@playerBullets)
      end

      @playerBullets.delete_if { |bullet| bullet.outofBounds }
      @enemyBullets.delete_if { |bullet| bullet.outofBounds }

      @enemies.each do |enemy|
        enemy.move
        bullet = enemy.shoot
        if bullet.is_a?(Bullet) then
          @enemyBullets.push(bullet)
        end
      end

      @playerBullets.each { |bullet| bullet.move }
      @enemyBullets.each { |bullet| bullet.move }

      # Include support for pressing exit and pressing play again
      if button_down? Gosu::MsLeft then
        # If play again is pressed, new game instance is created
        if self.mouse_x >= self.width/2.0-@playAgainImage.width/2.0 and
          self.mouse_x <= self.width/2.0+@playAgainImage.width/2.0 then
          # Mouse is on the correct y-axis
          if self.mouse_y >= self.height/2.0+50 - @playAgainImage.height/2.0 and
          self.mouse_y <= self.height/2.0+50 + @playAgainImage.height/2.0 then
            # Reset level???
            @replay = true


            # No longer death window
            @deathWindow = false
            # Now it's the play window
            @playWindow = true
          end
        end
        # If exit is pressed, user is taken back to title screen
        if self.mouse_x >= self.width/2.0-@exitImage.width/2.0 and
          self.mouse_x <= self.width/2.0+@exitImage.width/2.0 then
          # Mouse is on the correct y-axis
          if self.mouse_y >= self.height/2.0+130 - @exitImage.height/2.0 and
          self.mouse_y <= self.height/2.0+130 + @exitImage.height/2.0 then
            # No longer death window
            @deathWindow = false
            # Now it's the title window
            @titleWindow = true
          end
        end
      end
    end
  end


  def readFile
      levelString = File.open("LevelOne.txt" , "r"){|levelOne| levelGen.read}
      s = StringScanner.new(levelString)
  end
  def readGenEnemy (s)#make catch if bigger than 999
    type = s.scan(/(.)/)
    ex = s.scan(/^\d\d{2}?)/)
    ey = s.scan(/(\d\d{2}?)/)
  end
        # levelChar = levelString.each_char #contense: l 1 , 1 0 , 0 , E
        # if levelChar.next == 'l' then
        #   @LevelNum = levelChar.next
        #   levelChar.next
        # if levelChar.next


  # User cursor appears on the screen
  def needs_cursor?
    true
  end
end

# Instantiates the object and runs the program
window = TitleWindow.new()
window.show
