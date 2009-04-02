class Dexter::Parser
  def self.parse(file)
    self.new(file)
  end
  
  def initialize(file)
    @doing_slide = false
    @slides = []
    instance_eval(File.read(file), file)    
  end
  
  def title(name)
    raise 'You can only set the title once' if @slides.any? { |entry| entry.first == :title }
    @slides << [:title, name]
  end
  
  def slide(name, &block)
    raise ArgumentError, 'You can not make empty slides' unless block_given?
    raise 'You can not have a slide inside another slide' if @doing_slide
    @doing_slide = true
    @current_scope = []
    @slides << [:slide, name, @current_scope]
    instance_eval(&block)
    @doing_slide = false
  end
  
  def text(name)
    @current_scope << [:text, name]
  end
  
  def render(options = {})
    target = Dexter::Target.list.first
    if options[:target] && Dexter::Target.list.include?(options[:target])
      target = options[:target]
    end
    
    class_name = target.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
    klass = if Dexter::Target.const_defined?(class_name)
      Dexter::Target.const_get(class_name)
    else
      Dexter::Target.const_missing(class_name)
    end
    
    klass.render(@slides)
  end
end
