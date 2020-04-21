require './lib/enigma'

enigma = Enigma.new

handle = File.open(ARGV[0], "r")
incoming_message = handle.read
handle.close
encryption = enigma.encrypt(incoming_message)

writer = File.open(ARGV[1], "w")
writer.write(encryption)

p "Created 'encrypted.txt' with the key #{encryption[:key]} and date #{encryption[:date]}"
