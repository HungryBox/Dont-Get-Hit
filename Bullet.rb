require 'gosu'

# A class to represent a basic bullet
class Bullet
		# Allows the x and y components to be read by other objects
		attr_reader :x, :y

		# Initializes a bullet with the window, x, y, x-velocity, y-velocity, and
		# playerBullet boolean(determines bullet color)
		def initialize(window, x, y, vel_x, vel_y, playerBullet)
			# Creates class variables and initializes them
			@x, @y = x, y
			@window = window
			@vel_x, @vel_y = vel_x, vel_y

			# Creates a string to save filepath for image
			string = ""

			# Could later be changed to a case string to represent other bullet types
			# or even be determined in the bullet class
			# Assigns filepath to string
			if(!playerBullet) then
				string = "media/EnemyBullet.bmp"
			else
				string = "media/PlayerBullet.bmp"
			end
			# Creates image from string filepath
			@image = Gosu::Image.new(window, string, false)
		end

		# Changes bullet position to given x,y
		def warp(x, y)
			@x, @y = x, y
		end

		# Moves bullet position by given x-y-velocity values
		def move
			@x += @vel_x
			@y += @vel_y
		end

		# Draws bullet without rotation from center point of x,y
		def draw
			@image.draw(@x - @image.width/2.0, @y - @image.height/2.0, ZOrder::Bullet)
		end

		# returns a boolean if the bullet is out of the window bounds
		def outofBounds
			if @x > @window.width || @y > @window.height || @x < 0 || @y < 0 then
				return true
			end
			return false
		end
end
