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

  def test_has_attributes_and_shift_create
    expected2 = ("a".."z").to_a << " "
    assert_equal expected2, @shift.char_set
    assert_nil @shift.ashift["a"]
    assert_nil @shift.bshift["b"]
    assert_nil @shift.cshift["z"]
    assert_nil @shift.dshift["m"]
    assert_instance_of Hash, @shift.ashift
    assert_instance_of Hash, @shift.bshift
    assert_instance_of Hash, @shift.cshift
    assert_instance_of Hash, @shift.dshift
  end

  def test_shift_assign
    @shift.shift_assign([1, 2, 3, 4], :a)
    @shift.shift_assign([1, 2, 3, 4], :b)
    @shift.shift_assign([1, 2, 3, 4], :c)
    @shift.shift_assign([1, 2, 3, 4], :d)
    assert_equal "b", @shift.ashift["a"]
    assert_equal "c", @shift.bshift["a"]
    assert_equal "d", @shift.cshift["a"]
    assert_equal "e", @shift.dshift["a"]
  end

  assert_equal "b", @shift.ashift["a"]
  assert_equal "c", @shift.bshift["a"]
  assert_equal "d", @shift.cshift["a"]
  assert_equal "e", @shift.dshift["a"]

end
