require File.join(File.dirname(__FILE__), "test_helper.rb")
require 'dexter/parser'

class TestDexterParser < Test::Unit::TestCase
 
  def test_should_create_new_parser_instance
    Dexter::Parser.expects(:new).with('test')
    Dexter::Parser.parse('test')
  end
  
  def test_should_load_file_on_initialize
    Dexter::Parser.any_instance.expects(:load).with('test')
    Dexter::Parser.new('test')
  end
  
  #def test_should_create_slide_structure
  #  parser = Dexter::Parser.new(File.join(File.dirname(__FILE__),'fixtures', 'load_test.dex'))
  #  
  #  slides = [
  #    [
  #      :slide, 'test', [
  #        [:text, 'this is a test']
  #      ]
  #    ]
  #  ]
  #  assert_equals slides, parser.instance_variable_get('@slides')
  #end
  
  def test_should_create_slide_in_slide_structure
    Dexter::Parser.any_instance.stubs(:load).with('test')
    parser = Dexter::Parser.new('test')
    parser.slide 'test' do
    end
    slides = [[:slide, 'test', []]]
    assert_equal slides, parser.instance_variable_get('@slides')    
  end
  
  def test_should_create_slide_with_text_in_slide_structure
    Dexter::Parser.any_instance.stubs(:load).with('test')
    parser = Dexter::Parser.new('test')
    parser.slide 'test' do
      text 'this is a test'
    end
    slides = [[:slide, 'test', [
      [:text, 'this is a test']
    ]]]
    assert_equal slides, parser.instance_variable_get('@slides')    
  end
  
  def test_should_create_multiple_slides_with_text_in_slide_structure
    Dexter::Parser.any_instance.stubs(:load).with('test')
    parser = Dexter::Parser.new('test')
    parser.slide 'test' do
      text 'this is a test'
    end
    
    parser.slide 'another test' do
      text 'this is another test'
      text 'even more text'
    end
    slides = [
      [:slide, 'test', [
        [:text, 'this is a test']
      ]],
      [:slide, 'another test', [
        [:text, 'this is another test'],
        [:text, 'even more text']
      ]]
    ]
    assert_equal slides, parser.instance_variable_get('@slides')    
  end
      
end
