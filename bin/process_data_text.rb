#!/usr/bin/ruby

require 'optparse'

options = {}
option_parser = OptionParser.new do |opts|
  opts.on("-t <table>") do |table|
    options[:table] = table
  end
end
option_parser.parse!

datadir           = "data"
table             = options[:table]
table_text_file   = "#{datadir}/#{table}.txt"
table_data_file   = "#{datadir}/#{table}_data.sql"

in_file   = File.open(table_text_file, "r")
out_file  = File.open(table_data_file, "w")

out_file.puts "BEGIN DEFERRED;"

in_file.each_line do |line|
  out_file.print "INSERT into #{table} VALUES( null"
  line_array = line.split(":", -1)
  line_array.each do |item|
    item.strip!
    item = "null" if item.length < 1
    out_file.print ",'#{item}'"
  end
  out_file.puts ");" 
end

out_file.puts "COMMIT;"
in_file.close
out_file.close
