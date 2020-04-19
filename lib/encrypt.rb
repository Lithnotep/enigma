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

end
