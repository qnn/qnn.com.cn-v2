#!/usr/bin/ruby

require 'action_view'
require 'fileutils'
require 'sqlite3'

posts_dir = "../products/_posts"

begin
  count = 0
  db = SQLite3::Database.open "database"
  stm = db.prepare "SELECT `id` FROM `8html_qnn_arctype` WHERE `topid`=12 OR `topid`=15"
  rs = stm.execute
  types = rs.to_a.join ","
  stm.close if stm
  stm = db.prepare "SELECT `ar`.`title`,`ar`.`keywords`,`ar`.`description`,`ar`.`filename`,\
  `aa`.`body`,`at`.`typename` FROM `8html_qnn_archives` AS `ar` \
  LEFT JOIN `8html_qnn_addonarticle` AS `aa` ON `aa`.`aid`=`ar`.`id` \
  LEFT JOIN `8html_qnn_arctype` AS `at` ON `at`.`id`=`ar`.`typeid` \
  WHERE `ar`.`typeid` IN (#{types})"
  rs = stm.execute
  FileUtils.mkpath posts_dir if !File.directory?(posts_dir)
  rs.each do |row|
    open("#{posts_dir}/2013-1-1-#{row[3]}.md", "w") do |f|
      row[2].gsub!("\n","")
      body = row[4].gsub(/"\.\.\/.+?image-pro/,"\"%PRODIMGS%")
      body = body.split("<hr />")
      specs = ActionView::Base.full_sanitizer.sanitize(body[0]).gsub(/^[\t\s]+/,"")
      images = ActionView::Base.full_sanitizer.sanitize(body[1].strip).gsub(/^[\t\s]+/,"").gsub(/.*\//,"").gsub(/^/,"  - ")
      features = body[2].strip.gsub(/<\/?p>/,"").gsub(/^([\t\s]+)?/,"  ").gsub(/\n{2,}/,"").gsub("<br />", "  ")
      spec_details = body[3].strip.gsub(/<\/?p>/,"").gsub(/^([\t\s]+)?/,"  ").gsub(/\n{2,}/,"").gsub("<br />", "  ")
      manual = body[4].strip.gsub(/<\/?p>/,"").gsub(/^([\t\s]+)?/,"  ").gsub(/\n{2,}/,"").gsub("<br />", "  ")
      manual = manual.gsub(/<h3>(.+?)<\/h3>/m) {|s| "### " + $1.strip }
      f.puts <<content
---
layout: product_article
permalink: \/#{row[3]}.html

type: #{row[5]}
title: #{row[0]}
keywords: #{row[1]}
description: #{row[2]}

specs: #{specs[/规格：(.*)/, 1]}
thickness: #{specs[/厚度：(.*)/, 1]}
weight: #{specs[/净重：(.*)/, 1]}

images:
#{images}

features: |
#{features}

spec_details: |
#{spec_details}

manual: |
#{manual}
---
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
