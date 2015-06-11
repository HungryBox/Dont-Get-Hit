require_relative './ZOrder'
require_relative './Dev'
require_relative './Bullet'

# Creates a basic enemy that moves down the screen and shoots predictably
class Enemy
	attr_reader :x, :y, :spawnTime
	# Initializes an enemy at given x, y with given window
	def initialize(window, x, y, spawnTime)
		# Establishes sprite for enemy
		@image = Gosu::Image.new(window, File.dirname(__FILE__)+"/../media/Enemyship.bmp", false)
		# Initializes x,y, downward velocity, and ship angle
		@x, @y, @spawnTime = x, y, spawnTime
		@velx = 0
		@vely = Dev::SimpleEnemyVelocity
		@angle = 180

		# Stores window
		@window = window

		@lastTime = @milliseconds = 1000

		# Defines the distance between shots
		@SHOT_LAG = Dev::SimpleEnemyShotLag
	end

	# Changes ship position to given x,y
	def warp(x, y)
		@x, @y = x, y
	end

	# Moves ship by given x-y-velocity values
	# Use this command in conjunction with warp and change the angle
	# to create weird flight paths like a sine wave
	def move
		@x += @velx
		@y += @vely
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
		if (Gosu::milliseconds - @lastTime) >= 1 then
			@milliseconds += 1
			@lastTime = Gosu::milliseconds()
		end

		if @milliseconds >= @SHOT_LAG then
			@milliseconds = 0
			return Bullet.new(@window, @x, @y, 0, @vely+Dev::SimpleEnemyAdditionalBulletSpeed, false)
		end
	end

	# Returns true if any playerbullets match the ship's current location
	# within a 10 pixel distance
	def checkCollide(playerBullets)
		# Removes the bullet that shot the ship
		playerBullets.reject! do |bullet|
			if Gosu::distance(@x, @y, bullet.x, bullet.y) <= Dev::SimpleEnemyHitBox then
				true
			else
				false
			end
		end
	end
end

