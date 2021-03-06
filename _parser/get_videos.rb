#!/usr/bin/ruby

require 'fileutils'
require 'sqlite3'

vid_dir = "../videos/_posts"

begin
  db = SQLite3::Database.open "database"
  stm = db.prepare "SELECT `id` FROM `8html_qnn_arctype` WHERE `topid`=5 OR `id`=5"
  rs = stm.execute
  types = rs.to_a.join ","
  stm.close if stm
  stm = db.prepare "SELECT `ar`.`title`,`ar`.`keywords`,`ar`.`description`,`ar`.`id`,\
  `aa`.`body`,`at`.`typename`,`ar`.`pubdate` FROM `8html_qnn_archives` AS `ar` \
  LEFT JOIN `8html_qnn_addonarticle` AS `aa` ON `aa`.`aid`=`ar`.`id` \
  LEFT JOIN `8html_qnn_arctype` AS `at` ON `at`.`id`=`ar`.`typeid` \
  WHERE `ar`.`typeid` IN (#{types})"
  FileUtils.mkpath vid_dir if !File.directory?(vid_dir)
  rs = stm.execute
  rs.each do |row|
    pubdate = Time.at(row[6]).strftime("%Y-%m-%d")
    open("#{vid_dir}/#{pubdate}-videos#{row[3]}.md", "w") do |f|
      row[2].gsub!("\n","")
      f.puts <<content
---
layout: video_article

title: #{row[0]}
keywords: #{row[1]}
file: #{row[4][/file.*'(.*)'/, 1]}
image: #{row[4][/image.*'(.*)'/, 1]}
---
content
    end
  end
rescue SQLite3::Exception => e
  puts "Exception occurred."
  puts e
ensure
  stm.close if stm
  db.close if db
end
