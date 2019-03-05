require 'open-uri'
require 'json'


class Scraping

  @@per_page = 30

  def initialize(query="")
    @page = 1
    @query = query
    @results = []
    @finish_scraping = false
    @total = 0
    @total_pages = 0;
  end

  def clear(query="")
    @page = 1
    @query = query
    @result = []
  end  

  def scrape 
    set_page

    puts "query: #{@query}, total pages: #{@total_pages}, total: #{@total}"
    
#    @total_pages = 2
    (1..@total_pages).each { |i| 
      @page = i
      puts i

      data = scrape_page
      result = data["results"]
      @results += result 
    }

    puts "before remove duplicats"
    puts @results.length
    puts "remove duplicates"
    puts @results!.uniq! { |h| h["id"] }
    puts "finish scraping!, crawled data #{@results.length}"

    ## TODO: remove duplicate ?

    save_data_to_file
  end

  def set_page
    url = "https://unsplash.com/napi/search/photos?query=#{@query}&per_page=#{@@per_page}"
    res = JSON.parse(open(url).read)
    
    @results = []
    @total = res["total"]
    @total_pages = res["total_pages"]
  end

  def format_results
    # {
    #   query: @query,
    #   total: @total,
    #   total_pages: @total_pages,
    #   results: @results
    # }

    @results.map! do |x|
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
    
    hash = Hash.new

    hash[@query] = @results 
    hash    
  end

  def save_data_to_file 
    filename = "#{@query}.json"
    open(filename, "w").write(format_results.to_json)
  end

  def scrape_page
    url = "https://unsplash.com/napi/search/photos?query=#{@query}&per_page=#{@@per_page}&page=#{@page}"        
#    puts url
    sleep 0.1
    JSON.parse(open(url).read)
  end   
end 

# format 
# {"total":4912,"total_pages":164,"results":[{"id...]}

#scrape = Scraping.new("dog");
#scrape.scrape


target = ["Cat", "Chicken", "Bear", "Pig",
"Lion", "Snake", "Wolf", "Rabbit", "Deer", "Horse", "Cow", "Monkey", 
"Ape", "Eagle", "Dolphin", "Tiger", "Elephant", "Turtle", "Jellyfish", "Giraffe'",
"Puppy" ]

# suggest: mammal, puppy

# collection

# mammal 50.3k
# dog 19.5k
# puppy 2.1k
# exclude: "Bird", "Animal", "Wildlife", "Fish" "dog"

target.each do |t| 
  puts t
  unless File.exist?("#{t}.json") 
    puts "not exist"
    scrape = Scraping.new(t);
    scrape.scrape    
  end
end 