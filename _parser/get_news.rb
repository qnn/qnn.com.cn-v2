#!/usr/bin/ruby

require 'action_view'
require 'fileutils'
require 'sqlite3'
require 'reverse_markdown'

news_dir = "../news/_posts"

begin
  #count = 0
  db = SQLite3::Database.open "database"
  stm = db.prepare "SELECT `id` FROM `8html_qnn_arctype` WHERE `topid`=6"
  rs = stm.execute
  types = rs.to_a.join ","
  stm.close if stm
  stm = db.prepare "SELECT `ar`.`title`,`ar`.`keywords`,`ar`.`description`,`ar`.`id`,\
  `aa`.`body`,`at`.`typename`,`at`.`typedir`,`ar`.`pubdate`,`ar`.`litpic` FROM `8html_qnn_archives` AS `ar` \
  LEFT JOIN `8html_qnn_addonarticle` AS `aa` ON `aa`.`aid`=`ar`.`id` \
  LEFT JOIN `8html_qnn_arctype` AS `at` ON `at`.`id`=`ar`.`typeid` \
  WHERE `ar`.`typeid` IN (#{types})"
  rs = stm.execute
  rs.each do |row|
    typedir = row[6].sub(/.*\//, "")
    posts_dir = "#{news_dir}/#{typedir}"
    FileUtils.mkpath posts_dir if !File.directory?(posts_dir)
    pubdate = Time.at(row[7]).strftime("%Y-%m-%d")
    open("#{posts_dir}/#{pubdate}-qnn-news#{row[3]}.md", "w") do |f|
      row[0].gsub!(/\[(.+?)\]/,"\\1")
      row[2].gsub!("\n","")
      body = row[4].gsub(/"\.\.\/.+?image-pro/,"\"%PRODIMGS%")
      body = ReverseMarkdown.parse body
      f.puts <<content
---
layout: news_article
type: #{row[5]}
type_eng: #{typedir}

title: #{row[0]}
keywords: #{row[1]}
description: #{row[2]}
image: #{row[8]}
---
#{body}
content
    end
    #count = count + 1
    #exit if count > 10
  end
rescue SQLite3::Exception => e
  puts "Exception occurred."
  puts e
ensure
  stm.close if stm
  db.close if db
end
