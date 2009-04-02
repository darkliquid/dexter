class Dexter::Target::S5 < Dexter::Target::Base
  
  def self.render(code)
    @results = self.new(code)
  end
  
  def initialize(code)
    @code = code
    @slides = []
  end
  
  def filename
    'index.html'
  end
  
  def to_s
    dispatch(@code)
    <<-EOF
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>#{@title}</title>
<meta name="version" content="S5 1.0" />
<meta name="generator" content="dexter" />
<link rel="stylesheet" href="ui/slides.css" type="text/css"
   media="projection" id="slideProj" />
<link rel="stylesheet" href="ui/outline.css" type="text/css"
  media="projection" id="outlineStyle" />
<link rel="stylesheet" href="ui/opera.css" type="text/css"
   media="projection" id="operaFix" />
<link rel="stylesheet" href="ui/print.css" type="text/css"
   media="print" id="slidePrint" />
<script src="ui/slides.js" type="text/javascript"></script>
</head>
<body>

<div class="layout">

<div id="currentSlide"></div>
<div id="header"></div>
<div id="footer">
<div id="controls"></div>
</div>

</div>
<div class="presentation">

#{@slides.join("\n")}

</div>

</body>
</html>
    EOF
  end
  
  private
  
  def process_slide(type, name, code)
    @slides << slide_tag('name', dispatch(code.select { |item| item.first == :text }), dispatch(code.select { |item| item.first == :note }))
  end
  
  def process_text(type, text)
    text
  end
  
  def set_title(type, text)
    @title = text
  end
  
  def slide_tag(title, body, handout)
    <<-EOF
<div class="slide">
<h1>#{title}</h1>
  <div class="slidecontent">
    #{body}
  </div>
  <div class="handout">
    #{handout}
  </div>    
</div>
    EOF
  end
  
  def dispatch(code)
    code.map do |element|
      case element.first
        when :slide
          process_slide(*element)
        when :title
          set_title(*element)
        when :text
          process_text(*element)
        when :note
          process_text(*element)
        else
          ''
      end
    end
  end

end
