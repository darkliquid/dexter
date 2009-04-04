require File.dirname(__FILE__) + '/test_helper.rb'

class TestDexterTargetS5 < Test::Unit::TestCase

  def test_should_generate_correct_file
    slides = [
      [:slide, 'test', [
        [:text, 'this is a test']
      ]],
      [:slide, 'another test', [
        [:text, 'this is another test'],
        [:text, 'even more text']
      ]]
    ]
    slideshow = Dexter::Target::S5.render(slides).to_s
    assert_match(/<h1>test<\/h1>/, slideshow)
    assert_match(/<h1>another test<\/h1>/, slideshow)
  end

end
