class Link < ActiveRecord::Base
  def self.load(csv_file)

    links = []

    CSV.foreach(csv_file, headers: true) do |csv|
      link = Link.where(movie_id: csv['movieId'],
                        imdb_id: csv['imdbId'],
                        tmdb_id: csv['tmdbId']).first
      unless link
        link = Link.new(movie_id: csv['movieId'],
                        imdb_id: csv['imdbId'],
                        tmdb_id: csv['tmdbId'])
        links << link
      end

      if links.size == 5000
        ActiveRecord::Base.transaction do
          links.map(&:save)
        end
        links = []
      end
    end

    ActiveRecord::Base.transaction do
      links.map(&:save)
    end if links.size > 0
  end
end
