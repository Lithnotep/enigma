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

  def test_it_has_attributes
    expected2 = ("a".."z").to_a << " "
    assert_instance_of Shift, @enigma.shift
    assert_instance_of Key, @enigma.key
    assert_equal expected2, @enigma.char_set
    assert_equal DateTime.now.strftime("%d%m%y"), @enigma.date
  end

  def test_shift_variable
    assert_instance_of Hash, @enigma.shift.ashift
    assert_instance_of Hash, @enigma.shift.ashift
    assert_instance_of Hash, @enigma.shift.ashift
    assert_instance_of Hash, @enigma.shift.ashift
  end

  def test_key_and_make_key
    assert_equal 5, @enigma.key.current_key.length
  end

  def test_prepare_key
    assert_equal [11, 11, 11, 11], @enigma.key.prepare_key("11111")
  end

  def test_key_offset_combine
    assert_equal [3, 27, 73, 20], @enigma.offset_combine(@enigma.make_offsets("040895"), @enigma.key.prepare_key("02715"))
  end

  def test_message_prep
    assert_equal [["H", "e", "l", "l"], ["o", " ", "w", "o"], ["r", "l", "d"]], @enigma.message_prep("Hello world")
  end

  def test_cryption_encrypt
    @enigma.shift.full_shift_assign([1, 1, 1, 1])
    assert_equal ["i", "f", "m", "m", "p"] , @enigma.cryption([["h", "e", "l", "l"], ["o"]], :encrypt)
    assert_equal ["i", "f", "m", "m", "p", "p"] , @enigma.cryption([["h", "e", "l", "l"], ["o", "o"]], :encrypt)
    assert_equal ["i", "f", "m", "m", "p", "a", "x", "p", "s", "m", "e"] , @enigma.cryption([["h", "e", "l", "l"], ["o", " ", "w", "o"], ["r", "l", "d"]], :encrypt)
  end

  def test_encrypt
    expected = {
    encryption: "keder ohulw",
    key: "02715",
    date: "040895"
    }
    assert_equal expected ,@enigma.encrypt("hello world", "02715", "040895")
  end

  def test_message_clean_up
    assert_equal "keder ohulw", @enigma.message_clean_up(["k", "e", "d", "e", "r", " ", "o", "h", "u", "l", "w"])
  end

  def test_cryption_feeder
    assert_equal [@enigma.shift.ashift, @enigma.shift.bshift, @enigma.shift.cshift, @enigma.shift.dshift], @enigma.cryption_feeder(:encrypt)
    assert_equal [@enigma.shift.ashift.invert, @enigma.shift.bshift.invert, @enigma.shift.cshift.invert, @enigma.shift.dshift.invert], @enigma.cryption_feeder(:decrypt)
  end

  def test_cryption_decrypt
    @enigma.shift.full_shift_assign([1, 1, 1, 1])
    assert_equal ["h", "e", "l", "l", "o"] , @enigma.cryption([["i", "f", "m", "m"], ["p"]], :decrypt)
    assert_equal ["h", "e", "l", "l", "o", "o"] , @enigma.cryption([["i", "f", "m", "m"], ["p", "p"]], :decrypt)
    assert_equal ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d"] , @enigma.cryption([["i", "f", "m", "m"], ["p", "a", "x", "p"], ["s", "m", "e"]], :decrypt)
  end

  def test_can_decrypt
      expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
      }
      assert_equal expected ,@enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_can_encrypt_without_date
    expected = {
    encryption: "pib wdmczpu",
    key: "02715",
    date: "200420"
    }
    assert_equal expected , @enigma.encrypt("hello world", "02715")
  end

  def test_can_decrypt_without_date
    encrypted = @enigma.encrypt("hello world", "02715")
    expected = {
    decryption: "hello world",
    key: "02715",
    date: "200420"
    }
    assert_equal expected, @enigma.decrypt(encrypted[:encryption], "02715")
  end

end
