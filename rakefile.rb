task :default => [:build]

task :build do
   ruby "src/Game.rb"
end

task :build_old do
  ruby "src_old/DontGetHit.rb"
end

task :windows do
  ruby "media/test.rb"
end
