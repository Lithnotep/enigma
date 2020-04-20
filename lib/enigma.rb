require './lib/key'
require './lib/shift'
require 'matrix'
require 'pry'
require 'date'

class Enigma
  attr_reader :offsets, :char_set, :shift, :key, :date

  def initialize
    @char_set = ("a".."z").to_a << " "
    @date = DateTime.now.strftime("%d%m%y")
    @key = Key.new
    @shift = Shift.new
  end

  def encrypt(message, key, date = @date)
    encrypt_hash = {}
    encrypt_hash[:key] = key
    encrypt_hash[:date] = date
    code_shift = offset_combine(make_offsets(date), @key.prepare_key(key))
    @shift.full_shift_assign(code_shift)
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

  def offset_combine(offset, key)
    combine = [offset, key]
    combine.transpose.map(&:sum)
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
        complete_encrypt << @shift.ashift[group[0]]
        complete_encrypt << @shift.bshift[group[1]]
        complete_encrypt << @shift.cshift[group[2]]
        complete_encrypt << @shift.dshift[group[3]]
      end
      if group.length == 3
        complete_encrypt << @shift.ashift[group[0]]
        complete_encrypt << @shift.bshift[group[1]]
        complete_encrypt << @shift.cshift[group[2]]
      end
      if group.length == 2
        complete_encrypt << @shift.ashift[group[0]]
        complete_encrypt << @shift.bshift[group[1]]
      end
      if group.length == 1
        complete_encrypt << @shift.ashift[group[0]]
      end
    end
    complete_encrypt
  end

  def message_clean_up(message)
    message.join
  end
end
