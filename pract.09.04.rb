# OOP

#abstraction

  

#DRY
 # Do not Repeat Yourself

  # class Coffeemachine
  #   def make_coffee(type)
  #     boil_water
  #     brew_coffee(type)

  #   end 
    

  #   private 
  #   def boil_water
  #     puts "Boiling water..."
  #   end

  #   def brew_coffee(type)
  #     puts "brewing #{type} coffee.."
  #   end 
    
  # end 



 #encapsulation






#  class Car
#   def car_type(type, speed)
#     puts " This car is a #{type} "
#     car_max_speed(speed)
#     rim_dimensions

#   end 


#   private

#   def car_max_speed(speed)
#     puts "max speed: #{speed}"
#   end

#   def lugnut_size
#     puts "size fit is: 12in."

#   end

#   def rim_dimensions
#     puts " All 19in rims."
#   end 


#  end 

#  car = Car.new
#  car.car_type("Taco", 250)

#  class MusicPlayer
#   def play(track)
#     open_file(track)
#     puts "Now playing song: #{track}."
#     log_play
#   end 

#   private

#   def open_file(track)
#     puts "opening file containing song:.."
#   end 

  
#   def start_stream
#     puts "Streaming song..."
#   end 
  
#   def log_play
#     puts "logging play time.."

#   end 
#  end 

# mp3 = MusicPlayer.new
# mp3.play("Sunshine")

# Exercise: Movie Watchlist CLI — Abstraction + Encapsulation + File I/O
# Goal:

# - Build a CLI to manage a list of movies in a JSON "database".
# - Keep file I/O and ID generation hidden behind private methods.
# - The CLI should ONLY use the class's public methods.


require 'json'

class MovieWatchlist
  def initialize(file_name = "watchlist.json")
    @file_name = file_name
    @movies = []    
     # structure: [{ id: 1, title: "Inception", watched: false }, ...]


    load_database    # TODO: implement this as a private method
  end

  # ---------------- Public API (abstraction) ----------------

  # Add a new movie by title.
  def add_movie(title)
    # TODO:
    # - Build a new movie hash: { id: next_id, title: title, watched: false }
    movie = {id:next_id, title: title, watched: false}
    # - Append it to @movies
    
    @movies << movie
    # - Print a confirmation message
    puts " Movie added!"
    # - Save to disk by calling a private save_database
    save_database
  end

  # Remove a movie by its numeric ID.
  def remove_movie_by_id(id)
    # TODO:
    # - Find the movie with matching :id
   

    movie = @movies.find { |m| m[:id] == id}
    if movie
      @movies.delete(movie)
      puts "movie deleted"
      save_database
    else

      puts "movie not found."

    end 

    # - Remove it from @movies (if found) and print a message
    # - If not found, print "Movie not found."
    # - Save changes to disk
  end

  # Mark a movie as watched by its ID.
  def mark_watched(id)
    # TODO:
    # - Find the movie
    movie = @movies.find { |m| m[:id] == id}
    # if movie
    if movie
      movie[:watched] = true
      puts "watched."
      save_database
    end
    # - Set its :watched to true (or toggle if you want)
    # - Print a message
    # - Save changes to disk
  end
  # Load existing movies from JSON if it exists.
  
  # List all movies with their status.
  def list_movies
    # TODO:
    if @movies.empty?
      puts "No movies yet."
    else
      @movies.each do |movie|
        puts movie
      end
    end
    # - If empty, print "No movies yet."
    # - Otherwise print lines like: "1. #3 - Inception [watched: false]"
  end
  
  # ---------------- Private helpers (encapsulation) ----------------
  private
  
  def load_database
    # TODO:
    # - If File.exist?(@file_name):
    if File.exist?(@file_name)
      begin
        puts "......"
        puts @file_name
        file = File.open(@file_name, "r")
        @movies = JSON.parse(file.read, symbolize_names: true)
        puts "Movies loaded."

      rescue => error

        puts "Error reading database. #{error} Starting fresh."

        @movies = []
      ensure


      end

    else



      puts "No database found."
    end    
    #     - Read the file and JSON.parse with symbolize_names: true
    #     - Assign to @movies
    #     - Print "Movies loaded."
    #   Else:
    #     - Leave @movies as []
    #     - Print "No database found. Starting fresh."
    # - Add basic error handling with begin/rescue to avoid crashing on bad JSON
    
  end

  # Save current @movies to the JSON file (pretty-printed).
  def save_database
    # TODO:
    # - Open @file_name in write mode
    begin

      file = File.open(@file_name, "w") 
      
      file.write(JSON.pretty_generate(@movies))
      
      puts "Saved."





    rescue
      puts "Error."
    ensure

      file.close if file 
      # file_name.close if file
    end
    # - Write JSON.pretty_generate(@movies)
    # - Print "Saved."
    # - Add basic error handling with begin/rescue
  end

  # Return the next integer ID (1 if no movies yet).
  def next_id
    # TODO:
    # - If @movies is empty, return 1
    return  @movies.length + 1
    # - Else return max existing :id + 1
    #   (hint: @movies.map { |m| m[:id] }.max)
  end
end

# ---------------- CLI (uses only the public API) ----------------
watchlist = MovieWatchlist.new

loop do
  puts "\nMovie Watchlist Menu:"
  puts "1. Add movie"
  puts "2. Remove movie by ID"
  puts "3. Mark movie as watched"
  puts "4. View movies"
  puts "5. Exit"
  print "Enter your choice: "
  choice = gets.to_i

  case choice
  when 1
    print "Movie title: "
    title = gets.chomp
    watchlist.add_movie(title)
  when 2
    print "ID to remove: "
    id = gets.to_i
    watchlist.remove_movie_by_id(id)
  when 3
    print "ID to mark watched: "
    id = gets.to_i
    watchlist.mark_watched(id)
  when 4
    puts "\nYour Movies:"
    watchlist.list_movies
  when 5
    puts "Goodbye!"
    break
  else
    puts "Invalid choice."
  end
end