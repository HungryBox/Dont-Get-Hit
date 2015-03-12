filePath = "levelThree.txt"

f = File.open(filePath, 'w')

LevelTimeTot = 20 * 1000

winWidth = 800
winHeight = 600

ETot = 50
STot = 25

for i in 1..ETot
  x = rand(winWidth)
  t = LevelTimeTot/i
  f.puts "E,#{x},0,#{t}"
end

for i in 1..STot
  x = 0
  if rand(1) > 0 then
    x = winWidth
  end
# Sidewinder hieght has to be less than height - 100
  y = rand(winHeight)
  t = LevelTimeTot/i
  f.puts "S,#{x},#{y},#{t}"
end

puts "Done!"
