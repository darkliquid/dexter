$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Dexter
  VERSION = '0.0.1'
  
  autoload(:Target, 'dexter/target')
  autoload(:Parser, 'dexter/parser')
end
