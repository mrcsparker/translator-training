class Genre < ActiveRecord::Base
  def self.load(input_genres)
    genres = []

    input_genres.split('|').each do |g|
      genre = Genre.where(name: g).first
      unless genre
        genre = Genre.create(name: g)
      end
      genres << genre
    end

    genres
  end
end
