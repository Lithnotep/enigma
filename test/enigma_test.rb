require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'
require 'mocha/minitest'
require 'pry'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_attributes
    expected = DateTime.now.strftime("%d%m%Y")
    expected.slice!(4..5)
    assert_equal expected, @enigma.date
  end
end
