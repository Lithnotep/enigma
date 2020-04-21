require './lib/enigma'

enigma = Enigma.new


handle = File.open(AGRV[0], "r")

incoming_message = handle.read

handle.close

writer = 
