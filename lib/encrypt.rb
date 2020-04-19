require './lib/enigma'
require 'pry'

class Encrypt < Enigma

  def message_prep(message)
    message_feeder = []
    message_array = message.split(//)
    message_array.each_slice(4) do |char|
      message_feeder << char
    end
    message_feeder
  end

  def user_input
    input = gets.chomp
    input.downcase
  end

  def encryption(message_prep)
    complete_encrypt = []
    message_prep.each do |group|
      if group.length == 4
        complete_encrypt << @ashift[group[0]]
        complete_encrypt << @bshift[group[1]]
        complete_encrypt << @cshift[group[2]]
        complete_encrypt << @dshift[group[3]]

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

end
