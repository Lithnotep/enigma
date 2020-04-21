require 'date'
require 'pry'

class Shift
  attr_reader :char_set, :ashift, :bshift, :cshift, :dshift

  def initialize
    @char_set = ("a".."z").to_a << " "
    @ashift = shift_create
    @bshift = shift_create
    @cshift = shift_create
    @dshift = shift_create
  end

  def shift_create
    char_hash = Hash.new
    @char_set.each do |char|
      char_hash[char] = nil
    end
    char_hash
  end

  def symbol_assign
    symbols = ["!", "@", "#", "$", "%", "^", "&", "*"]
    symbols.each do |symbol|
      @ashift[symbol] = symbol
      @bshift[symbol] = symbol
      @cshift[symbol] = symbol
      @dshift[symbol] = symbol
    end
  end

  def shift_assign(code_shift, shift)
    shift_code = nil
    current_shift = nil
    if shift == :a
      shift_code = code_shift[0]
      current_shift = @ashift
    elsif  shift == :b
      shift_code = code_shift[1]
      current_shift = @bshift
    elsif shift == :c
      shift_code = code_shift[2]
      current_shift = @cshift
    elsif shift == :d
      shift_code = code_shift[3]
      current_shift = @dshift
    end
    paired_chars = @char_set.zip(@char_set.rotate(shift_code).cycle)
    paired_chars.each do |char|
      current_shift[char[0]] = char[1]
    end
  end

  def full_shift_assign(code_shift)
    shift_assign(code_shift, :a)
    shift_assign(code_shift, :b)
    shift_assign(code_shift, :c)
    shift_assign(code_shift, :d)
  end
end
