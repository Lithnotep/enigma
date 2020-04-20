require './test/test_helper'
require './lib/enigma'
require 'date'



class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end
# 180420
  def test_it_has_attributes
    #@enigma.stubs(:current_date).returns("111111")
    expected2 = ("a".."z").to_a << " "
    # assert_equal 4, @enigma.offsets.length
    assert_equal expected2, @enigma.char_set
    assert_equal DateTime.now.strftime("%d%m%y"), @enigma.date
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

  # def test_key_and_make_key
  #   assert_equal 4, @enigma.key.length
  #   assert_equal 4, @enigma.make_key.length
  # end

  def test_key_offset_combine
    @enigma.stubs(:combine).returns([24, 49, 93, 33], [6, 4, 0, 0])
    assert_equal 4, @enigma.offset_combine.length
    assert_instance_of Array, @enigma.offset_combine
    assert_instance_of Integer, @enigma.offset_combine[1]
  end

  def test_ashift_assign
    @enigma.ashift_assign([1, 2, 3, 4])
    assert_equal "b", @enigma.ashift["a"]
  end

  def test_bshift_assign
    @enigma.bshift_assign([1, 2, 3, 4])
    assert_equal "c", @enigma.bshift["a"]
  end

  def test_cshift_assign
    @enigma.cshift_assign([1, 2, 3, 4])
    assert_equal "d", @enigma.cshift["a"]
  end

  def test_dshift_assign
    @enigma.dshift_assign([1, 2, 3, 4])
    assert_equal "e", @enigma.dshift["a"]
  end

  def test_full_shift_assign
    @enigma.full_shift_assign([1, 2, 3, 4])
    assert_equal "b", @enigma.ashift["a"]
    assert_equal "c", @enigma.bshift["a"]
    assert_equal "d", @enigma.cshift["a"]
    assert_equal "e", @enigma.dshift["a"]
  end

  def test_message_prep
    assert_equal [["H", "e", "l", "l"], ["o", " ", "w", "o"], ["r", "l", "d"]], @enigma.message_prep("Hello world")
  end

  def test_encryption
    @enigma.full_shift_assign([1, 1, 1, 1])
    assert_equal ["i", "f", "m", "m", "p"] , @enigma.encryption([["h", "e", "l", "l"], ["o"]])
    assert_equal ["i", "f", "m", "m", "p", "p"] , @enigma.encryption([["h", "e", "l", "l"], ["o", "o"]])
    assert_equal ["i", "f", "m", "m", "p", "a", "x", "p", "s", "m", "e"] , @enigma.encryption([["h", "e", "l", "l"], ["o", " ", "w", "o"], ["r", "l", "d"]])
  end

  def test_encrypt
    skip
    expected = {
    encryption: "keder ohulw",
    key: "02715",
    date: "040895"
    }
    assert_equal expected ,@enigma.encrypt("hello world", "02715", "040895")
  end
end
