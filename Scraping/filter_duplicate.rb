require 'json'

files = Dir.entries(".")

targets = files.select {|f| f.end_with?(".json")}
targets = targets.reject {|f| f == "db.json"}
##targets = targets.reject {|f| f == "Animal.json"}
##targets = targets.reject {|f| f == "Bird.json"}

puts targets
puts targets.length

json_data = {}

targets.each do |t|
  puts t 

  data = JSON.parse(open(t).read)

  puts "open.json"[0...-5]
  results = data[t[0...-5]]

  puts results.length

  results.uniq! { |h| h["id"] }

  puts results.length

  results.map! do |x|
    {
      id: x["id"],
      created_at: x["created_at"],
      updated_at: x["updated_at"],
      height: x["height"],
      width: x["width"],
      description: x["description"],
      urls: x["urls"],
      links: x["links"],
      likes: x["likes"]
    }
  end

  open("./process/#{t}", "w").write(data.to_json)
end

