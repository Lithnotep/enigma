require './lib/enigma'

enigma = Enigma.new

handle = File.open(ARGV[0], "r")
incoming_encryption = handle.read
handle.close
decryption = enigma.decrypt(incoming_encryption, ARGV[2], ARGV[3])

writer = File.open(ARGV[1], "w")
writer.write(decryption[:decryption])

p "Created 'decrypted.txt' with the key #{decryption[:key]} and date #{decryption[:date]}"
