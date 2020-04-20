require './lib/key'
require 'matrix'
require 'pry'
require 'date'

class Enigma
  attr_reader :offsets, :char_set, :ashift, :bshift, :cshift, :dshift, :key, :date

  def initialize
    @char_set = ("a".."z").to_a << " "
    @date = DateTime.now.strftime("%d%m%y")
    @key = Key.new
    @ashift = shift_create
    @bshift = shift_create
    @cshift = shift_create
    @dshift = shift_create
  end

  def encrypt(message, key, date = @date)
    encrypt_hash = {}
    encrypt_hash[:key] = key
    encrypt_hash[:date] = date
    code_shift = offset_combine(make_offsets(date), @key.prepare_key(key))
    full_shift_assign(code_shift)
    split_encryption = encryption(message_prep(message))
    encrypt_hash[:encryption] = message_clean_up(split_encryption)
    encrypt_hash
  end

  def make_offsets(date = @date)
    date_to_offset = date.to_i * date.to_i
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

  def offset_combine(offset, key)
    combine = [offset, key]
    combine.transpose.map(&:sum)
  end

  def full_shift_assign(code_shift)
    ashift_assign(code_shift)
    bshift_assign(code_shift)
    cshift_assign(code_shift)
    dshift_assign(code_shift)
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

  def message_prep(message)
    message_feeder = []
    message_array = message.split(//)
    message_array.each_slice(4) do |char|
      message_feeder << char
    end
    message_feeder
  end

  def encryption(message)
    complete_encrypt = []
    message.each do |group|
      if group.length == 4
        complete_encrypt << @ashift[group[0]]
        complete_encrypt << @bshift[group[1]]
        complete_encrypt << @cshift[group[2]]
        complete_encrypt << @dshift[group[3]]
      end
      if group.length == 3
        complete_encrypt << @ashift[group[0]]
        complete_encrypt << @bshift[group[1]]
        complete_encrypt << @cshift[group[2]]
      end
      if group.length == 2
        complete_encrypt << @ashift[group[0]]
        complete_encrypt << @bshift[group[1]]
      end
      if group.length == 1
        complete_encrypt << @ashift[group[0]]
      end
    end
    complete_encrypt
  end

  def message_clean_up(message)
    message.join
  end
end
