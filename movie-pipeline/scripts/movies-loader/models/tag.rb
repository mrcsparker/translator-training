class Tag < ActiveRecord::Base
  def self.load(csv_file)

    tags = []

    CSV.foreach(csv_file, headers: true) do |csv|
      tag = Tag.where(user_id: csv['userId'],
                      movie_id: csv['movieId'],
                      tag: csv['tag'],
                      timestamp: csv['timestamp']).first
      unless tag
        tag = Tag.new(user_id: csv['userId'],
                      movie_id: csv['movieId'],
                      tag: csv['tag'],
                      timestamp: csv['timestamp'])
        tags << tag
      end

      if tags.size == 5000
        ActiveRecord::Base.transaction do
          tags.map(&:save)
        end
        tags = []
      end
    end

    ActiveRecord::Base.transaction do
      tags.map(&:save)
    end if tags.size > 0
  end
end
