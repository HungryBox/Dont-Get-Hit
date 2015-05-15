
require './ZOrder'
require './Dev'

require './Button'
class ShopScreen
  attr_accessor :shopMoney

  attr_reader :gun
  attr_reader :toLevel

  def initialize(window)
    @window = window
    @backButton = Button.new(Dev::LineWidth, Dev::FontHeight,
      Dev::LineWidth/2, Dev::FontHeight/2, "Back", @window,
      ZOrder::UI)
    # Put in ship view
    # Put in vanity box
    # Put in mods box
    @gun = "basic"

    @toLevel = false

    @moneyLabel = Gosu::Font.new(@window, Dev::FontName, Dev::FontHeight)

    @weaponScrollBox = ScrollBox.new(Dev::LineWidth, Dev::FontHeight,
      Dev::LineWidth/2, Dev::FontHeight/2, 3, @window,
      ZOrder::UI, @money)
  end

  def draw
    @backButton.draw

    @moneyLabel.draw("Money: #{@shopMoney}", 500, 10, ZOrder::UI, 1.0, 1.0, Color::WHITE)

    @weaponScrollBox.draw
  end

  def button_down(id)
    case id
    when Gosu::MsLeft then
      if @backButton.isPushed(@window.mouse_x, @window.mouse_y) then
        @toLevel = true
      end
      @weaponScrollBox.button_down(id)
      if @weaponScrollBox.purchase then
        @shopMoney += @weaponScrollBox.moneyChange
      end
    end
  end

  def update
    @weaponScrollBox.money = @shopMoney

    if @toLevel then
      @toLevel = false
      return Hash[level: true, shop:false]
    else
      return Hash[shop:true]
    end
  end
end

class ScrollBox
  attr_writer :money

  attr_reader :moneyChange
  attr_reader :gun
  attr_reader :purchase

  def initialize(width, height, xcenter, ycenter, itemCount, window, zorder, money)
    @width, @height = width, height
    @xcenter, @ycenter = xcenter, ycenter
    @window, @zorder = window, zorder

    @buttonArray = Array.new

    @names = ["Basic", "Trident", "Nova"]
    @price = [10, 20, 30]
    @purchase = false

    for i in 0..itemCount-1
      @buttonArray.push(Button.new(Dev::LineWidth, Dev::FontHeight,
      @window.width/4, Dev::FontHeight*1.5*(i+2), "#{@names[i]}: #{@price[i]}", @window,
      ZOrder::UI))
    end

    @money = money
    @moneyChange = 0
    @gun = "basic"
  end

  def button_down(id)
    @purchase = false
    # for loop with access to index
    case
    when @buttonArray[0].isPushed(@window.mouse_x, @window.mouse_y)
      if @money >= @price[0] then
        @moneyChange = -@price[0]
        @gun = @names[0]
        @purchase = true
      end
    when @buttonArray[1].isPushed(@window.mouse_x, @window.mouse_y)
      if @money >= @price[1] then
        @moneyChange = -@price[1]
        @gun = @names[1]
        @purchase = true
      end
    when @buttonArray[2].isPushed(@window.mouse_x, @window.mouse_y)
      if @money >=@price[2] then
        @moneyChange = -@price[2]
        @gun = @names[2]
        @purchase = true
      end
    end
  end

  def draw()
    @buttonArray.each {|button| button.draw}
  end

  def update()
  end
end
