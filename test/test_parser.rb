require File.join(File.dirname(__FILE__), "test_helper.rb")
require 'dexter/parser'

class TestDexterParser < Test::Unit::TestCase
 
  def test_should_create_new_parser_instance
    Dexter::Parser.expects(:new).with('test')
    Dexter::Parser.parse('test')
  end
  
  def test_should_load_file_on_initialize
    File.expects(:read).with('test').returns('')
    Dexter::Parser.new('test')
  end
  
  def test_should_create_title_in_slide_structure
    File.stubs(:read).with('test').returns('')
    parser = Dexter::Parser.new('test')
    parser.title 'test' do
    end
    slides = [[:title, 'test']]
    assert_equal slides, parser.instance_variable_get('@slides')    
  end
  
  def test_should_raise_if_creating_title_in_slide_structure_twice
    File.stubs(:read).with('test').returns('')
    parser = Dexter::Parser.new('test')
    parser.title 'test'
    assert_raises(RuntimeError) { parser.title 'should error' }
  end
  
  def test_should_create_slide_in_slide_structure
    File.stubs(:read).with('test').returns('')
    parser = Dexter::Parser.new('test')
    parser.slide 'test' do
    end
    slides = [[:slide, 'test', []]]
    assert_equal slides, parser.instance_variable_get('@slides')    
  end
  
  def test_should_raise_if_creating_slide_in_slide
    File.stubs(:read).with('test').returns('')
    parser = Dexter::Parser.new('test')
    assert_raises(RuntimeError) do
      parser.slide 'test' do
        slide 'should fail' do
        end
      end
    end
  end
  
  def test_should_create_slide_with_text_in_slide_structure
    File.stubs(:read).with('test').returns('')
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
    File.stubs(:read).with('test').returns('')
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
