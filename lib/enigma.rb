require 'pry'
require 'date'

class Enigma
  attr_reader :date

  def initialize
    @date = DateTime.now.strftime("%d%m%Y")
  end

end

# alphabet set ("a".."z").to_a << " "
