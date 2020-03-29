require 'byebug'

states = open('states.csv').map {|i| i.split.first}

h = {}
count = 0
for s in states 
  files = `ls data/#{s.downcase}`.split("\n")
  for file in files
    filename = "data/#{s.downcase}/#{file}"
begin
    hash = `md5 #{filename}`.split('=').last.strip
rescue
next
end
    if h[hash]
      count += 1
      puts "#{count}/#{h.size} deletiing: #{filename}"
      `rm #{filename}`
    else
      h[hash] = true
    end
  end
end
