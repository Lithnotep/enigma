require './test/test_helper'
require './lib/enigma'
require './lib/encrypt'


class EncryptTest < Minitest::Test

  def setup
    @encrypt = Encrypt.new
  end

  def test_it_exists
    assert_instance_of Encrypt, @encrypt
  end

  def test_has_parent
    assert_equal ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q",
    "r", "s", "t", "u", "v", "w", "x", "y", "z", " "], @encrypt.char_set
    assert_instance_of Hash, @encrypt.ashift
    assert_instance_of Hash, @encrypt.bshift
    assert_instance_of Hash, @encrypt.cshift
    assert_instance_of Hash, @encrypt.dshift
    assert_equal 4, @encrypt.offsets.length
    assert_equal 4, @encrypt.key.length
  end

  def test_key_and_make_key_parent
    assert_equal 4, @encrypt.key.length
    assert_equal 4, @encrypt.make_key.length
  end

  def test_key_offset_combine_parent
    @encrypt.stubs(:combine).returns([24, 49, 93, 33], [6, 4, 0, 0])
    assert_equal 4, @encrypt.offset_combine.length
    assert_instance_of Array, @encrypt.offset_combine
    assert_instance_of Integer, @encrypt.offset_combine[1]
  end

  def test_ashift_assign_parent
    @encrypt.ashift_assign([1, 2, 3, 4])
    assert_equal "b", @encrypt.ashift["a"]
  end

  def test_bshift_assign_parent
    @encrypt.bshift_assign([1, 2, 3, 4])
    assert_equal "c", @encrypt.bshift["a"]
  end

  def test_cshift_assign_parent
    @encrypt.cshift_assign([1, 2, 3, 4])
    assert_equal "d", @encrypt.cshift["a"]
  end

  def test_dshift_assign_parent
    @encrypt.dshift_assign([1, 2, 3, 4])
    assert_equal "e", @encrypt.dshift["a"]
  end

  def test_full_shift_assign_parent
    @encrypt.full_shift_assign([1, 2, 3, 4])
    assert_equal "b", @encrypt.ashift["a"]
    assert_equal "c", @encrypt.bshift["a"]
    assert_equal "d", @encrypt.cshift["a"]
    assert_equal "e", @encrypt.dshift["a"]
  end

  def test_message_prep
    assert_equal [["H", "e", "l", "l"], ["o", " ", "w", "o"], ["r", "l", "d"]], @encrypt.message_prep("Hello world")
  end

  def test_user_input
    skip
    Encrypt.stubs(:gets).returns("Hello world\n")
    # assert_equal "hello world", @encrypt.user_input
  end

  def test_encryption
    @encrypt.full_shift_assign([1, 1, 1, 1])
    assert_equal ["i", "f", "m", "m", "p"] , @encrypt.encryption([["h", "e", "l", "l"], ["o"]])
  end

end
