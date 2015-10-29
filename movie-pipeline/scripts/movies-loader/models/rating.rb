class Rating < ActiveRecord::Base
  def self.load(csv_file)

    ratings = []

    CSV.foreach(csv_file, headers: true) do |csv|
      rating = Rating.where(user_id: csv['userId'],
                            movie_id: csv['movieId'],
                            rating: csv['rating'],
                            timestamp: csv['timestamp']).first
      unless rating
        rating = Rating.new(user_id: csv['userId'],
                            movie_id: csv['movieId'],
                            rating: csv['rating'],
                            timestamp: csv['timestamp'])
        ratings << rating
      end

      if ratings.size == 25000
        puts "Saving ratings"
        ActiveRecord::Base.transaction do
          ratings.map(&:save)
        end
        ratings = []
      end
    end

    ActiveRecord::Base.transaction do
      ratings.map(&:save)
    end if ratings.size > 0
  end
end
