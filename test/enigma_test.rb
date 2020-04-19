require './test/test_helper'
require './lib/enigma'



class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_attributes
    @enigma.stubs(:current_date).returns("180420")
    expected2 = ("a".."z").to_a << " "
    assert_equal [6, 4, 0, 0], @enigma.offsets
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

  def test_key_and_make_key
    assert_equal 4, @enigma.key.length
    assert_equal 4, @enigma.make_key.length
  end

  def test_key_offset_combine
    @enigma.stubs(:current_date).returns("180420")
    @enigma.stubs(:rand_key).returns([0, 1, 2, 4, 5])
  end




end
