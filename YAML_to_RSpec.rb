#!/usr/bin/env ruby
#
# Yaml to Rspec
# Created by Gregg Pollack (RailsEnvy.com)
#
# Installation notes
# -----------------
# 1. From textmate select bundles -> bundle commands -> edit commands
# 2. Select Rails 
# 3. Click the ++ button at the bottom and add a new command.
# 4. Name the command "Yaml to Rspec"
# 5. Paste in this snippet to the big field
# 6. Give the command the following properties
# 
# Save: Nothing
# Input: Entire Document
# Output: Replace Document
# 
# Key Equivalent: ctrl + opt + command + y
#  (that's what I use anyways)
#
# 7. Close the bundle editor, and try it out on a yaml file (but make sure Rails is selected at the bottom of your page)

require "yaml"

buffer = []
STDIN.each_line { |l| buffer << l }

contexts = YAML::load(buffer.join("\n"))
puts "require File.dirname(__FILE__) + '/../spec_helper'"
contexts.each do |context,specifications|
  puts ""
  puts "describe \"#{context.gsub("\"", "\\\"")}\" do"
  puts ""
  specifications.each do |specification|
    puts "  it \"#{specification.gsub("\"", "\\\"").chomp}\" do"
    puts "    pending \"Not done yet\""
    puts "  end"
    puts ""
  end
  puts "end"
end
