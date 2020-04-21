require './lib/key'
require './lib/shift'
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

  def encrypt(message, key = @key.current_key, date = @date)
    encrypt_hash = {}
    encrypt_hash[:key] = key
    encrypt_hash[:date] = date
    code_shift = offset_combine(make_offsets(date), @key.prepare_key(key))
    @shift.full_shift_assign(code_shift)
    split_cryption = cryption(message_prep(message), :encrypt)
    encrypt_hash[:encryption] = message_clean_up(split_cryption)
    encrypt_hash
  end

  def decrypt(message, key = key = @key.current_key, date = @date)
    encrypt_hash = {}
    encrypt_hash[:key] = key
    encrypt_hash[:date] = date
    code_shift = offset_combine(make_offsets(date), @key.prepare_key(key))
    @shift.full_shift_assign(code_shift)
    split_cryption = cryption(message_prep(message), :decrypt)
    encrypt_hash[:decryption] = message_clean_up(split_cryption)
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
    message_array = message.downcase.split(//)
    message_array.each_slice(4) do |char|
      message_feeder << char
    end
    message_feeder
  end

  def cryption_feeder(encrypt_decrypt)
    if encrypt_decrypt == :encrypt
    [@shift.ashift, @shift.bshift, @shift.cshift, @shift.dshift]
    elsif encrypt_decrypt == :decrypt
    [@shift.ashift.invert, @shift.bshift.invert, @shift.cshift.invert, @shift.dshift.invert]
    end
  end

  def cryption(message, encrypt_decrypt)
    complete_encrypt = []
    message.each do |group|
        iter = 0
        cryption_feeder(encrypt_decrypt).each do |hash|
          complete_encrypt << hash[group[iter]]
          iter += 1
        end
    end
    complete_encrypt.compact
  end

  def message_clean_up(message)
    message.join
  end
end
