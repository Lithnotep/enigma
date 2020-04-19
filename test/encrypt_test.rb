require './test/test_helper'
require './lib/enigma'
require './lib/encrypt'


class EncryptTest < Minitest::Test

  def setup
    @enigma = Enigma.new
    @encrypt = Ecrypt.new
  end

  def test_it_exists
    assert_instance_of Encrypt, @encrypt
  end

end
