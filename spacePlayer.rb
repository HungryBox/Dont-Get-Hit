require 'gosu'

# A class to represent a basic player
class SpacePlayer
  # Allows other classes to read if the player is kill
  attr_reader :isKill

  # Initializes a player with the window, x, y
  def initialize (window, x, y)
    # Establishes a sprite for the palyer
    @image = Gosu::Image.new(window, "media/Starfighter.bmp", false)
    # Initializes the x,y and last position
    @x, @y = x, y
    @lastPosX = @lastPosY = @lastShot = 0
    # Initializes x-y-velocity
    @vel_x = @vel_y = 0
    # Stores instance of window
    @window = window
    # Establishes constant velocity for x and y directions
    @VELOCITY = 3
    # Boolean which measures if the ship is dead or not
    @isKill = false
  end

  # Changes the ship position to given x,y
  def warp(x, y)
    @x, @y = x, y
  end

  # Changes the x velocity by VELOCITY to the left
  def accelLeft
    @vel_x -= @VELOCITY
  end

  # Changes the x velocity by VELOCITY to the right
  def accelRight
    @vel_x += @VELOCITY
  end

  # Changes the y velocity by VELOCITY upwards
  def accelForward
    @vel_y -= @VELOCITY
  end

  # Changes the y velocity by VELOCITY downwards
  def accelBackward
    @vel_y += @VELOCITY
  end

  # Moves the ship based on x-y-vel values
  def move
    # Stores change in x and y position based off of vel and current x,y
    newX = @x + @vel_x
    newY = @y + @vel_y
    # Prevents ship from exiting bounds in x along the ship's edge
    if newX >= @image.width and newX <= @window.width-@image.width then
      @x += @vel_x
    end
    # Prevents ship from exiting bounds in y along the ship's edge
    if newY >= @image.height and newY <= @window.height-@image.height then
      @y += @vel_y
    end
    # Slows down the ship if no new input is given
    # Lower values for tighter controls
    @vel_x *= 0.50
    @vel_y *= 0.50
  end

  # Draws the ship centered on the x, y
  def draw
    @image.draw(@x - @image.width/2.0, @y - @image.height/2.0, ZOrder::Player)
  end

  # Returns a bullet to be shot with velocity of 2 upwards
  def shoot
      return Bullet.new(@window, @x, @y, 0, -2, true)
  end

  # Changes isKill to true if any enemyBullets match the ship's current location
  # within a 5 pixel distance
  def checkCollide(enemyBullets)
    enemyBullets.each do |bullet|
      if Gosu::distance(bullet.x, bullet.y, @x, @y) < 5
        @isKill = true
      end
    end
  end

end
