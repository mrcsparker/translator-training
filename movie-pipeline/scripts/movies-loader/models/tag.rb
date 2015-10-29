class Tag < ActiveRecord::Base
  def self.load(csv_file)

    ActiveRecord::Base.connection.execute('truncate table tags')

    sql = []
    sql << "LOAD DATA infile '#{File.expand_path(csv_file)}'"
    sql << "INTO TABLE tags"
    sql << "FIELDS TERMINATED BY ',' ENCLOSED BY '\"'"
    sql << "LINES TERMINATED BY '\\r\\n'"
    sql << "IGNORE 1 LINES"
    sql << "(user_id, movie_id, tag, timestamp)"

    ActiveRecord::Base.connection.execute(sql.join(' '))
  end
end
