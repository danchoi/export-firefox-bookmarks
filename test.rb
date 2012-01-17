

require 'json'
require 'pp'
require 'ostruct'
require 'csv'

d = JSON.parse STDIN.read

def simplify item
  i = OpenStruct.new item
  r = {title: i.title}
  r.merge!( date_added: Time.at(i.dateAdded / 10**6).to_date.to_s ) if i.dateAdded
  r.merge!( url: i.uri ) if i.uri 
  r
end

def flatten(d, depth=0)
  children = d.delete('children')
  puts "  " * depth + simplify(d).inspect
  children.each {|x| flatten x, depth + 1}  if children
end

flatten d
