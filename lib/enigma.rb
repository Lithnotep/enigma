require 'matrix'
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
    current_date = DateTime.now.strftime("%d%m%y")
    date_to_offset = current_date.to_i * current_date.to_i
    offset_alter = date_to_offset.to_s.slice(-4..-1)
    offset = offset_alter.chars.map do |num|
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
    key_array = []
    5.times do
      rand_key << rand(0..9)
    end
    key_chars = rand_key.map do |num|
      num.to_s
    end
    key_array << key_chars.slice(0..1).join.to_i
    key_array << key_chars.slice(1..2).join.to_i
    key_array << key_chars.slice(2..3).join.to_i
    key_array << key_chars.slice(3..4).join.to_i
    key_array
  end

  def offset_combine
    combine = [@offsets, @key]
    combine.transpose.map(&:sum)
  end

  def ashift_assign(code_shift)
    paired_chars_a = @char_set.zip(@char_set.rotate(code_shift[0]).cycle)
    paired_chars_a.each do |char|
      @ashift[char[0]] = char[1]
    end
  end

  def bshift_assign(code_shift)
    paired_chars_b = @char_set.zip(@char_set.rotate(code_shift[1]).cycle)
    paired_chars_b.each do |char|
      @bshift[char[0]] = char[1]
    end
  end

  def cshift_assign(code_shift)
    paired_chars_c = @char_set.zip(@char_set.rotate(code_shift[2]).cycle)
    paired_chars_c.each do |char|
      @cshift[char[0]] = char[1]
    end
  end

  def dshift_assign(code_shift)
    paired_chars_d = @char_set.zip(@char_set.rotate(code_shift[3]).cycle)
    paired_chars_d.each do |char|
      @dshift[char[0]] = char[1]
    end
  end
end






# alphabet set ("a".."z").to_a << " "
