require 'gosu'
require './ZOrder'
require './Dev'

class Coin
  attr_reader :x, :y

  def initialize(window, x, y)
    @window = window
    @x, @y = x, y

    @image = Gosu::Image.new(window, "../media/Coin.png", false)

    @vel = Dev::CoinVelocity
  end

  def move
    @y += @vel
  end

  def outofBounds
    if @x > @window.width || @y > @window.height || @x < 0 || @y < 0 then
      return true
    end
    return false
  end

  def draw
    @image.draw(@x-@image.width/2, @y-@image.height/2, ZOrder::Coin)
  end

  def checkCollide(player)
    if Gosu::distance(player.x, player.y, @x, @y) < Dev::CoinHitBox then
      true
    else
      false
    end
  end
end
