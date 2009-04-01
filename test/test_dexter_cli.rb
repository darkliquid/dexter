require File.join(File.dirname(__FILE__), "test_helper.rb")
require 'dexter/cli'

class TestDexterCli < Test::Unit::TestCase
 
  def test_show_error_if_input_file_doesnt_exist
    File.stubs(:exist?).returns(false)
    Dexter::CLI.stubs(:exit)
    Dexter::Parser.stubs(:parse).with('file that does not exist').returns(stub_everything)
    run_cmd('file that does not exist')
    assert_match /Can't find input file/, @stdout
  end
  
  private
  
  def run_cmd(*args)
    Dexter::CLI.execute(@stdout_io = StringIO.new, args)
    @stdout_io.rewind
    @stdout = @stdout_io.read
  end
  
end
