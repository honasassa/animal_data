require 'json'

files = Dir.entries(".")

targets = files.select {|f| f.end_with?(".json")}
targets = targets.reject {|f| f == "db.json"}
targets = targets.reject {|f| f == "Animal.json"}


puts targets.length

json_data = {}

targets.each do |t|
  puts t 
  json_data.merge!(JSON.parse(open(t).read))
end

puts "now writing"
open("db.json", "w").write(json_data.to_json)

puts "finished"