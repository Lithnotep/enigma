require './test/test_helper'
require './lib/key'
require 'date'

class KeyTest < Minitest::Test

  def setup
    @key = Key.new
  end
