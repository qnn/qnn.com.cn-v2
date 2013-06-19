#!/usr/bin/ruby

require 'sqlite3'

# You may need to use mysql2sqlite.sh
# https://gist.github.com/esperlu/943776
# to convert mysql to sqlite3 format
sql_file = "hdm0770122_db@20130618195509.sql"

begin
  db = SQLite3::Database.open "database"
  db.execute_batch(File.read(sql_file))
rescue SQLite3::Exception => e
  puts "Exception occurred."
  puts e
ensure
  db.close if db
end
