class Link < ActiveRecord::Base
  def self.load(csv_file)

    ActiveRecord::Base.connection.execute('truncate table links')

    sql = []
    sql << "LOAD DATA infile '#{File.expand_path(csv_file)}'"
    sql << "INTO TABLE links"
    sql << "FIELDS TERMINATED BY ',' ENCLOSED BY '\"'"
    sql << "LINES TERMINATED BY '\\r\\n'"
    sql << "IGNORE 1 LINES"
    sql << "(movie_id, imdb_id, tmdb_id)"

    ActiveRecord::Base.connection.execute(sql.join(' '))
  end
end
