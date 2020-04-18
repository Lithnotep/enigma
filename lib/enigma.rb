require 'pry'
require 'date'

class Enigma
  attr_reader :date, :char_set, :ashift, :bshift, :cshift, :dshift

  def initialize
    @char_set = ("a".."z").to_a << " "
    @date = make_date
    @ashift = shift_create
    @bshift = shift_create
    @cshift = shift_create
    @dshift = shift_create
  end


  def make_date
    current_date = DateTime.now.strftime("%d%m%Y")
    current_date.slice!(4..5)
    current_date
  end

  def shift_create
    char_hash = Hash.new
    @char_set.each do |char|
      char_hash[char] = nil
    end
    char_hash
  end




end

# alphabet set ("a".."z").to_a << " "
