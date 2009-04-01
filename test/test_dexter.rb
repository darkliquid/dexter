require File.dirname(__FILE__) + '/test_helper.rb'

class TestDexter < Test::Unit::TestCase

  def test_should_exist
    assert_nothing_raised(Exception) { Dexter }
  end
  
  def test_should_have_version
    assert_equal '0.0.1', Dexter::VERSION
  end

end
