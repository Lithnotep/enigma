require 'date'
require 'pry'
class Key
  attr_reader :current_key

  def initialize
    @current_key = make_key
  end

  def make_key
    rand_key = []
    5.times do
      rand_key << rand(0..9)
    end
    rand_key.join.to_s
  end

  def prepare_key(key)
    key_array = []
    key_chars = key.split(//)
    key_array << key_chars.slice(0..1).join.to_i
    key_array << key_chars.slice(1..2).join.to_i
    key_array << key_chars.slice(2..3).join.to_i
    key_array << key_chars.slice(3..4).join.to_i
    key_array
  end
end
