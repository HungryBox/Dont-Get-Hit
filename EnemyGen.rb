require 'gosu'

class EnemyGen
  def initialize(window, fileName)
    @window = window
    @gameFile = IO.read("#{fileName}")
    @gameFile.each_line(";"){|line| genNext(line)}

  end

  def genNext(line)
    # puts "#{line}"
    eType = "pls work"
    eT = 0
    eX = 0
    eY = 0
    exDone = false
    eyDone = false
    gameArray = line.split(",")
    puts gameArray
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
      puts "#{eType},#{eX},#{eY},#{eT}"
      puts "\n"
  end

end

window = Gosu::Window.new(800,600,false)
enemyGen = EnemyGen.new(window,"levelOne.txt")
