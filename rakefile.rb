task :default => [:build]

task :build do
   ruby "src/DontGetHit.rb"
end
