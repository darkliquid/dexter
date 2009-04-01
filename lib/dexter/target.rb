module Dexter::Target
  def self.list
    ['s5']
  end
  
  autoload(:Base, File.join(File.dirname(__FILE__), 'target', 'base'))
  autoload(:S5, File.join(File.dirname(__FILE__), 'target', 's5'))
end
