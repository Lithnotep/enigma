require './test/test_helper'
require './lib/key'
require 'date'

class KeyTest < Minitest::Test

  def setup
    @key = Key.new
  end

  def test_it_exists
    assert_instance_of Key, @key
  end

  def test_key_and_make_key
    assert_equal 5, @key.current_key.length
  end

  def test_prepare_key
    assert_equal [11, 11, 11, 11], @key.prepare_key("11111")
  end
end
