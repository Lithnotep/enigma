require './test/test_helper'
require './lib/shift'
require 'date'

class ShiftTest < Minitest::Test

  def setup
    @shift = Shift.new
  end

  def test_it_exists
    assert_instance_of Shift, @shift
  end

  def test_has_attributes
    expected2 = ("a".."z").to_a << " "
    assert_equal expected2, @enigma.char_set
    assert_nil @shift.ashift["a"]
    assert_nil @shift.bshift["b"]
    assert_nil @shift.cshift["z"]
    assert_nil @shift.dshift["m"]
    assert_instance_of Hash, @shift.ashift
    assert_instance_of Hash, @shift.bshift
    assert_instance_of Hash, @shift.cshift
    assert_instance_of Hash, @shift.dshift
  end
end
