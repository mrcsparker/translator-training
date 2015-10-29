class Movie < ActiveRecord::Base

  has_many :movie_genres
  has_many :genres, through: :movie_genres

  before_save :set_year
  def set_year
    y = title[-6,6]
    if y[0] == '('
      self.year = y.gsub("(", "").gsub(")", "")
      self.title = self.title.gsub(y, "").strip
    end
  end

  def self.load(csv_file)

    ActiveRecord::Base.connection.execute('truncate table movie_genres')
    ActiveRecord::Base.connection.execute('truncate table genres')
    ActiveRecord::Base.connection.execute('truncate table movies')

    CSV.foreach(csv_file, headers: true) do |csv|
      genres = Genre.load(csv['genres'])

      movie = Movie.where(id: csv['movieId'].to_i).first
      unless movie
        movie = Movie.new
        movie.id = csv['movieId'].to_i
        movie.title = csv['title']
        movie.save!
        puts movie.title
      end

      genres.each do |genre|
        unless movie.genres.include? genre
          movie.genres << genre
        end
      end
    end
  end
end
