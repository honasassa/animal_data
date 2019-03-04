require 'json'

files = Dir.entries(".")

targets = files.select {|f| f.end_with?(".json")}
targets = targets.reject {|f| f == "db.json"}
targets = targets.reject {|f| f == "Curation.json"}

puts targets.length

curation_data = []

targets.each do |t|
  puts t 
#  json_data.merge!(JSON.parse(open(t).read))

  data = JSON.parse(open(t).read)

  results = data[t[0...-5]]

  puts results.length

  results.select! {|d| d['likes'] >= 50}

  puts results.length

  curation_data += results
end

puts curation_data.length

curation = {
  "Curation": curation_data 
}

puts "now writing"
open("Curation.json", "w").write(curation.to_json)

puts "finished"