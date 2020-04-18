require 'pry'
require 'date'

class Enigma
  attr_reader :date

  def initialize
    @date = make_date
  end


  def make_date
    current_date = DateTime.now.strftime("%d%m%Y")
    current_date.slice!(4..5)
    current_date
  end


end

# alphabet set ("a".."z").to_a << " "
