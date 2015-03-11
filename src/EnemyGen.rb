require 'gosu'

require './Enemy'

class EnemyGen

  attr_reader :enemies

  def initialize(window, fileName)
    @window = window
    @enemies = Array.new
    fileName = "../Level/"+fileName
    @gameFile = IO.read(fileName)
    @gameFile.each_line("\n"){|line| genNext(line)}
  end

private
  def genNext(line)
    eType = "pls work"
    eT = 0
    eX = 0
    eY = 0
    exDone = false
    eyDone = false
    gameArray = line.split(",")
    gameArray.each do |pos|
      if pos == "E" then
        eType = pos
        next
      end
      if !exDone then
        if pos.to_i < @window.width then
          eX = pos.to_i
          #puts pos
          exDone = true
          next
        end
      end
      if !eyDone then
        if pos.to_i < @window.height then
          eY = pos.to_i
          #puts pos
          eyDone = true
          next
        end
      end
      eT = pos
      #bputs pos
    end

      @enemies.push(Enemy.new(@window, eX, eY, eT))
  end
end
