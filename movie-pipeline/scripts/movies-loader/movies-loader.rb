require 'csv'

require_relative 'models/connection'
require_relative 'models/movie_genre'
require_relative 'models/genre'
require_relative 'models/movie'
require_relative 'models/link'
require_relative 'models/rating'
require_relative 'models/tag'

class MoviesLoader
  def initialize(csv_location)
    @csv_location = csv_location
  end

  def run
    check_files

    Movie.load("#{@csv_location}/movies.csv")
    Link.load("#{@csv_location}/links.csv")
    Rating.load("#{@csv_location}/ratings.csv")
    Tag.load("#{@csv_location}/tags.fixed.csv")
  end

  private
  def check_files
    csv_files.each do |csv_file|
      unless File.exist? "#{@csv_location}/#{csv_file}"
        throw "File does not exist: #{@csv_location}/#{csv_file}"
      end
    end
  end

  def csv_files
    [ 'links.csv', 'movies.csv', 'ratings.csv', 'tags.fixed.csv' ]
  end
end

def usage
  puts "Usage:"
  puts "./movies-loader.rb ./csv/directory"
  return 255
end

def main
  return usage if ARGV.size == 0

  begin
    movies_loader = MoviesLoader.new(ARGV[0])
    movies_loader.run
  rescue => e
    p e
    return 255
  end
  return 0
end

main()
