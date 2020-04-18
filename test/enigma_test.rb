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
    expected2 = ("a".."z").to_a << " "
    assert_equal expected, @enigma.date
    assert_equal expected2, @enigma.char_set
  end

  def test_shift_create_and_shift_variables
    assert_nil @enigma.ashift["a"]
    assert_nil @enigma.bshift["b"]
    assert_nil @enigma.cshift["z"]
    assert_nil @enigma.dshift["m"]
    assert_instance_of Hash, @enigma.ashift
    assert_instance_of Hash, @enigma.bshift
    assert_instance_of Hash, @enigma.cshift
    assert_instance_of Hash, @enigma.dshift
  end

end
