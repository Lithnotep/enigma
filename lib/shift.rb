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


end

# def shift_create
#   char_hash = Hash.new
#   @char_set.each do |char|
#     char_hash[char] = nil
#   end
#   char_hash
# end

# def full_shift_assign(code_shift)
#   ashift_assign(code_shift)
#   bshift_assign(code_shift)
#   cshift_assign(code_shift)
#   dshift_assign(code_shift)
# end
#
# def ashift_assign(code_shift)
#   paired_chars_a = @char_set.zip(@char_set.rotate(code_shift[0]).cycle)
#   paired_chars_a.each do |char|
#     @ashift[char[0]] = char[1]
#   end
# end
#
# def bshift_assign(code_shift)
#   paired_chars_b = @char_set.zip(@char_set.rotate(code_shift[1]).cycle)
#   paired_chars_b.each do |char|
#     @bshift[char[0]] = char[1]
#   end
# end
#
# def cshift_assign(code_shift)
#   paired_chars_c = @char_set.zip(@char_set.rotate(code_shift[2]).cycle)
#   paired_chars_c.each do |char|
#     @cshift[char[0]] = char[1]
#   end
# end
#
# def dshift_assign(code_shift)
#   paired_chars_d = @char_set.zip(@char_set.rotate(code_shift[3]).cycle)
#   paired_chars_d.each do |char|
#     @dshift[char[0]] = char[1]
#   end
# end
