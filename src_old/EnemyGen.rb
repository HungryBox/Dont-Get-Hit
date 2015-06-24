require_relative './Enemy'
require_relative './SideWinderEnemy'

class EnemyGen

  attr_reader :enemies

  def initialize(window, fileName)
    @window = window
    @enemies = Array.new
    fileName = File.dirname(__FILE__)+"/../Level/"+fileName
    @gameFile = IO.read(fileName)
    @gameFile.each_line("\n"){|line| genNext(line)}
  end

private
  def genNext(line)
    gameArray = line.split(",")
    case gameArray[0]
    when "E"
      @enemies.push(Enemy.new(@window, gameArray[1].to_i,
        gameArray[2].to_i, gameArray[3].to_i))
    when "S"
      @enemies.push(SideWinderEnemy.new(@window,
        gameArray[1].to_i, gameArray[2].to_i, gameArray[3].to_i))
    end
  end

  # def genNext(line)
  #   eType = "pls work"
  #   eT = 0
  #   eX = 0
  #   eY = 0
  #   exDone = false
  #   eyDone = false
  #   gameArray = line.split(",")
  #   gameArray.each do |pos|
  #     if pos == "E" then
  #       eType = pos
  #       next
  #     end
  #     if !exDone then
  #       if pos.to_i < @window.width then
  #         eX = pos.to_i
  #         exDone = true
  #         next
  #       end
  #     end
  #     if !eyDone then
  #       if pos.to_i < @window.height then
  #         eY = pos.to_i
  #         eyDone = true
  #         next
  #       end
  #     end
  #     eT = pos
  #   end

  #     @enemies.push(Enemy.new(@window, eX, eY, eT))
  # end
end