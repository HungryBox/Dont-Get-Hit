require 'gosu'
require './ZOrder'
require './Bullet'

# Creates a basic enemy that moves down the screen and shoots predictably
class Enemy
	# Initializes an enemy at given x, y with given window
	def initialize(window, x, y)
		# Establishes sprite for enemy
		@image = Gosu::Image.new(window, "../media/Enemyship.bmp", false)
		# Initializes x,y, downward velocity, and ship angle
		@x, @y = x, y
		@vel = 1
		@angle = 180

		# Stores distance from last shot
		@lastShot = 0
		# Stores position of the last time the ship shot a bullet
		@lastPosX, @lastPosY = 0, 0

		# Stores window
		@window = window

		# Defines the distance between shots
		@SHOT_LAG = 100
	end

	# Changes ship position to given x,y
	def warp(x, y)
		@x, @y = x, y
	end

	# Moves ship by given x-y-velocity values
	# Use this command in conjunction with warp and change the angle
	# to create weird flight paths like a sine wave
	def move
		@x += 0
		@y += @vel
	end

	# Returns a boolean if the ship is out of the window bounds
	def outofBounds
		if @x > @window.width || @y > @window.height || @x < 0 || @y < 0 then
			return true
		end
		return false
	end

	# Draws the ship with its given rotation
	def draw
		@image.draw_rot(@x, @y, ZOrder::Enemy, @angle)
	end

	# Returns a bullet to be shot with velocity
	def shoot
		# Updates last shot distance if it can't shoot
		if @lastShot <= @SHOT_LAG then
			@lastShot = Gosu::distance(@x, @y, @lastPosX, @lastPosY)
		else
			# Preps a new bullet and resets last shot distance
			@lastShot = 0
			@lastPosX = @x
			@lastPosY = @y
			# returns a bullet with a velocity 1 greater than the ship's
			# velocity
			return Bullet.new(@window, @x, @y, 0, @vel+1, false)
		end
	end

	# Returns true if any playerbullets match the ship's current location
	# within a 10 pixel distance
	def checkCollide(playerBullets)
		# Removes the bullet that shot the ship
		playerBullets.reject! do |bullet|
			if Gosu::distance(@x, @y, bullet.x, bullet.y) <= 10 then
				true
			else
				false
			end
		end
	end
end

