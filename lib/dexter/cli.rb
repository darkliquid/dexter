require 'optparse'

module Dexter
  class CLI
    def self.execute(stdout, arguments=[])
      options = { :target => 's5' }

      parser = OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')
          Generates presentations using a simple DSL.

          Usage: #{File.basename($0)} dsl_file [options]

          Options are:
        BANNER
        opts.separator ""
        opts.on("-t", "--target=TARGET", String,
                "Specify a render target.",
                "Available targets are: #{Dexter::Target.list.join(', ')}",
                "Default: s5") { |arg| options[:target] = arg }
        opts.on("-h", "--help",
                "Show this help message.") { stdout.puts opts; exit }
        opts.parse!(arguments)
      end

      file = arguments.first
      
      unless File.exist?(file)
        stdout.puts 'Can\'t find input file'
        exit(1)
      end

      Parser.parse(file).render(options)
    end
  end
end
