#API
  # Application Programming Interface


  require 'net/http'
  require 'json'

url = URI("https://rickandmortyapi.com/api/character/1")
response = Net::HTTP.get(url)
data = JSON.parse(response)

# pp data["setup"]
# pp data
# pp data["episode"]
data["episode"].each_with_index do|episode, n|
  puts "#{n + 1}. #{episode}"
#   if episode.length >= 5

    # puts episode.length 
#     n += 1
#     puts "#{n + 1}: #{episode}"
#   end 
    
  
  
end 
