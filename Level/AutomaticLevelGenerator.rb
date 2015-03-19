filePath = "levelFive.txt"

f = File.open(filePath, 'w')

LevelTimeTot = 30 * 1000

winWidth = 800
winHeight = 600

ETot = 200
STot = 200

for i in 1..ETot
  x = rand(winWidth)
  t = LevelTimeTot/i
  f.puts "E,#{x},0,#{t}"
end

for i in 1..STot
  x = 0
  if rand(2) == 1 then
    x = winWidth
  end
# Sidewinder height has to be less than (height - 100)
  y = rand(winHeight-100)
  t = LevelTimeTot/i
  f.puts "S,#{x},#{y},#{t}"
end

puts "Done!"
