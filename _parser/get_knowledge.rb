#!/usr/bin/ruby

require 'fileutils'
require 'sqlite3'
require 'reverse_markdown'

know_dir = "../support/_posts"

begin
  count = 0
  db = SQLite3::Database.open "database"
  stm = db.prepare "SELECT `id` FROM `8html_qnn_arctype` WHERE `topid`=38"
  rs = stm.execute
  types = rs.to_a.join ","
  stm.close if stm
  stm = db.prepare "SELECT `ar`.`title`,`ar`.`keywords`,`ar`.`description`,`ar`.`id`,\
  `aa`.`body`,`at`.`typename`,`ar`.`pubdate` FROM `8html_qnn_archives` AS `ar` \
  LEFT JOIN `8html_qnn_addonarticle` AS `aa` ON `aa`.`aid`=`ar`.`id` \
  LEFT JOIN `8html_qnn_arctype` AS `at` ON `at`.`id`=`ar`.`typeid` \
  WHERE `ar`.`typeid` IN (#{types})"
  FileUtils.mkpath know_dir if !File.directory?(know_dir)
  rs = stm.execute
  rs.each do |row|
    pubdate = Time.at(row[6]).strftime("%Y-%m-%d")
    open("#{know_dir}/#{pubdate}-knowledge#{row[3]}.md", "w") do |f|
      row[2].gsub!("\n","")
      body = row[4].gsub(/"\.\.\/.+?image-pro/,"\"%PRODIMGS%")
      body = ReverseMarkdown.parse body
      body = body.gsub("\r","").gsub(/^[  　\t]*/,"").gsub(/  $/,"\n").gsub("****","").gsub("-  ","\n").gsub(/\n{3,}/,"\n\n").strip
      f.puts <<content
---
layout: knowledge_article

title: #{row[0]}
keywords: #{row[1]}
description: #{row[2]}
---
#{body}
content
    end
    count = count + 1
    exit if count > 10
  end
rescue SQLite3::Exception => e
  puts "Exception occurred."
  puts e
ensure
  stm.close if stm
  db.close if db
end
