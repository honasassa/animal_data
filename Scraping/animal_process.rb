require 'json'

curation_data = []

name = "Animal.json"
data = JSON.parse(open(name).read)

results = data[name[0...-5]]

puts results.length

results.select! {|d| d['likes'] >= 50}
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

puts results.length

curation_data += results

puts curation_data.length

curation = {
  "Animal": curation_data 
}

puts "now writing"
open("Animal_Curation.json", "w").write(curation.to_json)

puts "finished"