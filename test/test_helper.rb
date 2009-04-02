require 'stringio'
require 'test/unit'
require 'mocha'
begin 
  require 'redgreen'
rescue LoadError
  puts "Install the redgreen gem for pretty test colours"
end
require File.dirname(__FILE__) + '/../lib/dexter'
