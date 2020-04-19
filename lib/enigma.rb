require 'pry'
require 'date'

class Enigma
  attr_reader :offsets, :char_set, :ashift, :bshift, :cshift, :dshift, :key

  def initialize
    @char_set = ("a".."z").to_a << " "
    @offsets = make_offsets
    @key = make_key
    @ashift = shift_create
    @bshift = shift_create
    @cshift = shift_create
    @dshift = shift_create
  end


  def make_offsets
    current_date = DateTime.now.strftime("%d%m%Y")
    current_date.slice!(4..5)
    date_to_offset = current_date.to_i * current_date.to_i
    offset_alter = date_to_offset.to_s.slice(-4..-1)
    offset = offset_alter.split(//).map do |num|
      num.to_i
    end
    offset
  end

  def shift_create
    char_hash = Hash.new
    @char_set.each do |char|
      char_hash[char] = nil
    end
    char_hash
  end

  def make_key
    rand_key = []
    5.times do
      rand_key << rand(0..9)
    end
  end

  def shift_assign
  end

end






# alphabet set ("a".."z").to_a << " "
