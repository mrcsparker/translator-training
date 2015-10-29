require 'mysql'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'mysql',
  database: 'movies'
)
